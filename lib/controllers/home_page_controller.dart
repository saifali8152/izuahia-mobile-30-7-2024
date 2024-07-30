import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as gc;
import 'package:izuahia/models/home_model.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/repository/home_repo.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';

class HomeScreenController extends GetxController {
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxBool isLoading = true.obs;

  RxList<HomeServiceModel> serviceList = RxList();
  RxList<HomeRequestModel> requestList = RxList();
  RxList<HomeInventoryModel> inventoryList = RxList();

  @override
  void onInit() {
    super.onInit();
    getLocationAndData();
  }

  Future<void> getLocationAndData() async {
    if (SharedPrefs().getBool('default_location_set') != null && SharedPrefs().getBool('default_location_set') != false) {
      await getHomeData();
    } else {
      await getUserLocation();
      await getHomeData();
    }
    isLoading.value = false;
    update();
  }

  Future<Map<String, dynamic>> getIpLocationData() async {
    try {
      final userIpAddress = await getUserIPAddress();
      if (userIpAddress == null) {
        return {'country_name': 'Nigeria'};
      }
      final response = await http.get(Uri.parse('https://api.iplocation.net/?ip=$userIpAddress'));
      final data = jsonDecode(response.body);
      if (data['response_code'] == '200') {
        return data;
      } else {
        return {'country_name': 'United States'};
      }
    } catch (error, stackTrace) {
      log("Exception in fetching user location: $stackTrace");
      return {'country_name': 'Nigeria'};
    }
  }

  Future<String?> getUserIPAddress() async {
    try {
      final res = await http.get(Uri.parse('https://icanhazip.com/'));
      final data = res.body;

      return data.toString().substring(0, data.toString().length - 1);
    } catch (error) {
      return null;
    }
  }

  Future<Position> getPosition() async {
    try {
      final pos = await Geolocator.getCurrentPosition();
      latitude.value = pos.latitude.toString();
      longitude.value = pos.longitude.toString();
      await SharedPrefs().setString('latitude', latitude.value);
      await SharedPrefs().setString('longitude', longitude.value);
      return pos;
    } catch (error, stackTrace) {
      log('Error fetching location ${error.toString()} $stackTrace');
      rethrow;
    }
  }

  Future getUserLocation() async {
    await Geolocator.isLocationServiceEnabled();
    if (await hasLocationPermission()) {
      await getPosition();
    } else {
      await getLocationByIpAddress();
    }
    await getAddress(double.parse(latitude.value), double.parse(longitude.value));
    log('lati $latitude longi: $longitude');
  }

  Future<void> getLocationByIpAddress() async {
    final countryData = await getIpLocationData();
    final String countryName = countryData['country_name'] as String;
    final response = await gc.locationFromAddress(countryName);
    final countryLocation = response[0];
    latitude.value = countryLocation.latitude.toString();
    longitude.value = countryLocation.longitude.toString();
  }

  Future openSettingsIfLocationNotAllowed(BuildContext context) async {
    final hasPermission = await hasLocationPermission();
    if (hasPermission && context.mounted) {
      _showLocationPermissionDialog(context);
    }
    // if (!model.locationFetched) {
    //   bloc.add(FetchLocationEvent());
    // }
  }

  Future<String> getAddress(double latitude, double longitude) async {
    String address = '';
    try {
      final List<gc.Placemark> placemarkers = await gc.placemarkFromCoordinates(
        latitude,
        longitude,
      );
      gc.Placemark placemark;
      if (Platform.isAndroid) {
        placemark = placemarkers[1];
      } else {
        placemark = placemarkers[0];
      }
      if (placemark.street != null) {
        final String city = placemark.locality ?? "";
        final String state = placemark.administrativeArea ?? "";
        final String country = placemark.country ?? "";
        if (placemark.street!.isEmpty) {
          address =
              '${placemark.subThoroughfare ?? ''}, ${placemark.thoroughfare ?? ''}, $city, $state, $country ${placemark.postalCode ?? ''}';
        } else {
          address =
              '${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, ${placemark.thoroughfare ?? ''}, $city, $state, $country, ${placemark.postalCode ?? ''}';
        }
      }
      address.replaceAll(',,', ', ');
      if (address.startsWith(',')) {
        address.replaceFirst(',', '');
      }
      return address;
    } catch (error) {
      log(error.toString());
      return address;
    }
  }

  Future fetchLocationAfterOpenSettings(BuildContext context) async {
    final hasPermission = await hasLocationPermission();
    if (hasPermission && context.mounted) {
      _showLocationPermissionDialog(context);
    } else {}
  }

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission'),
          content: const Text('Location permission is not allowed. Please open settings to enable it.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Geolocator.openLocationSettings().then((value) => Get.back());
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Future openSettings(BuildContext context) async {
  //   if (context.mounted) {
  //     showCustomAlertDialogWithButtons(
  //       context: context,
  //       title: '${HelperFunctions.upperCaseFirstLetter(kFlavour.unionName)} needs location access',
  //       text: 'You currently have location permission turned off for this application. You can open Settings to enable them.',
  //       secondaryButton: CustomElevatedDialogButton(
  //         onPressed: (_) async {
  //           await Geolocator.openLocationSettings().then((value) => Navigator.of(context).pop());
  //         },
  //         label: 'Open Settings',
  //         backgroundColor: model.appModel.primaryTextColor,
  //       ),
  //       primaryButton: CustomElevatedDialogButton(
  //         key: const ValueKey('cancel_notification_permission_button'),
  //         onPressed: (BuildContext context) async {
  //           Navigator.pop(context);
  //         },
  //         label: LocalizationsKeys.cancel.translate(context),
  //         textColor: model.appModel.primaryTextColor,
  //       ),
  //       primaryTextColor: model.appModel.primaryTextColor,
  //       secondaryLogoImageUrl: model.appModel.secondaryLogoImage,
  //       defaultLayout: model.appModel.defaultAppearance,
  //     );
  //   }
  // }

  Future<bool> hasLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (<LocationPermission>[LocationPermission.denied, LocationPermission.deniedForever].contains(permission)) {
      permission = await Geolocator.requestPermission();
      if (<LocationPermission>[LocationPermission.denied, LocationPermission.deniedForever].contains(permission)) {
        return false;
      }
    }
    return true;
  }

  Future<void> getHomeData() async {
    log('coordinates: ${SharedPrefs().getString('latitude')}, ${SharedPrefs().getString('longitude')}');
    HomeRepo repo = HomeRepo();
    HomeApiModel? response = await repo.getHomeData(
      latitude: SharedPrefs().getString('latitude') ?? latitude.value,
      longitude: SharedPrefs().getString('longitude') ?? longitude.value,
    );
    serviceList.assignAll(response.allServices);
    requestList.assignAll(response.allRequests);
    inventoryList.assignAll(response.allInventories);
  }
}
