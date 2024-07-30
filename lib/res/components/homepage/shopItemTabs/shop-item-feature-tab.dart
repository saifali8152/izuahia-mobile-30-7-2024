import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/colors.dart';

class ShopItemFeatureTabViews extends StatelessWidget {
  final String features;
  final List<String> imagesList;
  const ShopItemFeatureTabViews({
    super.key,
    required this.features,
    required this.imagesList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        const Text(
          'Features',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
        ),
        10.verticalSpace,
        Text(
          features,
          textAlign: TextAlign.justify,
          style:
              const TextStyle(fontSize: 10, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
        ),
        GridView.builder(
          itemCount: imagesList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return customWidget(
              imagePath: imagesList[index],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ],
    );
  }

  Widget customWidget({required String imagePath}) {
    return Container(
      height: 85,
      width: 85,
      margin: const EdgeInsets.only(right: 10, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey3, width: 1),
          image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover)),
    );
  }
}
