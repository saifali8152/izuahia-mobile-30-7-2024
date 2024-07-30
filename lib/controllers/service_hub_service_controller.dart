import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/models/hub_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';

class HubServiceController extends GetxController {
  RxList<HubDatum> hubs = RxList();
  RxBool isLoading = false.obs;
  TextEditingController? serviceHubController = TextEditingController();
  TextEditingController? serviceNameController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  TextEditingController? currencyController = TextEditingController();
  CreateRequestRepo serviceRepo = CreateRequestRepo();
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    selectHub();
  }

  Future<void> selectHub() async {
    isLoading.value = true;
    hubs.value = await serviceRepo.selectHub();
    serviceHubController!.text = hubs[0].shId;
    isLoading.value = false;
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

  Future<void> createNewService() async {
    await serviceRepo.addNewService(
      shId: serviceHubController!.text,
      serviceName: serviceNameController!.text,
      description: descriptionController!.text,
      image: image,
      currency: currencyController!.text,
    );
  }
}
