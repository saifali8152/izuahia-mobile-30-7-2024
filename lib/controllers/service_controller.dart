import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:map_launcher/map_launcher.dart';

class ServiceController extends GetxController {
  TextEditingController commentController = TextEditingController();
  CreateRequestRepo repo = CreateRequestRepo();

  List<HomeServiceModel> allServicesList = [];
  RxList<HomeServiceModel> filteredServicesList = RxList();

  RxBool isLoading = true.obs;
  Rx<String> searchString = ''.obs;

  @override
  void onInit() {
    getAllServices();
    super.onInit();
  }

  Future<void> launchMap({
    required String latitude,
    required String longitude,
    required String serviceName,
    required String fullAddress,
  }) async {
    final isMapAvailable = await MapLauncher.isMapAvailable(MapType.google);
    if (isMapAvailable != null && isMapAvailable) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(double.parse(latitude), double.parse(longitude)),
        title: serviceName,
        description: fullAddress,
      );
    } else {
      log("Google Maps is not available");
    }
  }

  void setSearchString(String value) {
    searchString.value = value.toLowerCase();
    filterRequests();
  }

  void filterRequests() {
    String search = searchString.value;

    final filteredList = allServicesList.where((request) {
      bool matchesSearch = false;
      matchesSearch = request.serviceName.toLowerCase().contains(search);

      return matchesSearch;
    }).toList();

    filteredServicesList.assignAll(filteredList); // Update filteredRequestsList
    log("search: $search filtered list: \n $filteredServicesList");
  }

  Future<void> addServiceComment({required String serviceId}) async {
    await repo.addServiceComment(
      comment: commentController.text,
      serviceId: serviceId,
    );
  }

  Future<void> addServiceToFavorites({required String serviceId}) async {
    await repo.addServiceToFavorites(serviceId: serviceId);
  }

  Future<void> getAllServices() async {
    allServicesList = await repo.getAllServices();
    filteredServicesList.assignAll(allServicesList); 
    isLoading.value = false;
  }
}
