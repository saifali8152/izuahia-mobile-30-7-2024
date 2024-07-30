import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/SERVICE-HUB-DIALOGS/invoiceDialog/service-hub-invoice-dialog.dart';

import '../../../res/assets.dart';

class ServiceHubInvoiceSearchScreen extends StatefulWidget {
  const ServiceHubInvoiceSearchScreen({super.key});

  @override
  State<ServiceHubInvoiceSearchScreen> createState() =>
      _ServiceHubInvoiceSearchScreenState();
}

class _ServiceHubInvoiceSearchScreenState
    extends State<ServiceHubInvoiceSearchScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(103, 10, 103, 10),
          child: SizedBox(
              width: width * .48,
              height: height * .045,
              child: RoundButton(label: 'Download', onPressed: () {})),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 0.h),
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
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.workwave,
                  height: 50,
                ),
                10.horizontalSpace,
                const Text('WorkWave and Co.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            12.verticalSpace,
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.blackColor,
                    endIndent: 20,
                    indent: 10,
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
                    endIndent: 10,
                    height: 1,
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            textField(),
            20.verticalSpace,
            Expanded(
              child: SizedBox(
                height: height,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return invoiceItemWidget(
                        onTap: () {},
                        image: itemList[index]['image'],
                      );
                    }),
              ),
            ),
          ],
        ),
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
            boxShadow: [
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
    return Container(
      height: Get.height * .037,
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
            borderRadius: BorderRadius.circular(3.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
      ),
    );
  }

  Widget invoiceItemWidget(
      {required VoidCallback onTap, required String image}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return serviceHubInvoicePopUp(context);
            });
      },
      child: Container(
        // height: Get.height * .12,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 12),

        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey3.withOpacity(0.4),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 4),
            BoxShadow(
                color: AppColors.grey3.withOpacity(0.4),
                offset: const Offset(0, -4),
                spreadRadius: 0,
                blurRadius: 4),
          ],
          borderRadius: BorderRadius.circular(12),
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
                  width: Get.width * .3,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      image: DecorationImage(
                          image: AssetImage(Assets.justiceImage),
                          fit: BoxFit.cover),
                      color: AppColors.yellow2),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 7.h, 0, 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Justice Law Firm',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700)),
                      2.verticalSpace,
                      const Text('Invoice Number',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Inter',
                              color: Color(0xff666666),
                              fontWeight: FontWeight.w400)),
                      4.verticalSpace,
                      const Text('28-02-2024',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Inter',
                              color: Color(0xff9B9B9B),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400)),
                      8.verticalSpace,
                      Row(
                        children: [
                          const Text('Invoice Amount:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500)),
                          5.horizontalSpace,
                          const Text('₹599',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
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
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 8),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    margin: const EdgeInsets.only(
                        right: 12, top: 5, bottom: 5, left: 12),
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(3)),
                    child: Transform.scale(
                      scale: 0.6,
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.blackColor,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
