import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class SalesPointDeliveriesTab extends StatefulWidget {
  const SalesPointDeliveriesTab({super.key});

  @override
  State<SalesPointDeliveriesTab> createState() => _SalesPointDeliveriesTabState();
}

class _SalesPointDeliveriesTabState extends State<SalesPointDeliveriesTab> {
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
              'Deliveries',
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
                return deliveriesItemWidget(
                  onTap: () {},
                  image: Assets.legalPng,
                  context: context,
                  title: "Home Consultation",
                  isPending: index.isOdd ? true : false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveriesItemWidget({
    required String image,
    required VoidCallback onTap,
    required String title,
    required BuildContext context,
    required bool isPending,
  }) {
    return Container(
      // height: Get.height * .12,
      width: Get.width,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * .08,
                width: Get.width * .22,
                margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              text: 'Start Year: ',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '2023',
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
                              text: 'Quoted Cost: ',
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
                              text: 'Estimated Delivery Time: ',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '17 June',
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
                              text: 'Delivering: ',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'South Wales, Modern Park',
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
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
          isPending
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: AppColors.yellow,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          customButton(
                            title: 'Cancel',
                            onTap: () {},
                            bgColor: AppColors.yellow,
                            textColor: AppColors.black01,
                          ),
                          5.horizontalSpace,
                          customButton(title: 'Confirm Delivery', onTap: () {}),
                        ],
                      )
                    ],
                  ),
                )
              : const Text(
                  "Delivered",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w600,
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
