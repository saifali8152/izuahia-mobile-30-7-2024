import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/edit_profile_controller.dart';
import 'package:izuahia/controllers/home_page_controller.dart';
import 'package:izuahia/controllers/profile_controller.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/profile-fields.dart';
import 'package:izuahia/screens/profile/Settings/change-password-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class UserProfileSettingdScreen extends StatefulWidget {
  const UserProfileSettingdScreen({super.key});

  @override
  State<UserProfileSettingdScreen> createState() => _UserProfileSettingdScreenState();
}

class _UserProfileSettingdScreenState extends State<UserProfileSettingdScreen> {
  HomeScreenController homeController = Get.put(HomeScreenController());
  ProfileController profileController = Get.put(ProfileController());

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
              builder: (controller) {
                return Form(
                  key: controller.editProfileFormKey,
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
                      16.verticalSpace,
                      InkWell(
                        onTap: () async {
                          await controller.showImageSourceSelectionDialog();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              controller.image != null
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: FileImage(controller.image!),
                                    )
                                  : SharedPrefs().getString('profile_pic') != null
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(SharedPrefs().getString('profile_pic')!),
                                        )
                                      : const CircleAvatar(
                                          radius: 40,
                                          backgroundImage: AssetImage(Assets.profileImage),
                                        ),
                              const Positioned(
                                right: 0,
                                bottom: 0,
                                child: Icon(Icons.camera_alt_rounded),
                              )
                            ],
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Edit Profile Picture',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff555555),
                                    fontWeight: FontWeight.w600),
                              ),
                              8.horizontalSpace,
                              SvgPicture.asset(Assets.profileEdit)
                            ],
                          )),
                      35.verticalSpace,
                      profileFieldWidget(
                        hintText: "",
                        controller: controller.firstNameController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name cant be empty';
                          }
                          return null;
                        },
                        preffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            Assets.userIcon,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      profileFieldWidget(
                        hintText: "",
                        controller: controller.lastNameController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name cant be empty';
                          }
                          return null;
                        },
                        preffixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(
                            Assets.userIcon,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      profileFieldWidget(
                        hintText: '${SharedPrefs().getString('email')}',
                        readOnly: true,
                        preffixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(
                            Assets.emailIcon,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      profileFieldWidget(
                        hintText: '${SharedPrefs().getString('phone')}',
                        controller: controller.phoneController,
                        preffixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(Assets.phone),
                        ),
                      ),
                      16.verticalSpace,
                      topUpWalletWidget(onTap: () {}),
                      16.verticalSpace,
                      Obx(() {
                        return notificationWidget(
                          isSwitched: controller.isSwitched.value,
                          onChanged: (value) {
                            controller.isSwitched.value = value;
                          },
                        );
                      }),

                      12.verticalSpace,
                      changePasswordWidget(onTap: () {
                        Get.to(() => const ChangePasswordScreen());
                      }),
                      // 12.verticalSpace,
                      // selectDefaultCurrencyDropdown(
                      //     value: currencyValue,
                      //     items: ['USD', 'EU', 'PKR'],
                      //     onChanged: (value) {
                      //       setState(() {
                      //         currencyValue = value ?? "EUR";
                      //       });
                      //     }),
                      40.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: width * .35,
                            height: height * .055,
                            child: RoundButton(
                              label: 'Update',
                              onPressed: () async {
                                if (controller.editProfileFormKey!.currentState!.validate()) {
                                  HelperFunctions.showLoadingDialogue(context);
                                  await controller.updateProfile();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    homeController.update();
                                    profileController.update();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget notificationWidget({required bool isSwitched, required Function(bool value) onChanged}) {
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
              onChanged: onChanged,
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

  Widget topUpWalletWidget({required VoidCallback? onTap}) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Top Up Wallet',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Text(
                  '${SharedPrefs().getString('wallet')}',
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    color: AppColors.yellow,
                    fontSize: 14,
                  ),
                ),
                10.horizontalSpace,
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.blackColor,
                  size: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget selectDefaultCurrencyDropdown(
  //     {required List<String> items, required void Function(String?)? onChanged, required String value}) {
  //   return Container(
  //     height: 40.h,
  //     width: Get.width,
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8.0),
  //       boxShadow: [
  //         BoxShadow(
  //           offset: const Offset(0, 3),
  //           spreadRadius: 0,
  //           blurRadius: 5,
  //           color: AppColors.grey2.withOpacity(0.1),
  //         ),
  //         BoxShadow(
  //           offset: const Offset(0, -3),
  //           spreadRadius: 0,
  //           blurRadius: 5,
  //           color: AppColors.grey3.withOpacity(0.1),
  //         ),
  //       ],
  //       color: AppColors.whiteColor,
  //     ),
  //     child:
  //     DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         isExpanded: true,
  //         hint: const Text(
  //           'Select default currency:',
  //           style: TextStyle(
  //             fontFamily: "Inter",
  //             fontWeight: FontWeight.w500,
  //             color: AppColors.blackColor,
  //             fontSize: 14,
  //           ),
  //         ),
  //         icon: const Icon(
  //           Icons.arrow_forward_ios_rounded,
  //           color: AppColors.blackColor,
  //           size: 15,
  //         ),
  //         value: value,
  //         dropdownColor: AppColors.grey1, // Dark grey color for the dropdown menu
  //         items: items.map<DropdownMenuItem<String>>((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(
  //               value,
  //               style: const TextStyle(
  //                 fontFamily: "Inter",
  //                 fontWeight: FontWeight.w500,
  //                 color: AppColors.blackColor,
  //                 fontSize: 14,
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //         onChanged: onChanged,
  //         selectedItemBuilder: (BuildContext context) {
  //           return items.map<Widget>((String item) {
  //             return Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Select default currency:',
  //                   style: TextStyle(
  //                     fontFamily: "Inter",
  //                     fontWeight: FontWeight.w500,
  //                     color: AppColors.blackColor,
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //                 Text(
  //                   item,
  //                   style: const TextStyle(
  //                     fontFamily: "Inter",
  //                     fontWeight: FontWeight.w500,
  //                     color: AppColors.blackColor,
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }).toList();
  //         },
  //       ),
  //     ),
  //   );
  // }

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
