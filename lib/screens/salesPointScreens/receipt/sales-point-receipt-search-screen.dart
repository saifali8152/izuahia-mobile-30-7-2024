import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/salesPoint/receipt/recepit-search-widget.dart';

class SalesPoitnReceiptSearchScreen extends StatefulWidget {
  const SalesPoitnReceiptSearchScreen({super.key});

  @override
  State<SalesPoitnReceiptSearchScreen> createState() =>
      _SalesPoitnReceiptSearchScreenState();
}

class _SalesPoitnReceiptSearchScreenState
    extends State<SalesPoitnReceiptSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 13.w, right: 13.w, top: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //     alignment: Alignment.topCenter,
                //     height: height,
                //     width: width,
                //     color: AppColors.blackColor,
                //     child: CustomAppBar(
                //       onSearch: () {},
                //     )),

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
                Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(top: 8.h, bottom: 80.h),
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: const [ReceiptSearchWidget()],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
