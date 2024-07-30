import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/controllers/notifications_controller.dart';
import 'package:izuahia/res/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.grey2.withOpacity(0.4), offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 3)
                        ],
                        color: AppColors.yellow),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.blackColor,
                      size: 18,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            GetBuilder(
                init: NotificationsController(),
                builder: (notificationsController) {
                  return Expanded(
                    child: notificationsController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : notificationsController.notificationsList.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Data Found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: notificationsController.notificationsList.length,
                                itemBuilder: (context, index) {
                                  return notificatinWidget(
                                    title: notificationsController.notificationsList[index].nTitle,
                                    subtitle: notificationsController.notificationsList[index].nDetail,
                                    date: notificationsController.notificationsList[index].createdAt,
                                  );
                                }),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget notificatinWidget({
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Container(
      // height: Get.height * .067,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 8.w, 10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.whiteColor, boxShadow: [
        BoxShadow(color: AppColors.grey3.withOpacity(0.3), offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 7),
        BoxShadow(color: AppColors.grey3.withOpacity(0.3), offset: const Offset(0, -3), spreadRadius: 0, blurRadius: 7),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10, fontFamily: 'Montserrat', color: Color(0xff666666), fontWeight: FontWeight.w600),
              ),
              Text(
                date,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontFamily: 'Montserrat', color: Color(0xff666666), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
