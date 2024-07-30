import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/profile_requests_controller.dart';
import 'package:izuahia/screens/PROFILE/Request/tabs/inventory-request-tab.dart';
import 'package:izuahia/screens/PROFILE/Request/tabs/service-request-tab.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<String> itemList = [Assets.master, Assets.paypal, Assets.applePay, Assets.payment4];

  final ThreadTabController tabController = Get.put(ThreadTabController());

  @override
  void initState() {
    Get.put(ProfileRequestsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 40.h),
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.yellow),
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
                    padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 120.h),
                    decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'REQUESTS',
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
                                      title: 'Service Request',
                                      isSelected: tabController.currentIndex.value == 0)),
                              8.horizontalSpace,
                              Expanded(
                                  child: tabButtons(
                                      onTap: () {
                                        tabController.setCurrentIndex(1);
                                      },
                                      title: 'Inventory Request',
                                      isSelected: tabController.currentIndex.value == 1)),
                            ],
                          );
                        }),
                        12.verticalSpace,
                        tabViews(),
                        10.verticalSpace,
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

Widget tabViews() {
  return GetBuilder<ThreadTabController>(
      init: ThreadTabController(),
      builder: (controller) {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            ServiceRequestTabScreen(),
            InventoryRequestTabScreen(),
          ],
        );
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
