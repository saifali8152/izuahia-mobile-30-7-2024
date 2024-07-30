import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/screens/auth/login-screen.dart';
import 'package:izuahia/screens/auth/sign-up-screen.dart';

Widget loginPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .5,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                height: 30,
                width: 30,
                child: customButtons(
                    onTap: () {
                      Get.back();
                    },
                    assets: Assets.cancel),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You are not logged in. Please Sign up or Login to perform this action",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: AppColors.textColor,
                  ),
                ),
                50.verticalSpace,
                loginPopUpButton(
                  title: 'Login',
                  onTap: () {
                    Get.to( ()=> const LoginScreen());
                  },
                ),
                10.verticalSpace,
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.black01,
                        endIndent: 20,
                      ),
                    ),
                    Text(
                      "OR",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.textColor,
                      ),
                    ),
                    Expanded(child: Divider(indent: 10, color: AppColors.black01)),
                  ],
                ),
                10.verticalSpace,
                loginPopUpButton(title: 'Sign Up', onTap: () {
                    Get.to( ()=> const SignUpScreen());
                })
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget loginPopUpButton({
  required String title,
  required VoidCallback onTap,
  Color bgColor = AppColors.blackColor,
  Color textColor = AppColors.yellow,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .04,
      width: Get.width * 0.35,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Inter',
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
