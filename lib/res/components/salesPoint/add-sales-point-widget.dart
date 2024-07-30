import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';

class AddSalesPointWidget extends StatelessWidget {
  const AddSalesPointWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .32),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.grey3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height * .05,
            width: width * .6,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
                color: AppColors.yellow2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                border: Border(
                    bottom: BorderSide(color: AppColors.blackColor, width: 5))),
            child: const Text(
              'CREATE SALES POINT',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600),
          ),
          10.verticalSpace,
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500",
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
