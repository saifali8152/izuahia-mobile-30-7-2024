import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/SERVICE-HUB-WIDGETS/Receipts/service-hub-receipt-widget.dart';
import 'package:izuahia/res/components/buttons/add-button.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/receiptDialogs/add-receipt-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/receiptDialogs/receipt-details-dialog.dart';
import 'package:izuahia/screens/PROFILE/Receipts/profile-receipt-search-screen.dart';

import '../../../res/assets.dart';

class ProfileReceiptScreen extends StatefulWidget {
  const ProfileReceiptScreen({super.key});

  @override
  State<ProfileReceiptScreen> createState() => _ProfileReceiptScreenState();
}

class _ProfileReceiptScreenState extends State<ProfileReceiptScreen> {
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
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
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
            16.verticalSpace,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'RECEIPT',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            12.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            return addReceiptPopUp(context);
                          });
                    }))
                  ],
                ),
                6.verticalSpace,
                Row(
                  children: [
                    Obx(() {
                      String formattedDate = DateFormat('yyyy-MM-dd')
                          .format(controller.selectedDate.value);
                      return datePickerWidget(
                          title: formattedDate,
                          onTap: () {
                            controller.selectDate(context);
                          });
                    }),
                    7.horizontalSpace,
                    Obx(() {
                      String formattedDate2 = DateFormat('yyyy-MM-dd')
                          .format(controller.selectedDate.value);
                      return datePickerWidget(
                          title: formattedDate2,
                          onTap: () {
                            controller.selectDate(context);
                          });
                    }),
                  ],
                )
              ],
            ),
            12.verticalSpace,
            Expanded(
              child: SizedBox(
                height: height,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return profileReceiptItemWidget(
                        onTap: () {},
                      );
                    }),
              ),
            ),
          ],
        ),
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
          border: Border.all(color: AppColors.yellow)),
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

  Widget datePickerWidget({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .030,
        width: Get.width * .30,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.yellow)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500)),
            5.horizontalSpace,
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.darkGrey,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .030,
      width: Get.width,
      child: TextFormField(
        onTap: () {
          Get.to(() => ProfileReceiptSearchScreen());
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
            size: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColors.yellow, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColors.yellow, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColors.yellow, width: 1),
          ),
        ),
      ),
    );
  }

  Widget profileReceiptItemWidget({required VoidCallback onTap}) {
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
        borderRadius: BorderRadius.circular(10),
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
          const Text('Receipt:34',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400)),
          4.verticalSpace,
          const Text('Service Payment',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400)),
          4.verticalSpace,
          Row(
            children: [
              const Text('From:',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' Workwave & Co',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          3.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Amount:',
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
              detailButton(onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return receiptDetailsPopUp(context);
                    });
              }),
            ],
          ),
        ],
      ),
    );
  }
}
