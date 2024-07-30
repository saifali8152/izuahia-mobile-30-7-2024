import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';

class ProfileInvoiceUpdatePaymentSearch extends StatefulWidget {
  const ProfileInvoiceUpdatePaymentSearch({super.key});

  @override
  State<ProfileInvoiceUpdatePaymentSearch> createState() =>
      _ProfileInvoiceUpdatePaymentSearchState();
}

class _ProfileInvoiceUpdatePaymentSearchState
    extends State<ProfileInvoiceUpdatePaymentSearch> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 40.h),
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
            16.verticalSpace,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'INVOICE',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            12.verticalSpace,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Update the payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            20.verticalSpace,
            textFormFieldWidget(hintText: 'Enter Payment', title: 'Payment'),
            15.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Document',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor),
                ),
                6.verticalSpace,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 84,
                    width: 84,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.grey3),
                    child: SvgPicture.asset(Assets.upload),
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: width * .5,
                        height: height * .04,
                        child:
                            RoundButton(label: 'Submit', onPressed: () {})))),
            15.verticalSpace,
          ],
        ),
      ),
    );
  }
}
