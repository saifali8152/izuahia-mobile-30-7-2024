import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/SERVICE-HUB-WIDGETS/Receipts/service-hub-receipt-search.dart';

class ServiceHubReceiptSearchScreen extends StatefulWidget {
  const ServiceHubReceiptSearchScreen({super.key});

  @override
  State<ServiceHubReceiptSearchScreen> createState() =>
      _ServiceHubReceiptSearchScreenState();
}

class _ServiceHubReceiptSearchScreenState
    extends State<ServiceHubReceiptSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: 50,
              left: 10.w,
              right: 10.w,
            ),
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
                    children: [const ServiceHubReceiptSearchWidget()],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
