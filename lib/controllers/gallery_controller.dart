import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izuahia/models/gallery_model.dart';
import 'package:izuahia/repository/gallery_repo.dart';

class GalleryController extends GetxController {
  RxBool isLoading = RxBool(true);
  RxBool isImageOperationLoading = RxBool(false);
  RxBool imageDeleted = RxBool(false);
  RxBool imageAdded = RxBool(false);

  final Rx<File?> _image = Rx<File?>(null);
  RxList<GalleryData> galleryImagesList = RxList();

  File? get image => _image.value;
  final picker = ImagePicker();

  GalleryRepo repo = GalleryRepo();

  @override
  void onInit() {
    getGalleryImages();
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    } else {
      log('No image selected.');
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

  Future<void> getGalleryImages() async {
    galleryImagesList.value = await repo.getUserGallery();
    isLoading.value = false;
    _image.value = null;
    update();
  }

  Future<void> deleteGalleryImage({required String userGalleryId}) async {
    isImageOperationLoading.value = true;
    imageDeleted.value = await repo.deleteFromGallery(userGalleryId: userGalleryId);
    if (imageDeleted.value) {
      galleryImagesList.removeWhere((galleryData) => galleryData.ugId == userGalleryId);
    }
    isImageOperationLoading.value = false;
    update();
  }

  Future<void> addGalleryImage() async {
    imageAdded.value = false;
    imageAdded.value = await repo.addUserGallery(image: image);
    update();
  }
}
