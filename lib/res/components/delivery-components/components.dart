import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:izuahia/res/colors.dart';

Widget textsWidget({required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Text(
            '24/2/2004',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Inter',
              color: AppColors.grey2,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      RichText(
        overflow: TextOverflow.ellipsis,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Order #: ',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: Color(0xff757575),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' 123094AF1',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      RichText(
        overflow: TextOverflow.ellipsis,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Quoted Cost: ',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: Color(0xff757575),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '\$450',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      RichText(
        overflow: TextOverflow.ellipsis,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Estimated Delivery Time: ',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: Color(0xff757575),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '17 June',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      RichText(
        overflow: TextOverflow.ellipsis,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Delivering: ',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: Color(0xff757575),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: 'South Wales, Modern Park',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      10.verticalSpace,
    ],
  );
}


  Widget customButton({
    required String title,
    required VoidCallback onTap,
    Color bgColor = AppColors.blackColor,
    Color textColor = AppColors.yellow,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
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
            fontSize: 10,
            fontFamily: 'Inter',
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }