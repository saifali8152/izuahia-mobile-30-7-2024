import 'dart:developer';

import 'package:get/get.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/repository/home_repo.dart';

class HomeRequestsController extends GetxController {
  List<HomeRequestModel> allRequestsList = [];
  RxList<HomeRequestModel> filteredRequestsList = RxList(); // RxList for reactivity

  HomeRepo repo = HomeRepo();
  RxBool isLoading = true.obs;
  Rx<String> searchString = ''.obs;

  @override
  void onInit() {
    getAllRequests();
    super.onInit();
  }

  void setSearchString(String value) {
    searchString.value = value.toLowerCase();
    filterRequests();
  }

  void filterRequests() {
    String search = searchString.value;

    final filteredList = allRequestsList.where((request) {
      bool matchesSearch = false;
      if (request.requestType == 'inventory') {
        matchesSearch = search.isEmpty || request.inventoryName!.toLowerCase().contains(search);
      } else {
        matchesSearch = request.serviceName!.toLowerCase().contains(search);
      }
      return matchesSearch;
    }).toList();

    filteredRequestsList.assignAll(filteredList); // Update filteredRequestsList
    log("search: $search filtered list: \n $filteredRequestsList");
  }

  Future<void> getAllRequests() async {
    allRequestsList = await repo.getAllRequests();
    filteredRequestsList.assignAll(allRequestsList); // Initialize filteredRequestsList
    isLoading.value = false;
  }
}

