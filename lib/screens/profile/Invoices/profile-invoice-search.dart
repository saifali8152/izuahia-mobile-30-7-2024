import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/ProfileSecDialogs/InvoicesDialogs/invoicesDialogs.dart';
import 'package:izuahia/screens/PROFILE/Invoices/invoice-update-payment.dart';

import '../../../res/assets.dart';

class ProfileInvoiceSearch extends StatefulWidget {
  const ProfileInvoiceSearch({super.key});

  @override
  State<ProfileInvoiceSearch> createState() => _ProfileInvoiceSearchState();
}

class _ProfileInvoiceSearchState extends State<ProfileInvoiceSearch> {
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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 40.h),
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
                'INVOICE',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            12.verticalSpace,
            textField(),
            12.verticalSpace,
            Expanded(
              child: SizedBox(
                height: height,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return invoiceItemWidget(
                        onTap: () {},
                      );
                    }),
              ),
            ),
            15.verticalSpace,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: width * .5,
                        height: height * .04,
                        child:
                            RoundButton(label: 'Download', onPressed: () {})))),
            15.verticalSpace,
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

  Widget invoiceItemWidget({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return profileInvoiceDetailsPopUp(context);
            });
      },
      child: Container(
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
          borderRadius: BorderRadius.circular(5),
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
            const Text('Chris Invoice',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700)),
            4.verticalSpace,
            Row(
              children: [
                const Text('Customer Name:',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: Color(0xff9B9B9B),
                        fontWeight: FontWeight.w600)),
                3.horizontalSpace,
                const Text(' Inayat Ali',
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
                        color: Color(0xff9B9B9B),
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
              children: [
                const Text('Price:',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: Color(0xff9B9B9B),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Payment Status:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.w600)),
                    5.horizontalSpace,
                    const Text('Unpaid',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                updatePaymentButton(
                  onTap: () {
                    Get.to(() => ProfileInvoiceUpdatePaymentSearch());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget updatePaymentButton({required VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .03,
      width: Get.width * .3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.yellow, borderRadius: BorderRadius.circular(5)),
      child: const Text('Update Payment',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500)),
    ),
  );
}
