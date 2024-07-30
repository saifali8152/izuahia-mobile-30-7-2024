import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/career_profile_tab_controller.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/models/career_history_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DatePickerController controller = Get.put(DatePickerController());
  final CareerProfileTabController careerHistoryController = Get.put(CareerProfileTabController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .7),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: AppColors.orangeLight),
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
                      color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4)
                ],
                border: const Border(left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('HISTORY',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          SizedBox(
            height: height * .59,
            child: Obx(() {
              return careerHistoryController.isHistoryLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : careerHistoryController.careerHistoryList.isEmpty
                      ? const Center(
                          child: Text("No Career History"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: careerHistoryController.careerHistoryList.length,
                          itemBuilder: (context, index) {
                            return careerHistoryItem(
                              context: context,
                              careerHistoryModel: careerHistoryController.careerHistoryList[index],
                            );
                          });
            }),
          ),
        ],
      ),
    );
  }

  Widget careerHistoryItem({required BuildContext context, required CareerHistoryModel careerHistoryModel}) {
    return Container(
      height: Get.height * .12,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(color: AppColors.blackColor.withOpacity(0.15), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * .10,
            width: Get.width * .26,
            margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: NetworkImage(careerHistoryModel.businessImage), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  careerHistoryModel.businessName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  careerHistoryModel.jobTitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text('Start Date:',
                        style:
                            TextStyle(fontSize: 12, fontFamily: 'Inter', color: Color(0xff757575), fontWeight: FontWeight.w600)),
                    3.horizontalSpace,
                    Text(careerHistoryModel.startDate,
                        style: const TextStyle(
                            fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w400)),
                  ],
                ),
                Row(
                  children: [
                    const Text('End Date:',
                        style:
                            TextStyle(fontSize: 12, fontFamily: 'Inter', color: Color(0xff757575), fontWeight: FontWeight.w600)),
                    3.horizontalSpace,
                    Text(careerHistoryModel.endDate,
                        style: const TextStyle(
                            fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w400)),
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        // width: Get.width * .15,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        padding: const EdgeInsets.symmetric(horizontal: 9),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(7)),
        child: Text(title,
            style: const TextStyle(fontSize: 10, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
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
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(8)),
        child: const Text('View Details',
            style: TextStyle(fontSize: 11, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
