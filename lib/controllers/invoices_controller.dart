import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/models/invoices_model.dart';
import 'package:izuahia/repository/profile_repo.dart';
import 'package:izuahia/utils/helper_functions.dart';

class InvoicesController extends GetxController {
  ProfileRepo repo = ProfileRepo();

  List<InvoicesModel> allInvoices = [];
  RxList<InvoicesModel> filteredInvoicesList = RxList();

  RxBool isLoading = true.obs;
  Rx<String> searchString = ''.obs;

  Rx<String> fromDate = ''.obs; // Initialize as empty string
  Rx<String> toDate = ''.obs; // Initialize as empty string

  @override
  void onInit() {
    getAllInvoices();
    super.onInit();
  }

  void setSearchString(String value) {
    searchString.value = value.toLowerCase();
    filterInvoices();
  }

  void setFromDate(BuildContext context) async {
    fromDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterInvoices();
  }

  void setToDate(BuildContext context) async {
    toDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterInvoices();
  }

  void filterInvoices() {
    DateTime? from;
    DateTime? to;
    if (fromDate.value.isNotEmpty) {
      from = DateFormat('yyyy-MM-dd').parse(fromDate.value);
    }
    if (toDate.value.isNotEmpty) {
      to = DateFormat('yyyy-MM-dd').parse(toDate.value);
    }
    String search = searchString.value;

    final filteredList = allInvoices.where((invoice) {
      bool matchesDate = true;
      if (from != null) {
        DateTime invoiceDate = DateFormat('yyyy-MM-dd').parse(invoice.createdAt);
        matchesDate = invoiceDate.isAfter(from) || invoiceDate.isAtSameMomentAs(from);
      }
      if (to != null) {
        DateTime invoiceDate = DateFormat('yyyy-MM-dd').parse(invoice.createdAt);
        matchesDate = invoiceDate.isBefore(to) || invoiceDate.isAtSameMomentAs(to);
      }
      bool matchesSearch = invoice.invoiceNo.toLowerCase().contains(search);
      return matchesDate && matchesSearch;
    }).toList();

    filteredInvoicesList.assignAll(filteredList);
    update();
    log("from $from to: $to search: $search filtered list: \n $filteredList");
  }

  Future<void> getAllInvoices() async {
    allInvoices = await repo.getAllInvoices();
    filteredInvoicesList.assignAll(allInvoices);
    isLoading.value = false;
    update();
  }
}
