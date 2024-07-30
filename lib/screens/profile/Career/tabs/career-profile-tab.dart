import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/career_profile_tab_controller.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/utils/helper_functions.dart';
import 'package:path/path.dart';

class CareerProfileTabScreen extends StatefulWidget {
  const CareerProfileTabScreen({super.key});

  @override
  State<CareerProfileTabScreen> createState() => _CareerProfileTabScreenState();
}

class _CareerProfileTabScreenState extends State<CareerProfileTabScreen> {
  final CareerProfileTabController careerProfileController = Get.find<CareerProfileTabController>();

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
                            color: AppColors.blackColor.withOpacity(0.15),
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 4)
                      ],
                      border: const Border(left: BorderSide(color: AppColors.blackColor, width: 8))),
                  child: const Text('PROFILE',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
                ),
                12.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        profileInfoWidget(controller: careerProfileController),
                        Obx(
                          () => GestureDetector(
                            onTap: careerProfileController.toggleEditable,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  careerProfileController.isEditable.value ? "Cancel" : "Edit",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff555555),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                4.horizontalSpace,
                                if (!careerProfileController.isEditable.value) SvgPicture.asset(Assets.profileEdit),
                              ],
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        summaryFieldWidget(title: "Summary", controller: careerProfileController),
                        10.verticalSpace,
                        summaryFieldWidget(title: 'Description', controller: careerProfileController),
                        Obx(() => careerProfileController.isEditable.value
                            ? Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    10.verticalSpace,
                                    customButton(
                                      onTap: () async {
                                        HelperFunctions.showLoadingDialogue(context);
                                        if (careerProfileController.summmaryController!.text.isNotEmpty &&
                                            careerProfileController.descriptionController!.text.isNotEmpty) {
                                          await careerProfileController.updateProfile();
                                        }
                                        careerProfileController.toggleEditable();
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      title: 'Save',
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox.shrink()),
                        10.verticalSpace,
                        resumeWidget(
                          context: context,
                          careerProfileTabController: careerProfileController,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget profileInfoWidget({required CareerProfileTabController controller}) {
    return Container(
      height: Get.height * .11,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: Get.height * .09,
              width: Get.width * .20,
              margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: SharedPrefs().getString("profile_pic")!.isEmpty
                      ? DecorationImage(image: NetworkImage(SharedPrefs().getString("profile_pic")!))
                      : const DecorationImage(image: AssetImage(Assets.profileBlank), fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text('Name:',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w600)),
                      3.horizontalSpace,
                      Text('${SharedPrefs().getString("first_name")!} ${SharedPrefs().getString("last_name")!} ',
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Email:',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w600)),
                      3.horizontalSpace,
                      Text(SharedPrefs().getString("email")!,
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Phone:',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w600)),
                      3.horizontalSpace,
                      Text(SharedPrefs().getString("phone") ?? "",
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton({required VoidCallback onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .045,
        width: Get.width * .2,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(20)),
        child: Text(title,
            style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget detailButton({required VoidCallback onTap}) {
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

  Widget summaryFieldWidget({required String title, required CareerProfileTabController controller}) {
    return Obx(() {
      bool isEditable = controller.isEditable.value;
      TextEditingController textController =
          title == 'Summary' ? controller.summmaryController! : controller.descriptionController!;
      return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
            ),
            5.verticalSpace,
            isEditable
                ? TextField(
                    controller: textController,
                    maxLines: 9,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                    ),
                  )
                : Text(
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 10,
                    textController.text.isNotEmpty ? textController.text : "No Data Found",
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      );
    });
  }

  Widget resumeWidget({required BuildContext context, required CareerProfileTabController careerProfileTabController}) {
    return Container(
      height: Get.height * .18,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Resume',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
          12.verticalSpace,
          GestureDetector(
            onTap: () async {
              await careerProfileTabController.openResume();
            },
            child: Text(
                careerProfileTabController.resumeController.value.isNotEmpty
                    ? basename(careerProfileTabController.resumeController.value)
                    : 'No file selected',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                    child: customButton(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Container(
                                      height: Get.height * 0.35,
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Choose an file to upload",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat',
                                                color: AppColors.blackColor),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: InkWell(
                                                onTap: () async {
                                                  await careerProfileTabController.pickResume();
                                                },
                                                child: Obx(
                                                  () => Text(
                                                      careerProfileTabController.resumeFile.value != null
                                                          ? basename(careerProfileTabController.resumeController.value)
                                                          : 'No file selected',
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          color: AppColors.blackColor,
                                                          fontWeight: FontWeight.w700)),
                                                )),
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            children: [
                                              customButton(
                                                  onTap: () async {
                                                    await careerProfileTabController.pickResume();
                                                  },
                                                  title: "Select File"),
                                              10.horizontalSpace,
                                              Obx(() => careerProfileTabController.resumeFile.value != null
                                                  ? customButton(
                                                      onTap: () async {
                                                        HelperFunctions.showLoadingDialogue(context);
                                                        await careerProfileTabController.uploadResume();
                                                        if (context.mounted) {
                                                          Navigator.of(context).pop();
                                                          Navigator.of(context).pop();
                                                        }
                                                      },
                                                      title: "Upload",
                                                    )
                                                  : const SizedBox.shrink()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        title: 'Upload Resume')),
                10.horizontalSpace,
                if (SharedPrefs().getString("resume") != null && SharedPrefs().getString("resume")!.isNotEmpty)
                  Expanded(
                      child: customButton(
                          onTap: () async {
                            HelperFunctions.showLoadingDialogue(context);
                            await careerProfileTabController.deleteResume();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          title: 'Delete')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
