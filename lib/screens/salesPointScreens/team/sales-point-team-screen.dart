import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/salesPointScreens/List%20vacancy/salesPointListVacancyScreen.dart';
import 'package:izuahia/screens/salesPointScreens/team/sales_point_application_tab.dart';
import 'package:izuahia/screens/salesPointScreens/team/sales_point_workforce_tab.dart';

class SalesPointTeamScreen extends StatefulWidget {
  const SalesPointTeamScreen({super.key});

  @override
  State<SalesPointTeamScreen> createState() => _SalesPointTeamScreenState();
}

class _SalesPointTeamScreenState extends State<SalesPointTeamScreen> {
  final ThreadTabController tabController = Get.put(ThreadTabController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: AppColors.yellow),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.blackColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: height,
                      width: width,
                      padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 20.h),
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Team',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                            ),
                          ),
                          10.verticalSpace,
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: tabButtons(
                                        onTap: () {
                                          tabController.setCurrentIndex(0);
                                        },
                                        title: 'Workforce',
                                        isSelected: tabController.currentIndex.value == 0)),
                                8.horizontalSpace,
                                Expanded(
                                    child: tabButtons(
                                        onTap: () {
                                          tabController.setCurrentIndex(1);
                                        },
                                        title: 'Applications',
                                        isSelected: tabController.currentIndex.value == 1)),
                                8.horizontalSpace,
                                Expanded(
                                    child: tabButtons(
                                        onTap: () {
                                          tabController.setCurrentIndex(2);
                                        },
                                        title: 'List Vacancy',
                                        isSelected: tabController.currentIndex.value == 2)),
                              ],
                            );
                          }),
                          12.verticalSpace,
                          Expanded(child: tabViews()),
                          10.verticalSpace,
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget tabViews() {
  return GetBuilder<ThreadTabController>(
      init: ThreadTabController(),
      builder: (controller) {
        return [
          const SalesPointWorkForceTab(),
          const SalesPointApplicationTab(),
          const SalesPointListVacancyScreen(),
        ][controller.currentIndex.value];
      }
      // },
      );
}

Widget tabButtons({
  required VoidCallback onTap,
  required var title,
  bool? isSelected,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .034,
      width: Get.width * .2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelected! ? AppColors.yellow : AppColors.whiteColor,
          border: Border.all(
            color: AppColors.yellow,
          ),
          borderRadius: BorderRadius.circular(25)),
      child: Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
    ),
  );
}
