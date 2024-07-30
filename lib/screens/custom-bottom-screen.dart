import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/bottom-navbar-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/screens/SERVICEHUB/service-hub-main-screen.dart';
import 'package:izuahia/screens/home/home-screen.dart';
import 'package:izuahia/screens/PROFILE/profile-screen.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/sales-point-home.dart';
import 'package:izuahia/screens/select_business_screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class CustomBottomScreen extends StatelessWidget {
  CustomBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final BottomNavigationController controller =
        Get.put(BottomNavigationController());

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeScreen(),
              SalesPointHomeScreen(),
              ServiceHubMainScreen(),
              ProfileScreen(),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                left: 16,
                right: 16,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.24),
                      blurRadius: 3,
                      offset: const Offset(0, -3)),
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.24),
                      blurRadius: 3,
                      offset: const Offset(0, 3))
                ],
              ),
              height: height * .075,
              constraints: const BoxConstraints(maxHeight: double.infinity),
              width: 1.sw,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.setCurrentIndex = 0;
                          },
                          child: SvgPicture.asset(
                            Assets.homeIcon,
                            color: controller.currentIndex.value == 0
                                ? AppColors.yellow
                                : const Color(0xffAAAAAA),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!HelperFunctions.isLoggedIn) {
                              showDialog(
                                context: context,
                                builder: loginPopUp,
                              );
                            } else {
                              HelperFunctions.showLoadingDialogue(context);
                              await controller.selectSalesPoint();
                              if (controller.salesPointList.isEmpty) {
                                  Get.to(() => const SelectBusinessScreen());
                                } else {
                                  controller.setCurrentIndex = 1;
                                }
                            }
                          },
                          child: SvgPicture.asset(
                            Assets.icon2,
                            color: controller.currentIndex.value == 1
                                ? AppColors.yellow
                                : const Color(0xffAAAAAA),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!HelperFunctions.isLoggedIn) {
                              showDialog(
                                context: context,
                                builder: loginPopUp,
                              );
                            } else {
                              HelperFunctions.showLoadingDialogue(context);
                              await controller.selectHub().then((value) {
                                if (controller.hubs.isEmpty) {
                                  Get.to(() => const SelectBusinessScreen());
                                } else {
                                  controller.setCurrentIndex = 2;
                                }
                              });
                            }
                          },
                          child: SvgPicture.asset(
                            Assets.icon3,
                            color: controller.currentIndex.value == 2
                                ? AppColors.yellow
                                : const Color(0xffAAAAAA),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!HelperFunctions.isLoggedIn) {
                              showDialog(
                                context: context,
                                builder: loginPopUp,
                              );
                            } else {
                              controller.setCurrentIndex = 3;
                            }
                          },
                          child: SvgPicture.asset(
                            Assets.userCircle,
                            color: controller.currentIndex.value == 3
                                ? AppColors.yellow
                                : const Color(0xffAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
