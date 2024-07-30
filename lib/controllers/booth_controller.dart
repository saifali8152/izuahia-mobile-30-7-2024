import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/models/sales_point_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SalesPointBoothController extends GetxController {
  RxList<SalesPointDatum> salesPointList = RxList();
  RxBool isLoading = false.obs;
  TextEditingController? salesPointController = TextEditingController();
  CreateRequestRepo boothRepo = CreateRequestRepo();
  String sessionToken = '123456';
  var uuid = const Uuid();
  bool listenerAdded = true;
  List<dynamic> placesList = [];
  RxString latitude = RxString('0.0');
  RxString longitude = RxString('0.0');
  final picker = ImagePicker();
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  TextEditingController? boothNameController = TextEditingController();
  TextEditingController? boothPhoneController = TextEditingController();
  TextEditingController? boothEmailController = TextEditingController();
  TextEditingController? boothAddressController = TextEditingController();
  TextEditingController? boothLocationController = TextEditingController();
  TextEditingController? boothDescriptionController = TextEditingController();
  TextEditingController? currencyController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    selectSalesPoint();
    boothLocationController!.addListener(
      listener,
    );
  }

  Future<void> selectSalesPoint() async {
    isLoading.value = true;
    salesPointList.value = await boothRepo.selectSalesPoint();
    // salesPointController!.text = salesPointList[0].spId;
    isLoading.value = false;
  }

  listener() {
    onChanged();
  }

  void onChanged() {
    // ignore: unnecessary_null_comparison, prefer_conditional_assignment
    if (sessionToken == null) {
      sessionToken = uuid.v4();
    }

    getSuggestions(boothLocationController!.text);
  }

  void getSuggestions(String locationInput) async {
    String kPLACES_API_KEY = 'AIzaSyAJqWJNX_nUocDT2Q-QPHiJZcCyAU34fm0';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$locationInput&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      placesList = jsonDecode(response.body.toString())['predictions'];
      update();
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void turnOnListener() {
    listenerAdded = true;
    update();
  }

  void turnOffListener() {
    listenerAdded = false;
    update();
  }

  Future<void> getLatLongFromPlaceId(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      latitude = RxString(locations[0].latitude.toString());
      longitude = RxString(locations[0].longitude.toString());

      log('coordinates:  $latitude $longitude');
      update();
      // Handle errors or no results here
      // return null;
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      // return null;
    }
  }

  Future<void> showImageSourceSelectionDialog() async {
    Get.defaultDialog(
      title: 'Select Image Source',
      content: ListTile(
        leading: const Icon(Icons.photo_library),
        title: const Text('Pick from Gallery'),
        onTap: () async {
          Get.back();
          await pickImage(ImageSource.gallery);
        },
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> createNewbooth() async {
    await boothRepo.addNewBooth(
      spId: salesPointController!.text,
      boothName: boothNameController!.text,
      description: boothDescriptionController!.text,
      phone: boothPhoneController!.text,
      email: boothEmailController!.text,
      address: boothAddressController!.text,
      latitude: latitude.value,
      longitude: longitude.value,
      location: boothLocationController!.text,
      image: image,
      currency: currencyController!.text,
    );
  }
}
