import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/auth/login-screen.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      // if (HelperFunctions.isLoggedIn) {
        Get.off(() => CustomBottomScreen());
      // } else {
      //   Get.to(() => const LoginScreen());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Image.asset(Assets.appLogo),
      ),
    );
  }
}
