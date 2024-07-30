import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';

class InventoryController extends GetxController {
  TextEditingController commentController = TextEditingController();
  TextEditingController bidPriceController = TextEditingController();
  TextEditingController negotiationPriceController = TextEditingController();
  TextEditingController negotiationTextController = TextEditingController();

  GlobalKey<FormState> negotiationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> bidFormKey = GlobalKey<FormState>();

  CreateRequestRepo repo = CreateRequestRepo();

  RxString fileNameController = ''.obs;
  FilePickerResult? result;
  Rx<File?> negotiationFile = Rx<File?>(null);
  RxInt cartCount = 1.obs;

  List<HomeInventoryModel> allInventoriesList = [];
  RxList<HomeInventoryModel> filteredInventoriesList = RxList();

  RxBool isLoading = true.obs;
  Rx<String> searchString = ''.obs;

  @override
  void onInit() {
    getAllInventories();
    super.onInit();
  }

  void increment() {
    cartCount.value++;
    update();
  }

  void decrement() {
    if (cartCount.value > 1) {
      cartCount.value--;
      update();
    }
  }

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'txt',
        'jpg',
        'jpeg',
        'png',
      ],
      allowMultiple: false,
    );
    if (result != null) {
      negotiationFile.value = File(result!.files.single.path!);
      fileNameController.value = (negotiationFile.value!.path.split("/").last);
    }
    update();
  }

  Future<void> addInventoryComment({required String inventoryId}) async {
    await repo.addInventoryComment(
      comment: commentController.text,
      inventoryId: inventoryId,
    );
  }

  Future<void> addInventoryToFavorites({required String inventoryId}) async {
    await repo.addInventoryToFavorites(inventoryId: inventoryId);
  }

  Future<void> addInventoryBid({required String inventoryId}) async {
    await repo.addInventoryBid(inventoryId: inventoryId, bidPrice: bidPriceController.text);
  }

  Future<void> addInventoryNegotiation({required String inventoryId}) async {
    await repo.addInventoryNegotiation(
      inventoryId: inventoryId,
      negotiationPrice: negotiationPriceController.text,
      negotiationText: negotiationTextController.text,
      negotiationFile: negotiationFile.value,
    );
  }

  Future<String> addToCart({
    required String inventoryId,
    required String boothId,
    String isDelete = "0",
  }) async {
    return (await repo.addToCart(
      inventoryId: inventoryId,
      boothId: boothId,
      quantity: cartCount.value.toString(),
      isDelete: isDelete,
    ));
  }

  void setSearchString(String value) {
    searchString.value = value.toLowerCase();
    filterRequests();
  }

  void filterRequests() {
    String search = searchString.value;

    final filteredList = allInventoriesList.where((request) {
      bool matchesSearch = false;
      matchesSearch = request.inventoryName.toLowerCase().contains(search);

      return matchesSearch;
    }).toList();

    filteredInventoriesList.assignAll(filteredList); // Update filteredRequestsList
    log("search: $search filtered list: \n $filteredInventoriesList");
  }

  Future<void> getAllInventories() async {
    allInventoriesList = await repo.getAllInventories();
    filteredInventoriesList.assignAll(allInventoriesList);
    isLoading.value = false;
  }
}
