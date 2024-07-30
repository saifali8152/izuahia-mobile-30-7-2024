import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:izuahia/models/home_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class SearchRepo {
  String _baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  final String _searchEndpoint = 'searchScreen.php';

  HomeApiModel homeModel = HomeApiModel(
    allServices: [],
    allInventories: [],
    allRequests: [],
    error: "true",
  );

  Future<HomeApiModel> getSearchData({required String searchString}) async {
    final url = Uri.parse('$_baseUrl$_searchEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] =  (SharedPrefs().getString('user_id') ?? "0");
      request.fields['search'] = searchString;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          homeModel = HomeApiModel.fromJson(responseJson);
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
      Get.back();
      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
    return homeModel;
  }
}
