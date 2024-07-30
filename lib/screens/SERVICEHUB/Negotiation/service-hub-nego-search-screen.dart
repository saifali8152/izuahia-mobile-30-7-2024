import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/SERVICE-HUB-WIDGETS/Negotiation/service-hub-nego-search-widget.dart';
import 'package:izuahia/res/components/custom-app-bar.dart';

class ServiceHubNegoSearchScreen extends StatefulWidget {
  const ServiceHubNegoSearchScreen({super.key});

  @override
  State<ServiceHubNegoSearchScreen> createState() => _ServiceHubNegoSearchScreenState();
}

class _ServiceHubNegoSearchScreenState extends State<ServiceHubNegoSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: height,
                width: width,
                color: AppColors.blackColor,
                child: const CustomAppBar()),
            Positioned(
              top: height * .16,
              left: 20,
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
            Positioned(
              height: height,
              top: height * .20,
              child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.only(top: 8.h, left: 13.w, right: 13.w, bottom: 160.h),
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: const [ServiceHubNegoSearchWidget()],
                ),
              ),
            ),
          ],
        ));
  }
}
