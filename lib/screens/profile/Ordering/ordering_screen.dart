import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/profile/Ordering/cart-screen.dart';
import 'package:izuahia/screens/profile/Ordering/orders_screen.dart';

class OrderingScreen extends StatefulWidget {
  const OrderingScreen({super.key});

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();
}

class _OrderingScreenState extends State<OrderingScreen> {
  final ThreadTabController tabController = Get.put(ThreadTabController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w, bottom: 70.h),
            decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                10.verticalSpace,
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tabButtons(
                          onTap: () {
                            tabController.setCurrentIndex(0);
                          },
                          title: 'Cart',
                          isSelected: tabController.currentIndex.value == 0),
                      25.horizontalSpace,
                      tabButtons(
                          onTap: () {
                            tabController.setCurrentIndex(1);
                          },
                          title: 'Orders',
                          isSelected: tabController.currentIndex.value == 1),
                    ],
                  );
                }),
            
                Expanded(child: tabViews()),
              ],
            )));
  }


}




Widget tabViews() {
  return GetBuilder<ThreadTabController>(
      init: ThreadTabController(),
      builder: (controller) {
        return [
          // Container(),
          const CartScreen(),
          const OrdersTab(),
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
      height: Get.height * .04,
      width: Get.width * .25,
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
