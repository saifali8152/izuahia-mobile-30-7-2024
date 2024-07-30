// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';

Widget profileFieldWidget({
  required String hintText,
  String? labelText,
  String? label,
  var errorStyle,
  bool filled = false,
  Color? filledColor,
  var labelStyle,
  var preffixIcon,
  Widget? suffixIcon,
  var initialValue,
  int maxLines = 1,
  FocusNode? focusNode,
  bool autoFocus = false,
  bool obscureText = false,
  bool readOnly = false,
  bool inDense = false,
  var style,
  double radius = 8,
  TextEditingController? controller,
  String? Function(String?)? onValidator,
  String? Function(String)? onChanged,
  String? Function(String)? onFieldSubmitted,
  Function()? suffixTap,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
}) {
  return Container(
    height: 35.h,
    width: Get.width,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8.0), boxShadow: [
      BoxShadow(
          offset: const Offset(0, 3),
          spreadRadius: 0,
          blurRadius: 5,
          color: AppColors.grey2.withOpacity(0.1)),
      BoxShadow(
          offset: const Offset(0, -3),
          spreadRadius: 0,
          blurRadius: 5,
          color: AppColors.grey3.withOpacity(0.1))
    ]
            // ignore: prefer_const_constructors
            ),
    child: TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      autofocus: autoFocus,
      readOnly: readOnly,
      style: const TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
        fontSize: 14,
      ),
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: onValidator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        isDense: inDense,
        fillColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        errorStyle: errorStyle,
        labelStyle: labelStyle,
        labelText: labelText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        prefixIcon: preffixIcon,
        hintStyle: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
          fontSize: 14,
        ),
      ),
    ),
  );
}
