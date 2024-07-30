import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/repository/auth_repo.dart';

class SignupController extends GetxController {
  GlobalKey<FormState>? signupFormKey;
  TextEditingController? emailController;
  TextEditingController? passController;
  TextEditingController? nameController;
  TextEditingController? lastnameController;
  TextEditingController? confirmPassController;
  TextEditingController? currencyController;
  final RxBool _remember = false.obs;
  final RxBool _isHide = true.obs;
  final RxBool _isConfirmHide = true.obs;
  final AuthRepository auth = AuthRepository();

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

  RxBool get isConfirmHide => _isConfirmHide;

  set setIsConfirmHide(bool val) {
    _isConfirmHide.value = val;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    signupFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passController = TextEditingController();
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    confirmPassController = TextEditingController();
    currencyController = TextEditingController();
  }

  Future<void> signup() async {
    await auth.signUp(
      firstName: nameController!.text,
      lastName: lastnameController!.text,
      email: emailController!.text,
      password: passController!.text,
      currency: currencyController!.text,
    );
  }
}
