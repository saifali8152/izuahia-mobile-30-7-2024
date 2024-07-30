import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class ReconcileTabScreen extends StatelessWidget {
  const ReconcileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> itemList = [
      {'image': Assets.mobile},
      {'image': Assets.laptop1},
      {'image': Assets.shoe},
      {'image': Assets.profileImage},
      {'image': Assets.mobile},
      {'image': Assets.laptop2},
      {'image': Assets.shoe},
      {'image': Assets.profileImage},
      {'image': Assets.profileImage},
    ];

    final height = MediaQuery.sizeOf(context).height;
    // final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: height * .5,
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return reconcileTabItemWidget(
                image: itemList[index]['image'],
                onTap: () {},
                context: context);
          }),
    );
  }

  Widget reconcileTabItemWidget(
      {required String image,
      required VoidCallback onTap,
      required BuildContext context}) {
    return Container(
      // height: Get.height * .20,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.blackColor.withOpacity(0.25),
              offset: const Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 4),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * .17,
                width: Get.width * .28,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        image: AssetImage(Assets.laptop2), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('HP Laptop',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700)),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Condition:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: Color(0xff9B9B9B),
                                fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        const Text('New',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Color:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: Color(0xff9B9B9B),
                                fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        const Text('Grey',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Size:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: Color(0xff9B9B9B),
                                fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        const Text('15 Inch',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    2.verticalSpace,
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Computed Quantity',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: Color(0xff9B9B9B),
                                    fontWeight: FontWeight.w400)),
                            const Text('500',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)),
                            2.verticalSpace,
                            submitButton(title: 'Accept', onTap: onTap)
                          ],
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Count Quantity',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: Color(0xff9B9B9B),
                                    fontWeight: FontWeight.w400)),
                            const Text('4000',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)),
                            submitButton(title: 'Accept', onTap: onTap)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget submitButton({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        width: Get.width * .15,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(5)),
        child: Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                color: AppColors.yellow,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .035,
      width: Get.width * .3,
      child: TextFormField(
        style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Enter Available Quantity',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.darkGrey),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
        ),
      ),
    );
  }

  Widget buttons({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        // width: Get.width * .25,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(5)),
        child: Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                color: AppColors.yellow,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
