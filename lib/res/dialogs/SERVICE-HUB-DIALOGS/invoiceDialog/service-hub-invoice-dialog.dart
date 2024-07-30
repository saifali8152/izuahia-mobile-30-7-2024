import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget serviceHubInvoicePopUp(BuildContext context) {
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
                    'Invoice Title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
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
                      10.horizontalSpace,
                      SizedBox(
                          height: 24,
                          width: 24,
                          child: customButtons(
                              onTap: () {
                                Get.back();
                              },
                              assets: Assets.cancel)),
                    ],
                  ),
                ],
              ),
              5.verticalSpace,

              const Divider(
                thickness: 1,
                color: Color(0xff8D8E99),
              ),
              5.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invoice No: 30',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '28-02-2024',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              8.verticalSpace,
              invoiceWidget(),
              5.verticalSpace,
              invoiceWidget(),
              5.verticalSpace,
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              const Text(
                'Invoice Summary',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600),
              ),

              3.verticalSpace,
              const InvoiceDetailItem(title: 'Price:', value: '2400'),
              const InvoiceDetailItem(title: 'Tax:', value: '124'),
              const InvoiceDetailItem(title: 'Total Price:', value: '2524'),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),

              const Text(
                'Customer Details',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600),
              ),

              12.verticalSpace,
              customerDetailsWidget(title: 'John Doe', email: 'info@gmail.com'),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Payment Status:',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600)),
                      5.horizontalSpace,
                      const Text('Unpaid',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              color: Color(0xffF44141),
                              fontWeight: FontWeight.w600)),
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

Widget customerDetailsWidget({
  required String title,
  required String email,
}) {
  return Container(
    constraints: const BoxConstraints(maxHeight: double.infinity),
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(Assets.profileImage),
        ),
        // 13.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(13.w, 4.h, 8.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600)),
                4.verticalSpace,
                Text(email,
                    // 'inayatalibohio@gmail.com',
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w600)),
                5.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget updatePaymentButton({required VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .04,
      width: Get.width * .2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.yellow, borderRadius: BorderRadius.circular(5)),
      child: const Text('Update',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600)),
    ),
  );
}

class InvoiceDetailItem extends StatelessWidget {
  final String title;
  final String value;

  const InvoiceDetailItem(
      {super.key, required this.title, required this.value});

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
                  fontSize: 16,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  color: Color(0xff666666),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

Widget invoiceWidget() {
  return Container(
    height: Get.height * .12,
    width: Get.width,
    decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: AppColors.grey3.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 5),
          BoxShadow(
              color: AppColors.grey3.withOpacity(0.2),
              offset: const Offset(0, -3),
              spreadRadius: 0,
              blurRadius: 5),
        ]),
    child: Row(
      children: [
        Container(
          height: Get.height * .12,
          width: Get.width * .26,
          decoration: const BoxDecoration(
            // color: AppColors.orangeLight,
            image: DecorationImage(
                image: AssetImage(Assets.justiceImage), fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
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
                          fontWeight: FontWeight.w600)),
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
  );
}
