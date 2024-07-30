import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/salesPoint/applications/booth-application-widget.dart';

class SalesPointApplicationTab extends StatefulWidget {
  const SalesPointApplicationTab({super.key});

  @override
  State<SalesPointApplicationTab> createState() =>
      _SalesPointApplicationTabState();
}

class _SalesPointApplicationTabState
    extends State<SalesPointApplicationTab> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height*0.78,
              width: width,
              padding: EdgeInsets.only(top: 8.h, bottom: 80.h),
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const BoothApplicationWidget(),
            ),
          ],
        ));
  }
}
