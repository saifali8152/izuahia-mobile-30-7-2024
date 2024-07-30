import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';

class InfoContainer extends StatelessWidget {
  final String text;
  final String? iconPath;
  const InfoContainer({
    super.key,
    required this.text,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.042,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.grey1,
      ),
      child: Row(
        mainAxisAlignment: iconPath != null ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          iconPath != null
              ? SvgPicture.asset(
                  iconPath ?? "",
                  color: Colors.black,
                )
              : const SizedBox.shrink(),
          5.horizontalSpace,
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              color: iconPath != null ? AppColors.blackColor : AppColors.darkGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class NoteTextField extends StatelessWidget {
  const NoteTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.042,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.grey1,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Note',
          hintStyle: TextStyle(
            fontSize: 11,
            fontFamily: 'Inter',
            color: Colors.grey[700], // AppColors.darkGrey,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        ),
        style: const TextStyle(
          fontSize: 11,
          fontFamily: 'Inter',
          color: Colors.black, // AppColors.darkGrey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
