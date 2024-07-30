import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';

class ShopItemOverviewTabView extends StatelessWidget {
  final String overview;
  final String quantity;
  const ShopItemOverviewTabView({
    super.key,
    required this.overview,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
        ),
        10.verticalSpace,
        Text(
          overview,
          textAlign: TextAlign.justify,
          style:
              const TextStyle(fontSize: 10, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
        ),
        10.verticalSpace,
        const Text(
          'Quantity',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
        ),
        10.verticalSpace,
        Text(
          quantity,
          textAlign: TextAlign.justify,
          style:
              const TextStyle(fontSize: 10, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class ShopItemSpecificationsTabView extends StatelessWidget {
  final String specification;
  final String quantity;
  const ShopItemSpecificationsTabView({
    super.key,
    required this.specification,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specification:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
        ),
        10.verticalSpace,
        Text(
          specification,
          textAlign: TextAlign.justify,
          style:
              const TextStyle(fontSize: 10, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
        ),
        10.verticalSpace,
        const Text(
          'Quantity',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
        ),
        10.verticalSpace,
        Text(
          quantity,
          textAlign: TextAlign.justify,
          style:
              const TextStyle(fontSize: 10, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
