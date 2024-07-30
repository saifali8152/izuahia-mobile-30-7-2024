import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/salesPoint/receipt/receipt-home-widget.dart';

class SalesPoitnInventoryRecepitScreen extends StatefulWidget {
  const SalesPoitnInventoryRecepitScreen({super.key});

  @override
  State<SalesPoitnInventoryRecepitScreen> createState() =>
      _SalesPoitnInventoryRecepitScreenState();
}

class _SalesPoitnInventoryRecepitScreenState
    extends State<SalesPoitnInventoryRecepitScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
          height: height,
          width: width,
          padding:
              EdgeInsets.only(top: 35.h, left: 13.w, right: 13.w, bottom: 50.h),
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // shrinkWrap: tr
              // ue,
              // padding: EdgeInsets.zero,
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
                        color: AppColors.yellow),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.blackColor,
                      size: 18,
                    ),
                  ),
                ),
                10.verticalSpace,
                const ReceiptHomeWidget()
              ],
            ),
          ),
        ));
  }
}
