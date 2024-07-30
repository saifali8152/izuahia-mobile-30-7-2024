import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddInventoryRequestController extends GetxController {
  GlobalKey<FormState>? inventoryeRequestFormKey;
  TextEditingController? inventoryNameController;
  TextEditingController? itemColorController;
  TextEditingController? sizeController;
  TextEditingController? overviewController;
  TextEditingController? featuresController;
  TextEditingController? specificationsController;
  TextEditingController? deliveryTermsController;
  TextEditingController? descriptionController;
  TextEditingController? conditionController;
  TextEditingController? quantityController;
  TextEditingController? locationController;
  TextEditingController? inventoryTypeController;
  TextEditingController? inventoryBudgetController;
  List<String> inventoryImages = [];

  RxString latitude = RxString('0.0');
  RxString longitude = RxString('0.0');
  var uuid = const Uuid();
  String sessionToken = '123456';

  var images = <File>[].obs;
  String base64Image = '';

  final picker = ImagePicker();

  List<dynamic> placesList = [];

  CreateRequestRepo inventoryRequestRepo = CreateRequestRepo();

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
    inventoryeRequestFormKey = GlobalKey<FormState>();

    inventoryNameController = TextEditingController();
    itemColorController = TextEditingController();
    sizeController = TextEditingController();
    overviewController = TextEditingController();
    featuresController = TextEditingController();
    specificationsController = TextEditingController();
    deliveryTermsController = TextEditingController();
    conditionController = TextEditingController();
    descriptionController = TextEditingController();
    quantityController = TextEditingController();
    locationController = TextEditingController();
    inventoryTypeController = TextEditingController();
    inventoryBudgetController = TextEditingController();

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

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      images.value = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    } else {
      print('No images selected.');
    }
  }

  List<String> convertImagesAsBase64() {
    List<String> base64Images = images.map((image) {
      final bytes = image.readAsBytesSync();
      return base64Encode(bytes);
    }).toList();

    return base64Images;
  }

  Future<void> createInventoryRequest() async {
    await inventoryRequestRepo.addInventoryRequest(
      inventoryName: inventoryNameController!.text,
      itemColor: itemColorController!.text,
      size: sizeController!.text,
      inventoryBudget: inventoryBudgetController!.text,
      overview: overviewController!.text,
      condition: conditionController!.text,
      features: featuresController!.text,
      specifications: specificationsController!.text,
      deliveryTerms: deliveryTermsController!.text,
      description: descriptionController!.text,
      inventoryType: inventoryTypeController!.text,
      quantity: quantityController!.text,
      location: locationController!.text,
      latitude: latitude.value,
      longitude: longitude.value,
      inventoryImages: images,
    );
  }
}
