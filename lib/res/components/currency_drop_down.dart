import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';

class CurrencyDropdownButton extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? initialValue;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final dynamic color;
  final dynamic fontColor;

  const CurrencyDropdownButton({
    super.key,
    required this.hintText,
    required this.items,
    required this.controller,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.color,
    this.fontColor,
  });

  @override
  State<StatefulWidget> createState() => _CurrencyDropwdownButtonState();
}

class _CurrencyDropwdownButtonState extends State<CurrencyDropdownButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue ?? "USD";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: false,
          fillColor: widget.color ?? AppColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10.h),
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
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            color: widget.fontColor ?? AppColors.grey1,
            fontSize: 16,
          ),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.blackColor,
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: "Montserrat-Regular",
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                      fontSize: 12,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            widget.controller.text = value ?? "";
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        validator: widget.validator,
      ),
    );
  }
}
