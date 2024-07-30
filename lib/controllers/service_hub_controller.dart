import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/models/hub_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ServiceHubController extends GetxController {
  TextEditingController currencyController = TextEditingController();
  TextEditingController serviceNameTextController = TextEditingController();
  TextEditingController? serviceHubController = TextEditingController();
  TextEditingController? hubNameController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? serviceHubWebsiteController = TextEditingController();
  TextEditingController? locationController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<HubDatum> hubs = RxList();
  bool listenerAdded = true;
  String sessionToken = '123456';
  var uuid = const Uuid();
  List<dynamic> placesList = [];
  RxString latitude = RxString('0.0');
  RxString longitude = RxString('0.0');
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final picker = ImagePicker();
  CreateRequestRepo serviceRepo = CreateRequestRepo();
  CreateRequestRepo hubRepo = CreateRequestRepo();
 @override
  void onInit() {
    super.onInit();
    locationController!.addListener(
      listener,
    );
  }

  void turnOnListener() {
    listenerAdded = true;
    update();
  }

  void turnOffListener() {
    listenerAdded = false;
    update();
  }

  Future<void> selectHub() async {
    isLoading.value = true;
    hubs.value = await serviceRepo.selectHub();
    serviceHubController!.text = hubs[0].shId;
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

    getSuggestions(locationController!.text);
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

  
  Future<void> createNewHub() async {
    await hubRepo.addServiceHub(
      hubName: hubNameController!.text,
      description: descriptionController!.text,
      phone: phoneController!.text,
      email: emailController!.text,
      address: serviceHubWebsiteController!.text,
      latitude: latitude.value,
      longitude: longitude.value,
      location: locationController!.text,
      image: image,
    );
  }
}
