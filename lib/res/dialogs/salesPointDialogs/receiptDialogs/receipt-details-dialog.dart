import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget receiptDetailsPopUp(BuildContext context) {
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
                    'Receipt Details',
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
                    'Product Details',
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
              const DetailItem(title: 'Product Name', value: 'iPhone 15 Pro'),
              const DetailItem(title: 'Receipt Date', value: '28-02-2024'),
              const DetailItem(title: 'Receipt No', value: '34'),
              const DetailItem(title: 'Purchased By', value: 'Jamaica Royal'),
              const DetailItem(title: 'Vendor', value: 'Ezybrot Limited'),
              const DetailItem(
                  title: 'Note',
                  value:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '),
              12.verticalSpace,
              receiptDetailsWidget(onTap: () {}),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              const Text(
                'Price Details',
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
              6.verticalSpace,
              const DetailItem(title: 'Price:', value: '2400'),
              const DetailItem(title: 'Tax:', value: '124'),
              const DetailItem(title: 'Total Price:', value: '2524'),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              15.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: width * .24,
                      height: height * .042,
                      child: RoundButton(label: 'Done', onPressed: () {}))),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget receiptDetailsWidget({
  required VoidCallback onTap,
}) {
  return Container(
    constraints: const BoxConstraints(maxHeight: double.infinity),
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * .11,
          width: Get.width * .21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                  image: AssetImage(Assets.profileImage), fit: BoxFit.cover),
              color: AppColors.yellow2),
        ),
        // 13.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(13.w, 4.h, 8.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Customer Details',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600)),
                const Divider(
                  color: AppColors.blackColor,
                  thickness: 0.5,
                ),
                2.verticalSpace,
                Row(
                  children: [
                    const Text('Name:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w600)),
                    8.horizontalSpace,
                    const Text('Inayat Ali',
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
                    const Text('Email:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w600)),
                    8.horizontalSpace,
                    const Text('inayatalibohio@gmail.com',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                5.verticalSpace,
                const Divider(
                  color: Color(0xff8D8E99),
                  thickness: 0.5,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
