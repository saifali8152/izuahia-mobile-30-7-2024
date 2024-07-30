import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izuahia/res/colors.dart';

Widget customButtons({
  required VoidCallback onTap,
  required String assets,
}) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      color: const Color(0xffFFF9E5),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap,
        child: SvgPicture.asset(
          assets,
          height: 16,
        )),
  );
}

Widget button({
  required VoidCallback onTap,
  required String assets,
}) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      color: AppColors.blackColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onTap,
        child: SvgPicture.asset(
          assets,
          height: 15,
        )),
  );
}
