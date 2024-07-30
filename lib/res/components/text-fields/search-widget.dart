// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';

Widget searchFieldWidget({
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
    height: 25.h,
    width: 230.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      // ignore: prefer_const_constructors
    ),
    child: TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      autofocus: autoFocus,
      readOnly: readOnly,
      style: const TextStyle(
        fontFamily: "Montserrat-Regular",
        fontWeight: FontWeight.w500,
        color: AppColors.yellow,
        fontSize: 12,
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
        fillColor: AppColors.blackColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        errorStyle: errorStyle,
        labelStyle: labelStyle,
        labelText: labelText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: AppColors.blackColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: AppColors.blackColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: AppColors.blackColor, width: 1),
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        prefixIcon: preffixIcon,
        hintStyle: const TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          color: AppColors.yellow,
          fontSize: 10,
        ),
      ),
    ),
  );
}
