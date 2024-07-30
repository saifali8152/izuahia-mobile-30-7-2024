import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget ledgerDetailsPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .5,
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
                    'Ledger Details',
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
              const Text(
                '02/03/2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 8,
                    fontFamily: 'Montserrat',
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w600),
              ),
              12.verticalSpace,
              const Text(
                'Purchase of Telecoms Cable',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xff8D8E99),
              ),
              10.verticalSpace,
              detailRowWidget(label: 'Posted By:', value: 'Inayat Ali'),
              detailRowWidget(label: 'Ledger Type:', value: 'Cash Spent'),
              detailRowWidget(label: 'Ledger Amoun:', value: r'$656700'),
              detailRowWidget(label: 'Ledger Category:', value: 'Cash Ledger'),
              15.verticalSpace,
              Text(
                'Notes:',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget detailRowWidget({required String label, required String value}) {
  return Row(
    children: [
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 10,
            fontFamily: 'Montserrat',
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600),
      ),
      4.horizontalSpace,
      Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700),
      ),
    ],
  );
}
