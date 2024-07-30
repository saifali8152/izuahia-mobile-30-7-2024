import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:izuahia/models/bids_model.dart';
import 'package:izuahia/models/favorites_model.dart';
import 'package:izuahia/models/invoices_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:izuahia/utils/helper_functions.dart';

class ProfileRepo {
  final String _baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  final String _updateProfileEndpoint = 'updateProfile.php';
  final String _changePasswordEndpoint = 'changePassword.php';
  final String _allFavoritesEndpoint = 'allFavourites.php';
  final String _deleteFavoriteEndpoint = 'deleteFavourite.php';
  final String _allBidsEndpoint = 'allBids.php';
  final String _allInvoicesEndpoint = 'allInvoices.php';

  SharedPrefs sharedPrefs = SharedPrefs();

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String isNotification,
    required String phone,
    File? profilePic,
  }) async {
    final url = Uri.parse('$_baseUrl$_updateProfileEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = sharedPrefs.getString('user_id') ?? "0";
      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['is_notification'] = isNotification;
      request.fields['phone'] = phone;

      if (profilePic != null) {
        request.files.add(await http.MultipartFile.fromPath('profile_pic', profilePic.path));
      }

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          await sharedPrefs.setString('first_name', firstName);
          await sharedPrefs.setString('last_name', lastName);
          await sharedPrefs.setString('phone', phone);
          await sharedPrefs.setString('is_notification', isNotification);
          if (profilePic != null) {
            await sharedPrefs.setString('profile_pic', responseJson['data']);
          }
          HelperFunctions.showSnackBar(title: 'Profile updated succesfully', msg: responseJson['data']);
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to update profile', msg: responseJson['data']);
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
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final url = Uri.parse('$_baseUrl$_changePasswordEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = sharedPrefs.getString('user_id') ?? "0";
      request.fields['oldpassword'] = oldPassword;
      request.fields['password'] = newPassword;
      request.fields['cpassword'] = confirmNewPassword;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          HelperFunctions.showSnackBar(title: 'Password changed succesfully', msg: '');
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to change password', msg: '');
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
  }

  Future<List<FavoriteModel>> getAllFavorites() async {
    final url = Uri.parse('$_baseUrl$_allFavoritesEndpoint');
    List<FavoriteModel> favoritesList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString("user_id") ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          favoritesList = (responseJson['data'] as List).map((i) => FavoriteModel.fromJson(i)).toList();
        } else {
          HelperFunctions.showSnackBar(
            title: 'Failed to fetch items',
            msg: responseJson['data'],
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
    return favoritesList;
  }

  Future<bool> deleteFavorite({
    required String favoriteId,
  }) async {
    final url = Uri.parse('$_baseUrl$_deleteFavoriteEndpoint');
    bool deleted = false;

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = sharedPrefs.getString('user_id') ?? "0";
      request.fields['f_id'] = favoriteId;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          HelperFunctions.showSnackBar(title: 'Removed from favorites', msg: '');
          deleted = true;
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to remove from favorite', msg: responseJson['data']);
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
    return deleted;
  }

  Future<List<BidsModel>> getAllBids() async {
    final url = Uri.parse('$_baseUrl$_allBidsEndpoint');
    List<BidsModel> bidsModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString("user_id") ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          bidsModelList = (responseJson['data'] as List).map((i) => BidsModel.fromJson(i)).toList();
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
    return bidsModelList;
  }

  Future<List<InvoicesModel>> getAllInvoices() async {
    final url = Uri.parse('$_baseUrl$_allInvoicesEndpoint');
    List<InvoicesModel> invoicesModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString("user_id") ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          invoicesModelList = (responseJson['data'] as List).map((i) => InvoicesModel.fromJson(i)).toList();
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
    return invoicesModelList;
  }
}
