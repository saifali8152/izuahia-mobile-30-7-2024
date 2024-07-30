import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/career_profile_tab_controller.dart';
import 'package:izuahia/models/vacancies_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/buttons.dart';
import 'package:izuahia/utils/helper_functions.dart';

Widget viewVacanciesPopUp({required BuildContext context, required VacanciesModel vacanciesModel}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  final CareerProfileTabController careerProfileTabController = Get.find<CareerProfileTabController>();

  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .65,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vacancy Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: customButtons(
                        onTap: () {
                          Get.back();
                        },
                        assets: Assets.cancel),
                  )
                ],
              ),
            ),
            4.verticalSpace,
            const Divider(
              color: AppColors.grey2,
              thickness: 0.6,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'Montserrat', color: Color(0xff666666), fontWeight: FontWeight.w600),
                        ),
                        Text(
                          vacanciesModel.createdAt,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'Montserrat', color: Color(0xff666666), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: height * .12,
                        width: width * .32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              vacanciesModel.businessImage,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    4.verticalSpace,
                    const Divider(
                      color: AppColors.grey2,
                      thickness: 0.6,
                    ),
                    8.verticalSpace,
                    const Text(
                      "Summary",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                    ),
                    6.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Job Title:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.jobTitle,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Job For:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.jobFor,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Type:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.jobType,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Working hours:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.workingHours,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Requirement:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.jobRequirements,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Salary:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.jobSalary,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Description:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          vacanciesModel.jobDescription,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    25.verticalSpace,
                    Align(
                        alignment: Alignment.center,
                        child: vacanciesModel.isApplied == 0
                            ? customButton(
                                onTap: () async {
                                  HelperFunctions.showLoadingDialogue(context);
                                  await careerProfileTabController.applyToJob(jobVacancyId: vacanciesModel.jvId);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                                title: 'Apply',
                                isApplied: vacanciesModel.isApplied,
                              )
                            : const Text(
                                "Applied",
                                textAlign: TextAlign.justify,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff08E761),
                                ),
                              ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
