import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final ThreadTabController tabController = Get.put(ThreadTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
            // padding: EdgeInsets.only(top: 10.h, left: 13.w, right: 13.w, bottom: 30.h),
            decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ordersItemWidget(
                          onTap: () {},
                          image: Assets.mobile,
                        );
                      }),
                ),
              ],
            )));
  }

  Widget ordersItemWidget({required VoidCallback onTap, required String image}) {
    return Container(
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.25),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * .11,
            width: Get.width * .20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              color: AppColors.yellow2,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order #: 123094AF1',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                4.verticalSpace,
                RichText(
                  text: const TextSpan(
                      text: 'Amount Paid: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: '\$450',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
                4.verticalSpace,
                RichText(
                  text: const TextSpan(
                      text: 'Invoice Number: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: '123094AF1',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
                5.verticalSpace,
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customButton(
                        title: "Arrange Delivery",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget customButton({
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .03,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontFamily: 'Inter',
          color: AppColors.black01,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
