import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/salesPoint/bids/bid-home-widget.dart';

class ServiceHubApplicationWidget extends StatefulWidget {
  const ServiceHubApplicationWidget({super.key});

  @override
  State<ServiceHubApplicationWidget> createState() =>
      _ServiceHubApplicationWidgetState();
}

class _ServiceHubApplicationWidgetState
    extends State<ServiceHubApplicationWidget> {
  final List<Map<String, dynamic>> itemList = [
    {
      'image': Assets.profileImage,
      'label': 'Account Owner',
    },
    {
      'image': Assets.profileImage,
      'label': 'Business Manager',
    },
    {
      'image': Assets.shoe,
      'label': 'Team Manager',
    },
    {
      'image': Assets.profileImage,
      'label': 'Account Owner',
    },
    {
      'image': Assets.profileImage,
      'label': 'Team Manager',
    },
    {
      'image': Assets.profileImage,
      'label': 'Account Owner',
    },
    {
      'image': Assets.profileImage,
      'label': 'Business Managerr',
    },
  ];
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13), color: AppColors.yellow2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Assets.logo,
                  height: 45,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              20.horizontalSpace,
              const Text(
                'WORKWAVE AND CO',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          12.verticalSpace,
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
                      blurRadius: 4)
                ],
                border: const Border(
                    left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('CONSULTING',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  endIndent: 20,
                  height: 1,
                ),
              ),
              Text('APPLICATIONS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  indent: 20,
                  height: 1,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(controller.selectedDate.value);
                  return datePickerWidget(
                      title: formattedDate,
                      onTap: () {
                        controller.selectDate(context);
                      });
                }),
              ),
              8.horizontalSpace,
              Expanded(
                child: Obx(() {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(controller.selectedDate.value);
                  return datePickerWidget(
                      title: formattedDate,
                      onTap: () {
                        controller.selectDate(context);
                      });
                }),
              ),
              8.horizontalSpace,
              Expanded(child: textField()),
            ],
          ),
          12.verticalSpace,
          Expanded(
            child: SizedBox(
              height: height,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return applicationItemWidget(onTap: () {});
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget datePickerWidget({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .033,
        width: Get.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500)),
            5.horizontalSpace,
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.darkGrey,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .035,
      width: Get.width,
      child: TextFormField(
        onTap: () {},
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.darkGrey),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
      ),
    );
  }

  Widget applicationItemWidget({
    required VoidCallback onTap,
  }) {
    return Container(
      // height: Get.height * .12,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        // color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * .14,
            width: Get.width * .26,
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
                  const Text('02/02/2024',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      bidButton(title: 'Accept', onTap: () {}),
                      5.horizontalSpace,
                      bidButton(title: 'Decline', onTap: () {}),
                    ],
                  ),
                  const Divider(
                    color: AppColors.blackColor,
                    thickness: 0.5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
