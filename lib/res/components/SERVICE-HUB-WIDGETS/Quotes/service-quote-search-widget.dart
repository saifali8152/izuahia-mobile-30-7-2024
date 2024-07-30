import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/add-button.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/quoteDialogs/quote-details.dart';

class ServiceQuotesSearchWidget extends StatefulWidget {
  const ServiceQuotesSearchWidget({super.key});

  @override
  State<ServiceQuotesSearchWidget> createState() =>
      _ServiceQuotesSearchWidgetState();
}

class _ServiceQuotesSearchWidgetState extends State<ServiceQuotesSearchWidget> {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .8,
      // constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColors.orangeLight),
      child: SingleChildScrollView(
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
                  'WORKWAVE AND CO',
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
              child: const Text('CONSULTING',
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
            textField(),
            12.verticalSpace,
            SizedBox(
              height: height,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return quotesItemWidget(
                        image: itemList[index]['image'], onTap: () {});
                  }),
            ),
            15.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: width * .5,
                            height: height * .038,
                            child: RoundButton(
                                label: 'Download', onPressed: () {}))),
                  ),
                  20.horizontalSpace,
                  Expanded(child: addButton(onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return quoteDetailsPopUp(context);
                        });
                  }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .035,
      width: Get.width,
      child: TextFormField(
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search/Filter: Laptop Quote',
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.darkGrey),
          filled: true,
          suffixIcon: GestureDetector(
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
    return Container(
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
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Get.height * .09,
            width: Get.width * .34,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
                color: AppColors.yellow2),
          ),
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
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(3)),
              child: const Icon(
                Icons.edit,
                color: AppColors.blackColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
