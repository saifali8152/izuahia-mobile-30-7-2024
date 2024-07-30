import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/inventory_requests_model.dart';
import 'package:izuahia/models/service_request_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';

class RequestsController extends GetxController {
  TextEditingController? dropDownValueController;
  TextEditingController? commentController;
  CreateRequestRepo repo = CreateRequestRepo();
  final formKey = GlobalKey<FormState>();

  List<ServiceRequest> serviceRequestsList = [];
  List<InventoryRequest> inventoryRequestsList = [];

  @override
  void onInit() {
    dropDownValueController = TextEditingController();
    commentController = TextEditingController();
    super.onInit();
  }

  Future<void> commentService({required String serviceRequestId, required String serviceHubId}) async {
    await repo.addServiceRequestComment(
      serviceHubId: serviceHubId,
      comment: commentController!.text,
      serviceRequestId: serviceRequestId,
    );
  }

  Future<void> commentInventory({required String inventoryRequestId, required String salesPointId}) async {
    await repo.addInventoryRequestComment(
      salesPointId: salesPointId,
      comment: commentController!.text,
      inventoryRequestId: inventoryRequestId,
    );
  }

  Future<void> getAllServiceRequests() async {
    final ServiceRequestModel? model = await repo.getAllServiceRequests();
    serviceRequestsList = model != null ? model.data : <ServiceRequest>[];
  }

    Future<void> getAllInventoryRequests() async {
    final InventoryRequestsModel? model = await repo.getAllInventoryRequests();
    inventoryRequestsList = model != null ? model.data : <InventoryRequest>[];
  }

}
