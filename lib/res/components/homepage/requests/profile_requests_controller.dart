import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/models/inventory_requests_model.dart';
import 'package:izuahia/models/service_request_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ProfileRequestsController extends GetxController {
  TextEditingController? dropDownValueController;
  TextEditingController? commentController;
  CreateRequestRepo repo = CreateRequestRepo();
  RxBool isLoading = true.obs;
  final formKey = GlobalKey<FormState>();
  var currentIndex = 0.obs;

  List<ServiceRequest> serviceRequestsList = [];
  List<InventoryRequest> inventoryRequestsList = [];
  RxList<InventoryRequest> filteredInventoryRequestsList = RxList();
  RxList<ServiceRequest> filteredServiceRequestsList = RxList();

  Rx<String> inventoryFromDate = ''.obs; // Initialize as empty string
  Rx<String> inventoryToDate = ''.obs; // Initialize as empty string
  Rx<String> inventorySearchString = ''.obs;

  Rx<String> serviceFromDate = ''.obs; // Initialize as empty string
  Rx<String> serviceToDate = ''.obs; // Initialize as empty string
  Rx<String> serviceSearchString = ''.obs;

  void setInventoryFromDate(BuildContext context) async {
    inventoryFromDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterInventoryRequests();
  }

  void setInventoryToDate(BuildContext context) async {
    inventoryToDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterInventoryRequests();
  }

  void setInventorySearchString(String value) {
    inventorySearchString.value = value.toLowerCase();
    filterInventoryRequests();
  }

  void setServiceFromDate(BuildContext context) async {
    serviceFromDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterServiceRequests();
  }

  void setServiceToDate(BuildContext context) async {
    serviceToDate.value = await HelperFunctions.showDatePickerDialogue(context);
    filterServiceRequests();
  }

  void setServiceSearchString(String value) {
    serviceSearchString.value = value.toLowerCase();
    filterServiceRequests();
  }

  void filterInventoryRequests() {
    DateTime? from;
    DateTime? to;
    if (inventoryFromDate.value.isNotEmpty) {
      from = DateFormat('yyyy-MM-dd').parse(inventoryFromDate.value);
    }
    if (inventoryToDate.value.isNotEmpty) {
      to = DateFormat('yyyy-MM-dd').parse(inventoryToDate.value);
    }
    String search = inventorySearchString.value;

    final filteredList = inventoryRequestsList.where((request) {
      bool matchesDate = true;
      if (from != null) {
        DateTime requestDate = DateFormat('yyyy-MM-dd').parse(request.createdAt);
        matchesDate = requestDate.isAfter(from) || requestDate.isAtSameMomentAs(from);
      }
      if (to != null) {
        DateTime requestDate = DateFormat('yyyy-MM-dd').parse(request.createdAt);
        matchesDate = requestDate.isBefore(to) || requestDate.isAtSameMomentAs(to);
      }
      bool matchesSearch = search.isEmpty || request.inventoryName.toLowerCase().contains(search);
      return matchesDate && matchesSearch;
    }).toList();

    filteredInventoryRequestsList.assignAll(filteredList);
    log("from $from to: $to search: $search filtered list: \n $filteredInventoryRequestsList");
  }

  void filterServiceRequests() {
    DateTime? from;
    DateTime? to;
    if (serviceFromDate.value.isNotEmpty) {
      from = DateFormat('yyyy-MM-dd').parse(serviceFromDate.value);
    }
    if (serviceToDate.value.isNotEmpty) {
      to = DateFormat('yyyy-MM-dd').parse(serviceToDate.value);
    }
    String search = serviceSearchString.value;

    final filteredList = serviceRequestsList.where((request) {
      bool matchesDate = true;
      if (from != null) {
        DateTime requestDate = DateFormat('yyyy-MM-dd').parse(request.createdAt);
        matchesDate = requestDate.isAfter(from) || requestDate.isAtSameMomentAs(from);
      }
      if (to != null) {
        DateTime requestDate = DateFormat('yyyy-MM-dd').parse(request.createdAt);
        matchesDate = requestDate.isBefore(to) || requestDate.isAtSameMomentAs(to);
      }
      bool matchesSearch = search.isEmpty || request.serviceName.toLowerCase().contains(search);
      return matchesDate && matchesSearch;
    }).toList();

    filteredServiceRequestsList.assignAll(filteredList);
    log("from $from to: $to search: $search filtered list: \n $filteredServiceRequestsList");
  }

  @override
  void onInit() {
    dropDownValueController = TextEditingController();
    commentController = TextEditingController();
    getAllServiceAndInventoryRequests();
    super.onInit();
  }

  Future<void> getAllServiceAndInventoryRequests() async {
    await getAllServiceRequests();
    await getAllInventoryRequests();
    filterInventoryRequests();
    isLoading.value = false;
  }

  Future<void> getAllServiceRequests() async {
    final ServiceRequestModel? model = await repo.getAllServiceRequests();
    serviceRequestsList = model != null ? model.data : <ServiceRequest>[];
    filteredServiceRequestsList = serviceRequestsList.obs;
  }

  Future<void> getAllInventoryRequests() async {
    final InventoryRequestsModel? model = await repo.getAllInventoryRequests();
    inventoryRequestsList = model != null ? model.data : <InventoryRequest>[];
  }
}
