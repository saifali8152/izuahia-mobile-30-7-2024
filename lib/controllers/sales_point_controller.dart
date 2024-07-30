import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/models/sales_point_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class SalesPointController extends GetxController {
  TextEditingController currencyController = TextEditingController();
  TextEditingController serviceNameTextController = TextEditingController();
  TextEditingController? salesPointIdController = TextEditingController();
  TextEditingController? salesPointNameController = TextEditingController();
  TextEditingController? salesPointPhoneNumberController =
      TextEditingController();
  TextEditingController? salesPointemailController = TextEditingController();
  TextEditingController? salesPointWebsiteController = TextEditingController();
  TextEditingController? salesPointLocationController = TextEditingController();
  TextEditingController? salesPointDescriptionController =
      TextEditingController();
  RxBool isSalesPointLoading = false.obs;
  RxList<SalesPointDatum> salesPointList = RxList();
  bool listenerAdded = true;
  CreateRequestRepo inventoryRequestRepo = CreateRequestRepo();
  String sessionToken = '123456';
  var uuid = const Uuid();
  List<dynamic> placesList = [];
  RxString latitude = RxString('0.0');
  RxString longitude = RxString('0.0');
  final picker = ImagePicker();
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  GlobalKey<FormState>? salesPointDescriptionFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    salesPointLocationController!.addListener(
      listener,
    );
  }

  Future<void> selectSalesPoint() async {
    isSalesPointLoading.value = true;
    salesPointList.value = await inventoryRequestRepo.selectSalesPoint();
    salesPointIdController!.text = salesPointList[0].spId;
    isSalesPointLoading.value = false;
  }

  listener() {
    onChanged();
  }

  void onChanged() {
    // ignore: unnecessary_null_comparison, prefer_conditional_assignment
    if (sessionToken == null) {
      sessionToken = uuid.v4();
    }

    getSuggestions(salesPointLocationController!.text);
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

  Future<void> createNewsalesPoint() async {
    await inventoryRequestRepo.addNewSalesPoint(
      salesPointName: salesPointNameController!.text,
      description: salesPointDescriptionController!.text,
      phone: salesPointPhoneNumberController!.text,
      email: salesPointemailController!.text,
      address: salesPointWebsiteController!.text,
      latitude: latitude.value,
      longitude: longitude.value,
      location: salesPointLocationController!.text,
      image: image,
    );
  }
}
