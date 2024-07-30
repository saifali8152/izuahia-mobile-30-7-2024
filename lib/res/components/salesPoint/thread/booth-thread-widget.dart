import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/thread/tabs/comments-tab-screen.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/thread/tabs/internal-tab-screen.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/thread/tabs/negotiation-tab-screen.dart';

class BoothThreadWidget extends StatefulWidget {
  const BoothThreadWidget({super.key});

  @override
  State<BoothThreadWidget> createState() => _BoothThreadWidgetState();
}

class _BoothThreadWidgetState extends State<BoothThreadWidget> {
  // final List<Map<String, dynamic>> itemList = [
  //   {'image': Assets.mobile},
  //   {'image': Assets.laptop1},
  //   {'image': Assets.shoe},
  //   {'image': Assets.profileImage},
  //   {'image': Assets.mobile},
  //   {'image': Assets.laptop2},
  //   {'image': Assets.shoe},
  //   {'image': Assets.profileImage},
  //   {'image': Assets.profileImage},
  // ];

  final ThreadTabController tabController = Get.put(ThreadTabController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .8,
      // constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13), color: AppColors.yellow2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Assets.logo,
                  height: 45,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              20.horizontalSpace,
              const Text(
                'EZYBROT LIMITED',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          12.verticalSpace,
          Container(
            height: height * .05,
            width: width,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 4)
                ],
                border: const Border(
                    left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('BOOTH 1',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700)),
          ),
          10.verticalSpace,
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  endIndent: 20,
                  height: 1,
                ),
              ),
              Text('THREAD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  indent: 20,
                  height: 1,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: tabButtons(
                        onTap: () {
                          tabController.setCurrentIndex(0);
                        },
                        title: 'Negotiations',
                        isSelected: tabController.currentIndex.value == 0)),
                8.horizontalSpace,
                Expanded(
                    child: tabButtons(
                        onTap: () {
                          tabController.setCurrentIndex(1);
                        },
                        title: 'Comments',
                        isSelected: tabController.currentIndex.value == 1)),
                8.horizontalSpace,
                Expanded(
                    child: tabButtons(
                        onTap: () {
                          tabController.setCurrentIndex(2);
                        },
                        title: 'Internal',
                        isSelected: tabController.currentIndex.value == 2)),
              ],
            );
          }),
          12.verticalSpace,
          tabViews()
        ],
      ),
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
            color: isSelected! ? AppColors.yellow : AppColors.blackColor,
            borderRadius: BorderRadius.circular(25)),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                color: isSelected ? AppColors.blackColor : AppColors.yellow,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget tabViews() {
    return GetBuilder<ThreadTabController>(
        init: ThreadTabController(),
        builder: (controller) {
          // Check if the current index is for the 'Internal' tab
          // if (controller.currentIndex.value == 2) {
          //   return Column(
          //     children: [
          //       Expanded(
          //         // Make sure InternalTabScreen does not occupy the whole space
          //         child: InternalTabScreen(),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
          //         child: TextField(
          //           // Add your TextField customization here
          //           decoration: InputDecoration(
          //             hintText: "Enter your message",
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   );
          // } else {

          return [
            const NegotiationTabScreen(),
            const CommentsTabScreen(),
            const InternalTabScreen(),
          ][controller.currentIndex.value];
        }
        // },
        );
  }
}
