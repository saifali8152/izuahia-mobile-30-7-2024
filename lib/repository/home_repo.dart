import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:izuahia/models/home_model.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class HomeRepo {
  String baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  final String _homeListsEndpoint = 'homeScreen.php';
  final String _allRequestsEndpoint = 'allRequests.php';
  HomeApiModel homeModel = HomeApiModel(
    allServices: [],
    allInventories: [],
    allRequests: [],
    error: "true",
  );

  Future<HomeApiModel> getHomeData({
    required String latitude,
    required String longitude,
  }) async {
    final url = Uri.parse('$baseUrl$_homeListsEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          homeModel = HomeApiModel.fromJson(responseJson);
          // HelperFunctions.showSnackBar(title: 'Items Fetched Succesfully', msg: '');
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
    return homeModel;
  }

  Future<List<HomeRequestModel>> getAllRequests() async {
    final url = Uri.parse('$baseUrl$_allRequestsEndpoint');
    List<HomeRequestModel> requestsModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = (SharedPrefs().getString('user_id') ?? "0");

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          requestsModelList = (responseJson['data']['allRequests'] as List).map((i) => HomeRequestModel.fromJson(i)).toList();
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
    return requestsModelList;
  }
}
