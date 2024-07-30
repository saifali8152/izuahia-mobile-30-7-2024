import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class DeliveryOrdersTab extends StatefulWidget {
  const DeliveryOrdersTab({super.key});

  @override
  State<DeliveryOrdersTab> createState() => _DeliveryOrdersTabState();
}

class _DeliveryOrdersTabState extends State<DeliveryOrdersTab> {
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      constraints: BoxConstraints(minHeight: height * .7),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColors.orangeLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                  blurRadius: 4,
                ),
              ],
              border: const Border(
                left: BorderSide(color: AppColors.blackColor, width: 8),
              ),
            ),
            child: const Text(
              'Orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          12.verticalSpace,
          SizedBox(
            height: height * .59,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return deliveriesOrderItemWidget(
                  onTap: () {},
                  image: Assets.logo,
                  context: context,
                  title: "Home Consultation",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveriesOrderItemWidget({
    required String image,
    required VoidCallback onTap,
    required String title,
    required BuildContext context,
  }) {
    return Container(
      // height: Get.height * .15,
      // width: Get.width ,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.15),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height * .08,
                width: Get.width * .20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text(
                            '24/2/2004',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Inter',
                              color: AppColors.grey2,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Amount Paid: ',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '\$450',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Invoice Number: ',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '123094AF1',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Vendor: ',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'EzyBRot Limited',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(right: 5.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customButton(
                    title: "Arrange Delivery",
                    onTap: () {},
                    bgColor: AppColors.yellow,
                    textColor: AppColors.black01,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customButton({
    required String title,
    required VoidCallback onTap,
    Color bgColor = AppColors.blackColor,
    Color textColor = AppColors.yellow,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        padding: const EdgeInsets.symmetric(horizontal: 9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Inter',
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget detailButton({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        width: Get.width * .2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'View Details',
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'Inter',
            color: AppColors.yellow,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}