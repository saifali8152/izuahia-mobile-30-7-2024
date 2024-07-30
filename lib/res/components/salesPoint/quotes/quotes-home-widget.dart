import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/add-button.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/quoteDialogs/create-quote-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/quoteDialogs/edit-quote-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/quoteDialogs/quote-details.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/quotes/sales-point-quotes-search-screen.dart';

class QuotesHomeWidget extends StatefulWidget {
  const QuotesHomeWidget({super.key});

  @override
  State<QuotesHomeWidget> createState() => _QuotesHomeWidgetState();
}

class _QuotesHomeWidgetState extends State<QuotesHomeWidget> {
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
    {'image': Assets.mobile},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .85,
      // constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13), color: AppColors.yellow2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Assets.logo,
                  height: 45,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              20.horizontalSpace,
              const Text(
                'EZYBROT LIMITED',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          12.verticalSpace,
          Container(
            height: height * .048,
            width: width,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 4)
                ],
                border: const Border(
                    left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('BOOTH 1',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  endIndent: 20,
                  height: 1,
                ),
              ),
              Text('QUOTES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  indent: 20,
                  height: 1,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: filterWidget()),
              8.horizontalSpace,
              Expanded(flex: 2, child: textField()),
              8.horizontalSpace,
              Expanded(child: addButton(onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return createQuotePopUp(context);
                    });
              }))
            ],
          ),
          12.verticalSpace,
          SizedBox(
            height: height * .50,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return quotesItemWidget(
                      onTap: () {}, image: itemList[index]['image']);
                }),
          )
        ],
      ),
    );
  }

  Widget filterWidget() {
    return Container(
      height: Get.height * .030,
      width: Get.width,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.filterIcon,
            color: AppColors.blackColor,
          ),
          5.horizontalSpace,
          const Text('Filter',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .030,
      width: Get.width,
      child: TextFormField(
        onTap: () {
          Get.to(() => const SalesPoitnQuotesSearchScreen());
        },
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.darkGrey),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
      ),
    );
  }

  Widget quotesItemWidget(
      {required VoidCallback onTap, required String image}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return quoteDetailsPopUp(context);
            });
      },
      child: Container(
        // height: Get.height * .12,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.fromLTRB(10.w, 8.h, 8.w, 8.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.blackColor.withOpacity(0.25),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 4),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * .12,
                  width: Get.width * .25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover),
                      color: AppColors.yellow2),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('28-02-2024',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Inter',
                            color: Color(0xff9B9B9B),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400)),
                    3.verticalSpace,
                    const Text('Quote',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700)),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Item Name:',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                color: AppColors.darkGrey,
                                fontWeight: FontWeight.w600)),
                        3.horizontalSpace,
                        const Text('iPhone 15 Pro',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                                        4.verticalSpace,
                    
                    Row(
                      children: [
                        const Text('Quantity:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.darkGrey,
                                fontWeight: FontWeight.w600)),
                        5.horizontalSpace,
                        const Text('999',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    4.verticalSpace,       
                    Row(
                      children: [
                        const Text('Price:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.darkGrey,
                                fontWeight: FontWeight.w600)),
                        5.horizontalSpace,
                        const Text('4112',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return editQuotePopUp(context);
                    });
              },
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(3)),
                child: const Icon(
                  Icons.edit,
                  color: AppColors.blackColor,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
