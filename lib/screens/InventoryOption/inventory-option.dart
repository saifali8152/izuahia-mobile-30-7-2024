import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/shop-items-caard.dart';

import '../../../res/assets.dart';

class InventoryOptionScreen extends StatefulWidget {
  const InventoryOptionScreen({super.key});

  @override
  State<InventoryOptionScreen> createState() => _InventoryOptionScreenState();
}

class _InventoryOptionScreenState extends State<InventoryOptionScreen> {
  final List<Map<String, dynamic>> list = [
    {
      'image': Assets.mobile,
      'title': 'iPhone 15 Pro',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.laptop2,
      'title': 'HP Laptop',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.shoe,
      'title': 'Nike Shoes',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.mobile,
      'title': 'iPhone 15 Pro',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.laptop1,
      'title': 'Dell Laptop',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.shoe,
      'title': 'Nike Shoes',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.mobile,
      'title': 'iPhone 15 Pro',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.shoe,
      'title': 'Nike Shoes',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
    {
      'image': Assets.mobile,
      'title': 'iPhone 15 Pro',
      'discountPrice': '₹599',
      'actualPrice': '₹899',
      'description': 'Sleek design and many interesting features'
    },
  ];

  final DatePickerController controller = Get.put(DatePickerController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.grey2.withOpacity(0.4),
                                offset: const Offset(0, 3),
                                spreadRadius: 0,
                                blurRadius: 3)
                          ],
                          color: AppColors.yellow),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: AppColors.blackColor,
                    endIndent: 20,
                    indent: 10,
                    height: 1,
                  ),
                ),
                const Text('INVENTORY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600)),
                const Expanded(
                  child: Divider(
                    color: AppColors.blackColor,
                    indent: 20,
                    endIndent: 10,
                    height: 1,
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            textField(),
            12.verticalSpace,
            Expanded(
              child: SizedBox(
                  height: height,
                  child: GridView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    itemBuilder: (context, index) {
                      return ShopItemsCard(inventoryModel: HomeInventoryModel.fromJson(list[index]),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.633),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return Stack(
      children: [
        Container(
          height: Get.height * .04,
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: AppColors.grey3.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5),
            BoxShadow(
                offset: const Offset(0, -3),
                color: AppColors.grey3.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5),
          ]),
          child: TextFormField(
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: AppColors.blackColor),
            decoration: InputDecoration(
              hintText: 'Search/Filter: Casual T-Shirt',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              fillColor: AppColors.whiteColor,
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: AppColors.darkGrey),
              filled: true,
              // suffixIcon:
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
              ),
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 4,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5, left: 12),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(3)),
                    child: Transform.scale(
                      scale: 0.6,
                      child: SvgPicture.asset(
                        Assets.filterIcon,
                        color: AppColors.blackColor,
                        height: 20,
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    margin: const EdgeInsets.only(
                        right: 12, top: 5, bottom: 5, left: 12),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(3)),
                    child: Transform.scale(
                      scale: 0.6,
                      child: SvgPicture.asset(
                        Assets.cancel,
                        color: AppColors.blackColor,
                        height: 20,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
