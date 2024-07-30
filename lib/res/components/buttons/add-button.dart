import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

Widget addButton({
  required VoidCallback onTap,
}) {
  return Container(
    height: 28,
    width: 110,
    decoration: BoxDecoration(
      color: AppColors.blackColor,
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.add,
              height: 10,
            ),
            5.horizontalSpace,
            Text(
              'Add',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.yellow),
            ),
          ],
        )),
  );
}
