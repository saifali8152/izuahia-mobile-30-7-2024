import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/custom-app-bar.dart';
import 'package:izuahia/res/components/salesPoint/create-sales-point-widget.dart';
import 'package:izuahia/res/components/salesPoint/sales-point-business.dart';

class SalesPointScreen extends StatefulWidget {
  const SalesPointScreen({super.key});

  @override
  State<SalesPointScreen> createState() => _SalesPointScreenState();
}

class _SalesPointScreenState extends State<SalesPointScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.only(top: 60.h, left: 15.w, right: 15.w),
              margin: EdgeInsets.only(top: 90),
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CreateSalesPointWidget(),
                    20.verticalSpace,
                    const SalesPointBusiness(),
                  ],
                ),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                height: height * .16,
                width: width,
                decoration: const BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    )),
                child: const CustomAppBar()),
          ],
        ));
  }
}
