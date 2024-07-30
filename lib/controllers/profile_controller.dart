import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {

  TextEditingController? locationController;

  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final picker = ImagePicker();

  RxString latitude = RxString('0.0');
  RxString longitude = RxString('0.0');
  var uuid = const Uuid();
  String sessionToken = '123456';
  List<dynamic> placesList = [];
  RxBool isSwitched = false.obs;

  bool listenerAdded = true;
  RxBool isLocationSelected = RxBool(
    SharedPrefs().getBool('default_location_set') ?? false,
  );

  void turnOffListener() {
    listenerAdded = false;
    update();
  }

  void turnOnListener() {
    listenerAdded = true;
    update();
  }

  listener() {
    onChanged();
  }

  void onChanged() {
    // ignore: unnecessary_null_comparison, prefer_conditional_assignment
    if (sessionToken == null) {
      sessionToken = uuid.v4();
    }

    getSuggestions(locationController!.text);
  }

  void getSuggestions(String locationInput) async {
    String kPLACES_API_KEY = 'AIzaSyAJqWJNX_nUocDT2Q-QPHiJZcCyAU34fm0';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$locationInput&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      placesList = jsonDecode(response.body.toString())['predictions'];
      update();
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<void> getLatLongFromPlaceId(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      latitude = RxString(locations[0].latitude.toString());
      longitude = RxString(locations[0].longitude.toString());

      await SharedPrefs().setString('latitude', latitude.value);
      await SharedPrefs().setString('longitude', longitude.value);
      await SharedPrefs().setBool('default_location_set', true);

      log('coordinates:  $latitude $longitude');
      update();
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  void onInit() {
    locationController = TextEditingController();
    locationController!.text = SharedPrefs().getString('default_location') ?? "";

    locationController!.addListener(
      listener,
    );

    super.onInit();
  }


  void clearLocation() {
    locationController!.clear();
    isLocationSelected.value = false;
    locationController!.addListener(listener);
    turnOnListener();
    update();
  }
}
