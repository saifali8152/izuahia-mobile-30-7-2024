import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/career_profile_tab_controller.dart';
import 'package:izuahia/models/vacancies_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/profile/Career/view_vacancies_popup.dart';
import 'package:izuahia/utils/helper_functions.dart';

class CareerVacanciesTabScreen extends StatefulWidget {
  const CareerVacanciesTabScreen({super.key});

  @override
  State<CareerVacanciesTabScreen> createState() => _CareerVacanciesTabScreenState();
}

class _CareerVacanciesTabScreenState extends State<CareerVacanciesTabScreen> {
  final CareerProfileTabController careerProfileTabController = Get.find<CareerProfileTabController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .7,
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
                      color: AppColors.blackColor.withOpacity(0.15), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4)
                ],
                border: const Border(left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('Vacancies',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(flex: 1, child: filterWidget()),
              // 8.horizontalSpace,
              Expanded(flex: 2, child: textField()),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: Obx(
              () => careerProfileTabController.isVacanciesLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : careerProfileTabController.filteredVacanciesList.isEmpty
                      ? const Center(
                          child: Text('No Vacancies Available'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: careerProfileTabController.filteredVacanciesList.length,
                          itemBuilder: (context, index) {
                            return vacanciesItemWdiegt(
                              vacanciesModel: careerProfileTabController.filteredVacanciesList[index],
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vacanciesItemWdiegt({required VacanciesModel vacanciesModel}) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => viewVacanciesPopUp(context: context, vacanciesModel: vacanciesModel),
        );
      },
      child: Container(
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
                  image: NetworkImage(
                    vacanciesModel.businessImage,
                  ),
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
                  Text(
                    vacanciesModel.businessName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  4.verticalSpace,
                  RichText(
                    text: TextSpan(
                        text: 'Job: ',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: vacanciesModel.jobTitle,
                            style: const TextStyle(
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
                    text: TextSpan(
                        text: 'Salary: ',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: vacanciesModel.jobSalary,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              color: AppColors.yellow,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                  ),
                  5.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: customButton(
                      title: 'Apply',
                      isApplied: vacanciesModel.isApplied,
                      onTap: () async {
                        HelperFunctions.showLoadingDialogue(context);
                        await careerProfileTabController.applyToJob(jobVacancyId: vacanciesModel.jvId);
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
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
        onChanged: careerProfileTabController.setSearchString,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.darkGrey),
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

  Widget filterWidget() {
    return Container(
      height: Get.height * .035,
      width: Get.width,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.filterIcon,
            color: AppColors.blackColor,
          ),
          5.horizontalSpace,
          const Text('Filter',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontFamily: 'Inter', color: AppColors.darkGrey, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget customButton({required VoidCallback onTap, required String title, required int isApplied}) {
    return GestureDetector(
      onTap: isApplied == 1 ? null : onTap,
      child: Container(
        height: Get.height * .045,
        width: Get.width * .2,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(10)),
        child: isApplied == 1
            ? const Text(
                'Applied',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.limeLight,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Text(title,
                style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
