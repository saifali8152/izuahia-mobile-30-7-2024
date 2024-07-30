import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/edit_profile_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/profile-fields.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 10.h),
        child: SingleChildScrollView(
          child: GetBuilder(
              init: EditProfileController(),
              builder: (editProfileController) {
                return Form(
                  key: editProfileController.changePasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grey2.withOpacity(0.4),
                                    offset: const Offset(0, 3),
                                    spreadRadius: 0,
                                    blurRadius: 3)
                              ],
                              color: AppColors.yellow),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.blackColor,
                            size: 18,
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Password',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                          5.verticalSpace,
                          profileFieldWidget(
                            hintText: '******',
                            controller: editProfileController.oldPasswordController,
                            obscureText: true,
                            preffixIcon: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.lockIcon),
                            ),
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'New Password',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                          5.verticalSpace,
                          profileFieldWidget(
                              hintText: '',
                              controller: editProfileController.newPasswordController,
                              obscureText: true,
                              onValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field is required';
                                } else if (editProfileController.newPasswordController!.text !=
                                    editProfileController.confirmNewPasswordController!.text) {
                                  return 'passwords do not match';
                                }
                                return null;
                              },
                              preffixIcon: IconButton(onPressed: () {}, icon: SvgPicture.asset(Assets.lockIcon))),
                        ],
                      ),
                      16.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Confirm New Password',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                          5.verticalSpace,
                          profileFieldWidget(
                            hintText: '',
                            controller: editProfileController.confirmNewPasswordController,
                            obscureText: true,
                            onValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field is required';
                              } else if (editProfileController.newPasswordController!.text !=
                                  editProfileController.confirmNewPasswordController!.text) {
                                return 'passwords do not match';
                              }
                              return null;
                            },
                            preffixIcon: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(Assets.lockIcon),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * .5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: width * .56,
                            height: height * .055,
                            child: RoundButton(
                              label: 'Change Password',
                              onPressed: () async {
                                if (editProfileController.changePasswordFormKey!.currentState!.validate()) {
                                  HelperFunctions.showLoadingDialogue(context);
                                  await editProfileController.changePassword();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget notificationWidget() {
    return Container(
      height: 35.h,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey2.withOpacity(0.1)),
            BoxShadow(offset: const Offset(0, -3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey3.withOpacity(0.1)),
          ],
          color: AppColors.whiteColor
          // ignore: prefer_const_constructors
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Notifications',
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: 14,
            ),
          ),
          Transform.scale(
            scale: 0.6,
            child: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              inactiveTrackColor: const Color(0xffB6B6B6),
              inactiveThumbColor: const Color(0xffD9D9D9),
              activeTrackColor: Colors.green,
              activeColor: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget changePasswordWidget({required VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey2.withOpacity(0.1)),
              BoxShadow(offset: const Offset(0, -3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey3.withOpacity(0.1)),
            ],
            color: AppColors.whiteColor
            // ignore: prefer_const_constructors
            ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Change Password',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                fontSize: 14,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.blackColor,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
