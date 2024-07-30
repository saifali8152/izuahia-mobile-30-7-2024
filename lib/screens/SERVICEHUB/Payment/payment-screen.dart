import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/screens/SERVICEHUB/Payment/payment-successfull-screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> itemList = [
    Assets.master,
    Assets.paypal,
    Assets.applePay,
    Assets.payment4,
    Assets.paymentVisa,
    Assets.paymentCash,
    Assets.paymentCoupon,
  ];

  var counter = 0;

  increment() {
    setState(() {
      counter++;
    });
  }

  decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.yellow),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.blackColor,
                    size: 18,
                  ),
                ),
              ),
            ),
            Container(
                // height: height,
                // width: width,
                padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 10.h),
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          const Text(
                            'PAYMENT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                Assets.cart,
                                color: Colors.black,
                                scale: 12,
                              ))
                        ],
                      ),
                      10.verticalSpace,
                      const Text(
                        'Select payment method',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                      ),
                      10.verticalSpace,
                      Center(
                        child: Wrap(
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                          children: [
                            paymentTypeButton(onTap: () {}, asset: itemList[0]),
                            paymentTypeButton(onTap: () {}, asset: itemList[1]),
                            paymentTypeButton(onTap: () {}, asset: itemList[2]),
                            paymentTypeButton(onTap: () {}, asset: itemList[3]),
                            paymentTypeButton(onTap: () {}, asset: itemList[4]),
                            paymentTypeButton(onTap: () {}, asset: itemList[5]),
                            paymentTypeButton(onTap: () {}, asset: itemList[6]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.58,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              textFormFieldWidget(
                                title: 'Card Holder Name',
                                hintText: 'Enter Card Holder Name',
                              ),
                              10.verticalSpace,
                              textFormFieldWidget(
                                title: 'Card Number',
                                hintText: 'Enter Card Number',
                              ),
                              10.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: textFormFieldWidget(
                                      title: 'EXP Date',
                                      hintText: 'EXP Date',
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Expanded(
                                    child: textFormFieldWidget(
                                      title: 'CVC',
                                      hintText: 'CVC',
                                    ),
                                  ),
                                ],
                              ),
                              30.verticalSpace,
                              summaryWidget(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }


  Widget paymentTypeButton({required VoidCallback onTap, required String asset}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 53,
        width: 76,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: AppColors.grey1.withOpacity(0.4), offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 3),
              BoxShadow(color: AppColors.grey1.withOpacity(0.4), offset: const Offset(0, -0), spreadRadius: 0, blurRadius: 3),
            ],
            color: AppColors.whiteColor),
        child: Center(
          child: Image.asset(
            asset,
            height: 40,
          ),
        ),
      ),
    );
  }

  Widget summaryWidget() {
    return Container(
      // height: Get.height * .28,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 60),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.orangeLight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Summary',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)),
          5.verticalSpace,
          const Divider(
            color: AppColors.blackColor,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Amount:',
                  style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
              5.horizontalSpace,
              const Text('54300',
                  style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
            ],
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shipping charges:',
                  style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
              5.horizontalSpace,
              const Text('654',
                  style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
            ],
          ),
          5.verticalSpace,
          const Divider(
            color: AppColors.blackColor,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)),
              5.horizontalSpace,
              const Text('782783',
                  style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)),
            ],
          ),
          12.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85),
            child: RoundButton(
              label: 'Make Payment',
              onPressed: () {
                Get.to(() => const PaymentSuccessfullScreen());
              },
            ),
          )
        ],
      ),
    );
  }
}
