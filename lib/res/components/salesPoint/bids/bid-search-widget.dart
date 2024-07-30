import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/salesPoint/bids/bid-home-widget.dart';

class BidSearchWidget extends StatefulWidget {
  const BidSearchWidget({super.key});

  @override
  State<BidSearchWidget> createState() => _BidSearchWidgetState();
}

class _BidSearchWidgetState extends State<BidSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .78,
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
                Text('BIDS',
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
              height: height * .44,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return bidsItemWidget(onTap: () {});
                  }),
            ),
            15.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: width * .5,
                      height: height * .04,
                      child: RoundButton(label: 'Download', onPressed: () {}))),
            )
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .04,
      width: Get.width,
      child: TextFormField(
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Date: 12-02-2024 to 28-02-2024',
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

  Widget bidsItemWidget({required VoidCallback onTap}) {
    return Container(
      // height: Get.height * .17,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('28-02-2024',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  color: Color(0xff9B9B9B),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400)),
          4.verticalSpace,
          Row(
            children: [
              const Text('Customer:',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' Name of Customer',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          4.verticalSpace,
          Row(
            children: [
              const Text('Item Name:',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' iPhone 15 Pro',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          5.verticalSpace,
          Row(
            children: [
              const Text('Inventory:',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' 03',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          4.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Text('Price:',
                        style: TextStyle(
                            fontSize: 12,
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
              ),
              Expanded(
                child: Row(
                  children: [
                    const Text('Bid:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w600)),
                    5.horizontalSpace,
                    const Text('2300',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  children: [
                    bidButton(title: 'Accept', onTap: () {}),
                    5.horizontalSpace,
                    bidButton(title: 'Decline', onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
