import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/add-button.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/receiptDialogs/add-receipt-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/receiptDialogs/edit-receipt-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/receiptDialogs/receipt-details-dialog.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/receipt/sales-point-receipt-search-screen.dart';

class ReceiptHomeWidget extends StatefulWidget {
  const ReceiptHomeWidget({super.key});

  @override
  State<ReceiptHomeWidget> createState() => _ReceiptHomeWidgetState();
}

class _ReceiptHomeWidgetState extends State<ReceiptHomeWidget> {
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .3),
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
          20.verticalSpace,
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  endIndent: 20,
                  height: 1,
                ),
              ),
              Text('RECEIPT',
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
          SizedBox(
            height: height * .5,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return receiptItemWidget(onTap: () {});
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

  Widget datePickerWidget({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .030,
        width: Get.width * .3,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
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
          Get.to(() => const SalesPoitnReceiptSearchScreen());
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

  Widget receiptItemWidget({required VoidCallback onTap}) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('28-02-2024',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Inter',
                      color: Color(0xff9B9B9B),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400)),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return editReceiptPopUp(context);
                      });
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(3)),
                  child: const Icon(
                    Icons.edit,
                    color: AppColors.blackColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          4.verticalSpace,
          const Text('Receipt:34',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400)),
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
                      fontSize: 10,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          5.verticalSpace,
          Row(
            children: [
              const Text('Quantity:',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' 03',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
              customButton(onTap: () {
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

Widget customButton({
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .028,
      width: Get.width * .2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.blackColor, borderRadius: BorderRadius.circular(8)),
      child: const Text('View Details',
          style: TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              color: AppColors.yellow,
              fontWeight: FontWeight.w500)),
    ),
  );
}