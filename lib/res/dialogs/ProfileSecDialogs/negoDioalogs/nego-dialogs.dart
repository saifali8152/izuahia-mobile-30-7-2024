import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget negoPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .56,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * .13,
                    width: width * .3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                              Assets.workwave,
                            ),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel))
                ],
              ),
            ),
            12.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Workwave & Co',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  20.verticalSpace,
                  const Text(
                    "Negotiation",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor),
                  ),
                  // 8.verticalSpace,
                  const Divider(
                    color: AppColors.grey2,
                    thickness: 0.6,
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      const Text(
                        "Actual Price:",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.grey2),
                      ),
                      20.horizontalSpace,
                      const Text(
                        "2300",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Negotiated Amount:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.grey2),
                        ),
                      ),
                      // 4.horizontalSpace,
                      Expanded(flex: 2, child: textField())
                    ],
                  ),
                  12.verticalSpace,
                  const Divider(
                    color: AppColors.grey2,
                    thickness: 0.6,
                  ),
                  20.verticalSpace,
                  negotiationTextField()
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget textField() {
  return SizedBox(
    height: Get.height * .035,
    width: Get.width,
    child: TextFormField(
      style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor),
      decoration: InputDecoration(
        hintText: 'Enter Your Bid Here',
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: AppColors.whiteColor,
        hintStyle: const TextStyle(fontSize: 10, color: Color(0xffC4C4C4)),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
      ),
    ),
  );
}

Widget negotiationTextField() {
  return SizedBox(
    height: Get.height * .044,
    width: Get.width,
    child: Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: 'Write Negotiation Text Here',
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            fillColor: AppColors.whiteColor,
            hintStyle: const TextStyle(
                fontSize: 8,
                color: Color(0xff8D8E99),
                fontFamily: 'Montserrat'),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.blackColor,
            ),
            onPressed: () {},
          ),
        ),
        Positioned(
          right: 35.0,
          child: IconButton(
            icon: const Icon(
              Icons.attach_file_outlined,
              color: AppColors.blackColor,
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}
