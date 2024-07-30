import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/models/bids_model.dart';
import 'package:izuahia/repository/profile_repo.dart';
import 'package:izuahia/utils/helper_functions.dart';

class BidsController extends GetxController {
  ProfileRepo repo = ProfileRepo();

  List<BidsModel> allBids = [];
  RxList<BidsModel> filteredBidsList = RxList();

  RxBool isLoading = true.obs;
  Rx<String> searchString = ''.obs;

  Rx<String> fromDate = ''.obs; // Initialize as empty string
  Rx<String> toDate = ''.obs; // Initialize as empty string

  @override
  void onInit() {
    getAllBids();
    super.onInit();
  }

  void setSearchString(String value) {
    searchString.value = value.toLowerCase();
    filterBids();
  }

  void setFromDate(BuildContext context) async {
    fromDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterBids();
  }

  void setToDate(BuildContext context) async {
    toDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterBids();
  }

  void filterBids() {
    DateTime? from;
    DateTime? to;
    if (fromDate.value.isNotEmpty) {
      from = DateFormat('yyyy-MM-dd').parse(fromDate.value);
    }
    if (toDate.value.isNotEmpty) {
      to = DateFormat('yyyy-MM-dd').parse(toDate.value);
    }
    String search = searchString.value;

    final filteredList = allBids.where((bid) {
      bool matchesDate = true;
      if (from != null) {
        DateTime bidDate = DateFormat('yyyy-MM-dd').parse(bid.createdAt);
        matchesDate = bidDate.isAfter(from) || bidDate.isAtSameMomentAs(from);
      }
      if (to != null) {
        DateTime bidDate = DateFormat('yyyy-MM-dd').parse(bid.createdAt);
        matchesDate = bidDate.isBefore(to) || bidDate.isAtSameMomentAs(to);
      }
      bool matchesSearch = bid.inventoryName.toLowerCase().contains(search);
      return matchesDate && matchesSearch;
    }).toList();

    filteredBidsList.assignAll(filteredList);
    update();
    log("from $from to: $to search: $search filtered list: \n $filteredList");
  }

  Future<void> getAllBids() async {
    allBids = await repo.getAllBids();
    filteredBidsList.assignAll(allBids);
    isLoading.value = false;
    update();
  }
}
