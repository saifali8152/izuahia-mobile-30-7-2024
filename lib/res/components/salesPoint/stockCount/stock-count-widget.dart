import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/stockCount/tabs/count-tab-screen.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/stockCount/tabs/reconcile-tab-screen.dart';
import 'package:izuahia/screens/salesPointScreens/stockCount/stock-count-search-screen.dart';

class StockCountWidget extends StatefulWidget {
  const StockCountWidget({super.key});

  @override
  State<StockCountWidget> createState() => _StockCountWidgetState();
}

class _StockCountWidgetState extends State<StockCountWidget> {
  final ThreadTabController tabController = Get.put(ThreadTabController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .78,
      // constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0.h),
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
              Text('STOCK COUNT',
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
                Expanded(flex: 2, child: textField()),
                8.horizontalSpace,
                Expanded(
                    child: tabButtons(
                        onTap: () {
                          tabController.setCurrentIndex(0);
                        },
                        title: 'Count',
                        isSelected: tabController.currentIndex.value == 0)),
                8.horizontalSpace,
                Expanded(
                    child: tabButtons(
                        onTap: () {
                          tabController.setCurrentIndex(1);
                        },
                        title: 'Reconcile',
                        isSelected: tabController.currentIndex.value == 1)),
              ],
            );
          }),
          12.verticalSpace,
          tabViews()
        ],
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .030,
      width: Get.width,
      child: TextFormField(
        onTap: () {
          Get.to(() => SalesPoitnStockCountSearchScreen());
        },
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.darkGrey),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
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
        height: Get.height * .030,
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
          return [
            const CountTabScreen(),
            const ReconcileTabScreen(),
          ][controller.currentIndex.value];
        });
  }
}
