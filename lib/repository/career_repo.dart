import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:izuahia/models/career_history_model.dart';
import 'package:izuahia/models/vacancies_model.dart';

import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/utils/helper_functions.dart';
// import 'package:izuahia/utils/helper_functions.dart';

class CareerRepo {
  final String _baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  final String _updateCareerProfileEndpoint = 'updateCareerProfile.php';
  final String _uploadResumeEndpoint = 'uploadResume.php';
  final String _deleteResumeEndpoint = 'deleteResume.php';
  final String _careerHistoryEndPoint = 'careerHistory.php';
  final String _allVacanciesEndpoint = 'allVacancies.php';
  final String _applyToJobEndpoint = 'applyJob.php';

  SharedPrefs sharedPrefs = SharedPrefs();

  Future<void> updateCareerProfile({
    required String summary,
    required String description,
  }) async {
    final url = Uri.parse('$_baseUrl$_updateCareerProfileEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";
      request.fields['summary'] = summary;
      request.fields['description'] = description;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          SharedPrefs().setString('description', description);
          SharedPrefs().setString('summary', summary);
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

  Future<void> updateResume({
    required File? resumeFile,
  }) async {
    final url = Uri.parse('$_baseUrl$_uploadResumeEndpoint');

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";

      if (resumeFile != null) {
        request.files.add(await http.MultipartFile.fromPath('resume', resumeFile.path));
      }

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          SharedPrefs().setString('resume', responseJson['data']);
          HelperFunctions.showSnackBar(title: 'Resume updated succesfully', msg: responseJson['data']);
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to upload resume', msg: responseJson['data']);
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

  Future<void> deleteResume() async {
    final url = Uri.parse('$_baseUrl$_deleteResumeEndpoint');

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
          SharedPrefs().setString('resume', "");
          HelperFunctions.showSnackBar(title: 'Resume deleted succesfully', msg: responseJson['data']);
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to delete resume', msg: responseJson['data']);
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

  Future<List<CareerHistoryModel>> getCareerHistory() async {
    final url = Uri.parse('$_baseUrl$_careerHistoryEndPoint');
    final List<CareerHistoryModel> careerHistoryList = [];

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
          for (final item in responseJson['data'] as List) {
            careerHistoryList.add(CareerHistoryModel.fromJson(item));
          }
          return careerHistoryList;
        } else {
          HelperFunctions.showSnackBar(title: 'Failed to get career history', msg: responseJson['data']);
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
    return careerHistoryList;
  }

  Future<List<VacanciesModel>> getAllVacancies() async {
    final url = Uri.parse('$_baseUrl$_allVacanciesEndpoint');
    List<VacanciesModel> vacanciesModelList = [];

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString("user_id") ?? "0";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          vacanciesModelList = (responseJson['data'] as List).map((i) => VacanciesModel.fromJson(i)).toList();
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
    return vacanciesModelList;
  }

  Future<bool> applyToJob({
    required String jobVacancyId,
  }) async {
    final url = Uri.parse('$_baseUrl$_applyToJobEndpoint');
    bool isApplied = false;

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = SharedPrefs().getString('user_id') ?? "0";
      request.fields['jv_id'] = jobVacancyId;

      request.headers.addAll({'Content-Type': 'application/json'});

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        log('response: $responseData');
        final responseJson = jsonDecode(responseData);

        if (responseJson['error'] == "false") {
          HelperFunctions.showSnackBar(title: 'Applied to job succesfully', msg: responseJson['data']);
          return isApplied = true;
        } else {
          isApplied = false;
          HelperFunctions.showSnackBar(title: 'Failed to apply', msg: responseJson['data']);
        }
      } else {
        isApplied = false;

        HelperFunctions.showSnackBar(
          title: 'Server Error',
          msg: '${response.statusCode}',
        );
      }
    } catch (e) {
      isApplied = false;

      log('Exception: $e');
      HelperFunctions.showSnackBar(title: 'Error', msg: e.toString());
    }
    return isApplied;
  }
}
