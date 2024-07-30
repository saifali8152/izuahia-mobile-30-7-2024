import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/hub_model.dart';
import 'package:izuahia/models/sales_point_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = RxInt(0);
  RxList<SalesPointDatum> salesPointList = RxList();
  RxBool isSalesPointLoading = false.obs;
  CreateRequestRepo requestRepo = CreateRequestRepo();
  TextEditingController? salesPointIdController = TextEditingController();
  TextEditingController? serviceHubController = TextEditingController();
  RxBool isLoading = false.obs;
   RxList<HubDatum> hubs = RxList();

  set setCurrentIndex(int val) {
    currentIndex.value = val;
    update();
  }

  Future<void> selectSalesPoint() async {
    isSalesPointLoading.value = true;
    salesPointList.value = await requestRepo.selectSalesPoint();
    // salesPointIdController!.text = salesPointList[0].spId;
    isSalesPointLoading.value = false;
  }

  Future<void> selectHub() async {
    isLoading.value = true;
    hubs.value = await requestRepo.selectHub();
    // serviceHubController!.text = hubs[0].shId;
    isLoading.value = false;
  }
}
