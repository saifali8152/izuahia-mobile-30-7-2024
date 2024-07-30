import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/repository/auth_repo.dart';

class LoginController extends GetxController {
  GlobalKey<FormState>? signinFormKey;
  TextEditingController? emailController;
  TextEditingController? passController;
  AuthRepository auth = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    signinFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  final RxBool _remember = false.obs;
  final RxBool _isHide = true.obs;

  RxBool get remember => _remember;

  set setRemember(bool val) {
    _remember.value = val;
    update();
  }

  RxBool get isHide => _isHide;

  set setIsHide(bool val) {
    _isHide.value = val;
    update();
  }

  Future<void> login() async {
    await auth.login(
      email: emailController!.text,
      password: passController!.text,
    );
  }
}
