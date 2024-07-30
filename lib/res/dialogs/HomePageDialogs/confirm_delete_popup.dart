import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget confirmDeletePopup({
  required BuildContext context,
  required VoidCallback onNoTap,
  required VoidCallback onYesTap,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .34,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                height: 30,
                width: 30,
                child: customButtons(
                    onTap: () {
                      Get.back();
                    },
                    assets: Assets.cancel),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You have already added inventories of other booths. Do you want to delete those?",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: AppColors.textColor,
                  ),
                ),
                50.verticalSpace,
                Row(
                  children: [
                    confirmDeletePopupButton(
                      title: 'Yes',
                      onTap: onYesTap,
                    ),
                    10.horizontalSpace,
                    confirmDeletePopupButton(
                      title: 'No',
                      onTap: onNoTap,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget confirmDeletePopupButton({
  required String title,
  required VoidCallback onTap,
  Color bgColor = AppColors.blackColor,
  Color textColor = AppColors.yellow,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .04,
      width: Get.width * 0.35,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Inter',
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
