import 'dart:convert';
import 'dart:developer';

import 'package:izuahia/models/notifications_model.dart';
import 'package:http/http.dart' as http;
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class NotificationsRepo {
  final String _baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  final String _notificationsEndpoint = 'allNotifications.php';

  Future<List<NotificationsModel>> getAllNotifications() async {
    final url = Uri.parse('$_baseUrl$_notificationsEndpoint');
    List<NotificationsModel> notificationsModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] =  SharedPrefs().getString('user_id') ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          notificationsModelList = (responseJson['data'] as List).map((i) => NotificationsModel.fromJson(i)).toList();
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
    return notificationsModelList;
  }
}
