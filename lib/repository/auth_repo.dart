import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:izuahia/models/user_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/screens/auth/login-screen.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';
// import 'package:izuahia/utils/helper_functions.dart';

class AuthRepository {
  String baseUrl = 'https://izuahiabygiwpy.com/appAPI/';
  String signUpEndpoint = 'signupSuccess.php';
  String loginEndPoint = 'loginSuccess.php';
  SharedPrefs sharedPrefs = SharedPrefs();

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String currency,
  }) async {
    final url = Uri.parse('$baseUrl$signUpEndpoint');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'text/html; charset=UTF-8',
        },
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          'email': email,
          'password': password,
          "cpassword": password,
          "default_currency": currency,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['error'] == "false") {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Sign Up Succesfull', msg: responseData['data']);
          Get.off(() => const LoginScreen());
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: 'Sign Up Failed', msg: responseData['data']);
          Get.to(() => const LoginScreen());
        }
      } else {
        Get.back();
        HelperFunctions.showSnackBar(title: 'Server error:', msg: '${response.statusCode}');
      }
    } catch (e) {
      Get.back();
      HelperFunctions.showSnackBar(
        title: 'Error',
        msg: e.toString(),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl$loginEndPoint');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'text/html; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['error'] == "false") {
          UserModel user = UserModel.fromJson(responseData);

          await sharedPrefs.setString('user_id', user.data.userId);
          await sharedPrefs.setString('first_name', user.data.firstName);
          await sharedPrefs.setString('phone', user.data.phone);
          await sharedPrefs.setString('last_name', user.data.lastName);
          await sharedPrefs.setString('password', user.data.password);
          await sharedPrefs.setString('email', user.data.email);
          await sharedPrefs.setString('profile_pic', user.data.profilePic);
          await sharedPrefs.setString('wallet', user.data.wallet);
          await sharedPrefs.setString('is_notification', user.data.isNotification);
          await sharedPrefs.setString('default_currency', user.data.defaultCurrency);
          await sharedPrefs.setString('created_at', user.data.createdAt);
          await sharedPrefs.setString('description', user.data.description);
          await sharedPrefs.setString('summary', user.data.summary);
          await sharedPrefs.setString('resume', user.data.resumeUrl);
          await HelperFunctions.toggleIsLoggedIn();
          Get.back();
          HelperFunctions.showSnackBar(title: "Login Succesfull", msg: '');
          Get.off(() =>  CustomBottomScreen());
        } else {
          Get.back();
          HelperFunctions.showSnackBar(title: "Login Failed", msg: responseData['data']);
        }
      } else {
        Get.back();
        Get.snackbar('Server error:', '${response.statusCode}', duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.back();
      HelperFunctions.showSnackBar(
        title: 'Error',
        msg: e.toString(),
      );
    }
  }
}
