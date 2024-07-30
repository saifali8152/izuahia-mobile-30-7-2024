import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';

class CreateSalesPointWidget extends StatelessWidget {
  const CreateSalesPointWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .30),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: AppColors.grey3.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 5),
            BoxShadow(
                offset: const Offset(0, -3),
                color: AppColors.grey3.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 5),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'CREATE SALES POINT',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w700),
          ),
          10.verticalSpace,
          // const Text(
          //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontFamily: 'Montserrat',
          //       color: AppColors.blackColor,
          //       fontWeight: FontWeight.w600),
          // ),
          SvgPicture.asset(Assets.salesPoint),
          10.verticalSpace,
          const Text(
            "Empower your online presence with customizable booths, diverse inventory management tools, and interactive features for enhanced sales.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600),
          ),
          20.verticalSpace,
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: width * .48,
                  height: height * .045,
                  child: RoundButton(
                      label: 'Create Sales Point', onPressed: () {}))),
        ],
      ),
    );
  }
}
