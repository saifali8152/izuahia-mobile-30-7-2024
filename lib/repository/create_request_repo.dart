import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:izuahia/models/booth_model.dart';
import 'package:izuahia/models/hub_model.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/models/inventory_requests_model.dart';
import 'package:izuahia/models/sales_point_model.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/models/service_request_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class CreateRequestRepo {
  final String baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  final String addServiceRequestEndpoint = 'addServiceRequest.php';
  final String addInventoryRequestEndpoint = 'addInventoryRequest.php';
  final String addNewInventoryEndpoint = 'addInventory.php';
  final String addInventoryRequestCommentEndpoint = 'addInventoryRequestComment.php';
  final String addServiceHubEndpoint = 'addServiceHub.php';
  final String addNewServiceEndpoint = 'addService.php';
  final String addServiceRequestCommentEndpoint = 'addServiceRequestComment.php';
  final String selectHubEndpoint = 'selectServiceHub.php';
  final String salesPointEndpoint = 'addSalesPoint.php';
  final String selectSalesPointEndpoint = 'selectSalesPoint.php';
  final String addNewBoothEndpoint = 'addBooth.php';
  final String selectBoothEndpoint = 'selectBooth.php';
  final String getAllServiceRequestsEndpoint = 'allServiceRequests.php';
  final String getAllInventoryRequestsEndpoint = 'allInventoryRequests.php';
  final String addServiceCommentEndpoint = 'addServiceComment.php';
  final String addInventoryCommentEndpoint = 'addInventoryComment.php';
  final String addServiceFavoriteEndpoint = 'addServiceFavourite.php';
  final String addInventoryFavoriteEndpoint = 'addInventoryFavourite.php';
  final String getAllServicesEndpoint = 'allServices.php';
  final String getAllInventoriesEndpoint = 'allInventories.php';
  final String addBidEndpoint = 'addBid.php';
  final String addNegotiationEndpoint = 'addNegotiation.php';
  final String addToCartEndpoint = 'addCart.php';

  Future<void> addServiceRequest({
    required String serviceName,
    required double serviceBudget,
    required String budgetFlexibility,
    required String description,
    required String latitude,
    required String longitude,
    required String fullAddress,
    required File? image,
  }) async {
    final url = Uri.parse('$baseUrl$addServiceRequestEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['service_name'] = serviceName;
      request.fields['service_budget'] = serviceBudget.toString();
      request.fields['service_budget_currency'] =
          SharedPrefs().getString('default_currency') ?? "";
      request.fields['budget_flexibility'] = budgetFlexibility;
      request.fields['description'] = description;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['full_address'] = fullAddress;

      request.headers.addAll({'Content-Type': 'text/html; charset=UTF-8'});

      if (image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('service_image', image.path));
      }

      log('fields send  ${request.fields}');

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response data  $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Service request created successfully', msg: '');
        } else {
          // Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create service request',
              msg: responseJson['data']);
        }
      } else {
        // Get.back();
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } on Exception catch (e, stackTrace) {
      // Get.back();
      Get.back();
      log('Exception: $e stack: $stackTrace');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addInventoryRequest({
    required String inventoryName,
    required String itemColor,
    required String inventoryBudget,
    required String size,
    required String overview,
    required String condition,
    required String features,
    required String specifications,
    required String deliveryTerms,
    required String description,
    required String inventoryType,
    required String quantity,
    required String location,
    required String latitude,
    required String longitude,
    required List<File> inventoryImages,
  }) async {
    final url = Uri.parse('$baseUrl$addInventoryRequestEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['inventory_budget_currency'] =
          (SharedPrefs().getString('default_currency') ?? "USD");
      request.fields['inventory_budget'] = inventoryBudget;
      request.fields['inventory_name'] = inventoryName;
      request.fields['item_color'] = itemColor;
      request.fields['size'] = size;
      request.fields['quantity'] = quantity;
      request.fields['condition'] = condition;
      request.fields['overview'] = overview;
      request.fields['features'] = features;
      request.fields['specifications'] = specifications;
      request.fields['delivery_terms'] = deliveryTerms;
      request.fields['inventory_type'] = inventoryType;
      request.fields['description'] = description;
      request.fields['full_address'] = location;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;

      for (var image in inventoryImages) {
        request.files.add(await http.MultipartFile.fromPath(
            'inventory_images[]', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Inventory request created successfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create inventory request',
              msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } on Exception catch (e, stackTrace) {
      Get.back();
      log('Exception: $e : stackTrace: $stackTrace');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addNewInventory({
    required String inventoryName,
    required String salesPointId,
    required String boothId,
    required String itemColor,
    required String size,
    required String overview,
    required String condition,
    required String features,
    required String specifications,
    required String deliveryTerms,
    required String description,
    required String inventoryType,
    required String quantity,
    required String sellingPrice,
    required List<File> inventoryImages,
  }) async {
    final url = Uri.parse('$baseUrl$addNewInventoryEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['inventory_name'] = inventoryName;
      request.fields['sales_point'] = salesPointId;
      request.fields['booth'] = boothId;
      request.fields['selling_price'] = sellingPrice;
      request.fields['inventory_budget_currency'] =
          SharedPrefs().getString('default_currency') ?? "";
      request.fields['item_color'] = itemColor;
      request.fields['size'] = size;
      request.fields['quantity'] = quantity;
      request.fields['condition'] = condition;
      request.fields['overview'] = overview;
      request.fields['features'] = features;
      request.fields['specifications'] = specifications;
      request.fields['delivery_terms'] = deliveryTerms;
      request.fields['inventory_type'] = inventoryType;
      request.fields['description'] = description;

      for (var image in inventoryImages) {
        request.files.add(await http.MultipartFile.fromPath(
            'inventory_images[]', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Inventory request created successfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create inventory request',
              msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } on Exception catch (e, stackTrace) {
      Get.back();
      log('Exception: $e : stackTrace: $stackTrace');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addServiceHub({
    required String hubName,
    required String phone,
    required String email,
    required String address,
    required String location,
    required String latitude,
    required String longitude,
    required String description,
    required File? image,
  }) async {
    final url = Uri.parse('$baseUrl$addServiceHubEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['hub_name'] = hubName;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['address'] = address;
      request.fields['full_address'] = location;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['description'] = description;

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('hub_image', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Service hub created successfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create service hub', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addNewSalesPoint({
    required String salesPointName,
    required String phone,
    required String email,
    required String address,
    required String location,
    required String latitude,
    required String longitude,
    required String description,
    required File? image,
  }) async {
    final url = Uri.parse('$baseUrl$salesPointEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['sp_name'] = salesPointName;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['address'] = address;
      request.fields['full_address'] = location;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['description'] = description;

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('sp_image', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Sales point created successfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create sales point', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addNewBooth({
    required String boothName,
    required String spId,
    required String phone,
    required String email,
    required String address,
    required String location,
    required String latitude,
    required String longitude,
    required String description,
    required File? image,
    required String currency,
  }) async {
    final url = Uri.parse('$baseUrl$addNewBoothEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['booth_name'] = boothName;
      request.fields['sales_point'] = spId;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['address'] = address;
      request.fields['full_address'] = location;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['description'] = description;
      request.fields['default_currency'] = currency;

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('booth_image', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Booth created successfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create booth', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<List<HubDatum>> selectHub({bool fromHome = false}) async {
    List<HubDatum> _hubs = [];
    final url = Uri.parse('$baseUrl$selectHubEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();

        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          HubModel hubModel = HubModel.fromJson(responseJson);
          _hubs = hubModel.data;
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Hubs fetched succesfully', msg: '');
        } else {
          Get.back();
          if (!fromHome) {
            HelperFunctions.showSnackBar(
                title: 'Failed to fetch hubs', msg: responseJson['data']);
          }
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
      return _hubs;
    } catch (e) {
      Get.back();

      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
      return _hubs;
    }
  }

  Future<List<SalesPointDatum>> selectSalesPoint(
      {bool fromHome = false}) async {
    List<SalesPointDatum> salesPoints = [];
    final url = Uri.parse('$baseUrl$selectSalesPointEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();

        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          SalesPointModel salesPointModel =
              SalesPointModel.fromJson(responseJson);
          salesPoints = salesPointModel.data;
          HelperFunctions.showSnackBar(
              title: 'Sales Points fetched succesfully', msg: '');
        } else {
          Get.back();
          if (!fromHome) {
            HelperFunctions.showSnackBar(
                title: 'Failed to fetch sales points',
                msg: responseJson['data']);
          }
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
      return salesPoints;
    } catch (e) {
      Get.back();

      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
      return salesPoints;
    }
  }

  Future<List<BoothDatum>> selectBooth({required String spId}) async {
    List<BoothDatum> booths = [];
    final url = Uri.parse('$baseUrl$selectBoothEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['sales_point'] = spId;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();

        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          BoothModel boothModel = BoothModel.fromJson(responseJson);
          booths = boothModel.data;
          HelperFunctions.showSnackBar(
              title: 'Booth fetched succesfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to fetch booth', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
      return booths;
    } catch (e) {
      Get.back();

      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
      return booths;
    }
  }

  Future<void> addNewService({
    required String shId,
    required String serviceName,
    required String description,
    required File? image,
    required String currency,
  }) async {
    final url = Uri.parse('$baseUrl$addNewServiceEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['service_name'] = serviceName;
      request.fields['service_hub'] = shId;
      request.fields['description'] = description;
      request.fields['default_currency'] = currency;

      if (image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('service_image', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'New Service created successfully', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to create new service', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addServiceRequestComment({
    required String serviceHubId,
    required String comment,
    required String serviceRequestId,
  }) async {
    final url = Uri.parse('$baseUrl$addServiceRequestCommentEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['sr_id'] = serviceRequestId;
      request.fields['service_hub'] = serviceHubId;
      request.fields['comment'] = comment;
      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(title: 'Comment added', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to add comment', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addInventoryRequestComment({
    required String salesPointId,
    required String comment,
    required String inventoryRequestId,
  }) async {
    final url = Uri.parse('$baseUrl$addInventoryRequestCommentEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['ir_id'] = inventoryRequestId;
      request.fields['sales_point'] = salesPointId;
      request.fields['comment'] = comment;

      request.headers.addAll({'Content-Type': 'application/json'});

      log(' request fields ${request.fields}');

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(title: 'Comment added', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(
              title: 'Failed to add comment', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<ServiceRequestModel?> getAllServiceRequests() async {
    final url = Uri.parse('$baseUrl$getAllServiceRequestsEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          ServiceRequestModel serviceRequestModel =
              ServiceRequestModel.fromJson(responseJson);
          return serviceRequestModel;
        } else {
          HelperFunctions.showSnackBar(
              title: 'Failed to Fetch Service Requests',
              msg: responseJson['data']);
          return null;
        }
      } else {
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
      return null;
    }
  }

  Future<InventoryRequestsModel?> getAllInventoryRequests() async {
    final url = Uri.parse('$baseUrl$getAllInventoryRequestsEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          InventoryRequestsModel inventoryRequestModel =
              InventoryRequestsModel.fromJson(responseJson);
          return inventoryRequestModel;
        } else {
          HelperFunctions.showSnackBar(
              title: 'Failed to Fetch Service Requests',
              msg: responseJson['data']);
          return null;
        }
      } else {
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
      return null;
    }
  }

  Future<void> addServiceComment({
    required String comment,
    required String serviceId,
  }) async {
    final url = Uri.parse('$baseUrl$addServiceCommentEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['comment'] = comment;
      request.fields['s_id'] = serviceId;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(title: 'Comment added', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Failed to add comment', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addInventoryComment({
    required String comment,
    required String inventoryId,
  }) async {
    final url = Uri.parse('$baseUrl$addInventoryCommentEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['comment'] = comment;
      request.fields['inventory_id'] = inventoryId;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(title: 'Comment added', msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Failed to add comment', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addServiceToFavorites({
    required String serviceId,
  }) async {
    final url = Uri.parse('$baseUrl$addServiceFavoriteEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['s_id'] = serviceId;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          HelperFunctions.showSnackBar(title: responseJson['data'], msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Failed to add to favorites', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addInventoryToFavorites({
    required String inventoryId,
  }) async {
    final url = Uri.parse('$baseUrl$addInventoryFavoriteEndpoint');
    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['inventory_id'] = inventoryId;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          HelperFunctions.showSnackBar(title: responseJson['data'], msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Failed to add to favorites', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<List<HomeServiceModel>> getAllServices() async {
    final url = Uri.parse('$baseUrl$getAllServicesEndpoint');
    List<HomeServiceModel> serviceModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString("user_id") ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          serviceModelList = (responseJson['data']['allServices'] as List).map((i) => HomeServiceModel.fromJson(i)).toList();
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to fetch items', msg: responseJson['data']);
        }
      } else {
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
    return serviceModelList;
  }

  Future<List<HomeInventoryModel>> getAllInventories() async {
    final url = Uri.parse('$baseUrl$getAllInventoriesEndpoint');
    List<HomeInventoryModel> inventoriesModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString("user_id") ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          inventoriesModelList =
              (responseJson['data']['allInventories'] as List).map((i) => HomeInventoryModel.fromJson(i)).toList();
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to fetch items', msg: responseJson['data']);
        }
      } else {
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
    return inventoriesModelList;
  }

  Future<void> addInventoryBid({
    required String bidPrice,
    required String inventoryId,
  }) async {
    final url = Uri.parse('$baseUrl$addBidEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString("user_id") ?? "0");
      request.fields['inventory_id'] = inventoryId;
      request.fields['bid_price'] = bidPrice;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(title: responseJson['data'], msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Failed to fetch items', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<void> addInventoryNegotiation({
    required String inventoryId,
    required String negotiationText,
    required String negotiationPrice,
    required File? negotiationFile,
  }) async {
    final url = Uri.parse('$baseUrl$addNegotiationEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString("user_id") ?? "0");
      request.fields['inventory_id'] = inventoryId;
      request.fields['n_price'] = negotiationPrice;
      request.fields['n_text'] = negotiationText;

      request.headers.addAll({'Content-Type': 'text/html; charset=UTF-8'});

      if (negotiationFile != null) {
        request.files.add(await http.MultipartFile.fromPath('n_file', negotiationFile.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          HelperFunctions.showSnackBar(title: responseJson['data'], msg: '');
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Failed to fetch items', msg: responseJson['data']);
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
  }

  Future<String> addToCart({
    required String inventoryId,
    required String quantity,
    required String boothId,
    String isDelete = "0",
  }) async {
    final url = Uri.parse('$baseUrl$addToCartEndpoint');
    String data = "";

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString("user_id") ?? "0");
      request.fields['inventory_id'] = inventoryId;
      request.fields['qty'] = quantity;
      request.fields['booth_id'] = boothId;
      request.fields['is_delete'] = isDelete;

      request.headers.addAll({'Content-Type': 'text/html; charset=UTF-8'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          Get.back();
          Get.back();
          data = responseJson['data'];
          HelperFunctions.showSnackBar(title: responseJson['data'], msg: '');
        } else {
          Get.back();
          data = responseJson['data'];
          if (!data.contains("delete")) {
            HelperFunctions.showSnackBar(
              title: responseJson['data'],
              msg: "",
            );
          }
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
    return data;
  }
}
