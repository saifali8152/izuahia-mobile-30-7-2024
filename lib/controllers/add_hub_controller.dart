import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddHubController extends GetxController {
  GlobalKey<FormState>? hubFormKey;
  TextEditingController? hubNameController;
  TextEditingController? descriptionController;
  TextEditingController? locationController;
  TextEditingController? addressController;
  TextEditingController? emailController;
  TextEditingController? phoneController;

  RxString latitude = RxString('0.0');
  RxString longitude = RxString('0.0');
  var uuid = const Uuid();
  String sessionToken = '123456';

  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final picker = ImagePicker();
  String base64Image = '';


  List<dynamic> placesList = [];

  CreateRequestRepo hubRepo = CreateRequestRepo();

  bool listenerAdded = true;

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

  @override
  void onInit() {
    super.onInit();
    hubFormKey = GlobalKey<FormState>();
    hubNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();

    locationController!.addListener(
      listener,
    );
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

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> showImageSourceSelectionDialog() async {
    Get.defaultDialog(
      title: 'Select Image Source',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Picture'),
            onTap: () async {
              Get.back();
              await pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Pick from Gallery'),
            onTap: () async {
              Get.back();
              await pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Future<void> createNewHub() async {
    await hubRepo.addServiceHub(
      hubName: hubNameController!.text,
      description: descriptionController!.text,
      phone: phoneController!.text,
      email: emailController!.text,
      address: addressController!.text,
      latitude: latitude.value,
      longitude: longitude.value,
      location: locationController!.text,
      image: image,
    );
  }
}
