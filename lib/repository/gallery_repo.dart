import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:izuahia/models/gallery_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class GalleryRepo {
  final _baseURL = 'https://izuahiabygiwpy.com/appAPI/';
  final _getUserGalleryEndpoint = 'userGallery.php';
  final _addUserGalleryEndpoint = 'addUserGallery.php';
  final _deleteUserGalleryEndpoint = 'deleteUserGallery.php';

  Future<List<GalleryData>> getUserGallery() async {
    final url = Uri.parse('$_baseURL$_getUserGalleryEndpoint');

    List<GalleryData> galleryList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      // Set user_id from SharedPrefs
      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('Response: $responseData');

        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          // Process successful response
          galleryList = GalleryModel.fromJson(responseJson).data;
        } else {
          HelperFunctions.showSnackBar(
            title: 'Failed to fetch items',
            msg: responseJson['data'] ?? 'Unknown error',
          );
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
    return galleryList;
  }

  Future<bool> addUserGallery({required File? image}) async {
    final url = Uri.parse('$_baseURL$_addUserGalleryEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      // Set user_id from SharedPrefs
      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('gallery_image', image.path));
      }

      request.headers.addAll({'Content-Type': 'text/html; charset=UTF-8'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('Response: $responseData');

        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          HelperFunctions.showSnackBar(
            title: 'Image added to gallery',
            msg: responseJson['data'] ?? '',
          );
          return true;
        } else {
          HelperFunctions.showSnackBar(
            title: 'Failed to add to gallery',
            msg: responseJson['data'] ?? 'Unknown error',
          );
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
    return false;
  }

  Future<bool> deleteFromGallery({required String userGalleryId}) async {
    final url = Uri.parse('$_baseURL$_deleteUserGalleryEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      // Set user_id from SharedPrefs
      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";
      request.fields['ug_id'] = userGalleryId;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('Response: $responseData');

        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          HelperFunctions.showSnackBar(
            title: 'Image deleted from gallery',
            msg: responseJson['data'] ?? '',
          );
          return true;
        } else {
          HelperFunctions.showSnackBar(
            title: 'Failed to delete image',
            msg: responseJson['data'] ?? 'Unknown error',
          );
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
    return false;
  }
}
