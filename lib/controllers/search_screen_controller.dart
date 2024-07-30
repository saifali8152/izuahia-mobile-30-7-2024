import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/home_model.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/repository/search_repo.dart';

class SearchScreenController extends GetxController {
  SearchRepo repo = SearchRepo();
  RxBool isLoading = true.obs;
  RxBool isSearchActive = true.obs;

  var expandedIndex = (-1).obs;
  final scrollController = ScrollController();

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
      scrollToExpandedPanel(index);
    }
  }

  void scrollToExpandedPanel(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        index * (Get.height * 0.35 + 50), // Adjust as per the approximate height of your panel
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void toggleSearch() {
    isSearchActive.value = !isSearchActive.value;
    update();
  }

  RxList<HomeServiceModel> serviceList = RxList();
  RxList<HomeRequestModel> requestList = RxList();
  RxList<HomeInventoryModel> inventoryList = RxList();

  TextEditingController serchStringController = TextEditingController();
  RxString searchString = ''.obs;

  Future<void> getSearchData() async {
    searchString.value = serchStringController.text;
    isLoading.value = true;
    HomeApiModel? response = await repo.getSearchData(
      searchString: serchStringController.text,
    );
    serviceList.assignAll(response.allServices);
    requestList.assignAll(response.allRequests);
    inventoryList.assignAll(response.allInventories);
    isLoading.value = false;
    update();
  }
}
