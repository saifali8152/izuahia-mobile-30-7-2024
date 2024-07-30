import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/invoiceDialogs/invoice-deatails-dialog.dart';
import 'package:izuahia/screens/SALESPOINTSCREENS/invoice/sales-point-invoice-search-screen.dart';

class InVoiceHomeWidget extends StatefulWidget {
  const InVoiceHomeWidget({super.key});

  @override
  State<InVoiceHomeWidget> createState() => _InVoiceHomeWidgetState();
}

class _InVoiceHomeWidgetState extends State<InVoiceHomeWidget> {
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

  final DatePickerController controller = Get.put(DatePickerController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .35),
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
              Text('INVOICE',
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
              Expanded(
                child: Obx(() {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(controller.selectedDate.value);
                  return datePickerWidget(
                      title: formattedDate,
                      onTap: () {
                        controller.selectDate(context);
                      });
                }),
              ),
              8.horizontalSpace,
              Expanded(
                child: Obx(() {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(controller.selectedDate.value);
                  return datePickerWidget(
                      title: formattedDate,
                      onTap: () {
                        controller.selectDate(context);
                      });
                }),
              ),
              8.horizontalSpace,
              Expanded(child: textField()),
            ],
          ),
          12.verticalSpace,
          SizedBox(
            height: height * .5,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return inVoiceItemWidget(
                      image: itemList[index]['image'], onTap: () {});
                }),
          )
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
        width: Get.width,
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
          Get.to(() => const SalesPointInvoiceSearchScreen());
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
            size: 22,
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

  Widget inVoiceItemWidget(
      {required VoidCallback onTap, required String image}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return invoiceDetailsPopUp(context);
            });
      },
      child: Container(
        // height: Get.height * .12,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.fromLTRB(10.w, 7.h, 0, 8.h),
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
                  height: Get.height * .09,
                  width: Get.width * .34,
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
                    const Text('Invoice No',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700)),
                    2.verticalSpace,
                    const Text('Invoice Name',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400)),
                    4.verticalSpace,
                    Row(
                      children: [
                        const Text('Invoice Amount:',
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
                  ],
                ),
              ],
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     height: 24,
            //     width: 24,
            //     decoration: BoxDecoration(
            //         color: AppColors.yellow,
            //         borderRadius: BorderRadius.circular(3)),
            //     child: const Icon(
            //       Icons.edit,
            //       color: AppColors.blackColor,
            //       size: 20,
            //     ),
            //   ),
            // ),
            // Checkbox(value: false, onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}
