import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/salesPoint/invoices/invoice-search-widget.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/quoteDialogs/quote-details.dart';

Widget profileInvoiceDetailsPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Invoice Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel)),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Invoice Title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700),
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
              const Divider(
                thickness: 1,
                color: Color(0xff8D8E99),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invoice No: 30',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '28-02-2024',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.italic,
                        color: AppColors.grey2,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              8.verticalSpace,
              quoteWidget(),
              5.verticalSpace,
              quoteWidget(),
              12.verticalSpace,
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              const Text(
                'Invoice Summary',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600),
              ),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              3.verticalSpace,
              const DetailItem(title: 'Price:', value: '2400'),
              const DetailItem(title: 'Tax:', value: '124'),
              const DetailItem(title: 'Total Price:', value: '2524'),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              15.verticalSpace,
              customerDetailsWidget(
                  title: 'Vendor Details',
                  asset: Assets.workwave,
                  name: 'Workwave and Co',
                  email: 'info@gmail.com'),
              30.verticalSpace,
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
                  updatePaymentButton(onTap: () {}),
                ],
              ),
              // Align(
              //     alignment: Alignment.center,
              //     child: SizedBox(
              //         width: width * .24,
              //         height: height * .042,
              //         child: RoundButton(label: 'Done', onPressed: () {}))),
            ],
          ),
        ),
      ),
    ),
  );
}
