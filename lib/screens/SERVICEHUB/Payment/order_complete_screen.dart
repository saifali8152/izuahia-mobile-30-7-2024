import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/screens/SERVICEHUB/Payment/delivery_details_screen.dart';

class OrderCompleteScreen extends StatefulWidget {
  const OrderCompleteScreen({super.key});

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  List<String> itemList = [Assets.master, Assets.paypal, Assets.applePay, Assets.payment4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
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
              ),
              Container(
                padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 80.h),
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const Text(
                          'SUCCESSFULL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              scale: 12,
                              Assets.cart,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    70.verticalSpace,
                    const Center(
                      child: Text(
                        'Order Complete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                    20.verticalSpace,
                    Center(child: SvgPicture.asset(Assets.checkMarkIcon))
                  ],
                ),
              ),

              40.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: RoundButton(
                  label: 'Okay',
                  onPressed: () {
                    Get.to(() => const OrderCompleteScreen());
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
