import 'package:flutter/material.dart';
import 'package:izuahia/res/colors.dart';

class RoundButton extends StatelessWidget {
  final String label;

  final VoidCallback onPressed;

  const RoundButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              color: AppColors.yellow,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        ),
      ),
    );
  }
}
