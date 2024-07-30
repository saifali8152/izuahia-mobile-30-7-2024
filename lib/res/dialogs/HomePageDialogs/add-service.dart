import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/add_service_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .65,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GetBuilder<AddServiceController>(
            init: AddServiceController(),
            builder: (controller) {
              return Form(
                key: controller.serviceFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Service',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: customButtons(
                            onTap: () {
                              Get.back();
                            },
                            assets: Assets.cancel,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Service Hub',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                        6.verticalSpace,
                        Obx(() {
                          if (controller.hubs.isEmpty) {
                            return Container(
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.grey3,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xff9392AD,
                                    ).withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                controller.isLoading.value ? 'Loading...' : 'No hubs available',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey2,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.grey3,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xff9392AD,
                                  ).withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: DropdownButton<String>(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              menuMaxHeight: height * .2,
                              value: controller.serviceHubController!.text.isEmpty
                                  ? controller.hubs[0].shId
                                  : controller.serviceHubController!.text,
                              dropdownColor: AppColors.grey3,
                              elevation: 0,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              underline: Container(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: controller.hubs.map((hub) {
                                return DropdownMenuItem<String>(
                                  value: hub.shId,
                                  child: Text(
                                    hub.hubName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.grey2,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                controller.serviceHubController!.text = newValue!;
                                controller.update();
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    8.verticalSpace,
                    textFormFieldWidget(
                      title: 'Service Name',
                      hintText: 'Enter Service Name',
                      controller: controller.serviceNameController,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Service name is required';
                        }
                        return null;
                      },
                    ),
                    8.verticalSpace,
                    textFormFieldWidget(
                      title: 'Service Description',
                      hintText: 'Write Service Description',
                      maxLines: 5,
                      controller: controller.descriptionController,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Service name is required';
                        }
                        return null;
                      },
                    ),
                    10.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Photo',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                        ),
                        4.verticalSpace,
                        InkWell(
                            onTap: () {
                              controller.showImageSourceSelectionDialog();
                            },
                            child: Obx(
                              () => Container(
                                height: height * .09,
                                width: width * .20,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                                child: controller.image != null
                                    ? Image.file(
                                        controller.image!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.photo_camera,
                                        color: AppColors.grey2,
                                        size: 40,
                                      ),
                              ),
                            )),
                      ],
                    ),
                    20.verticalSpace,
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width * .28,
                        height: height * .05,
                        child: RoundButton(
                          label: 'Submit',
                          onPressed: () {
                            if (controller.serviceFormKey!.currentState!.validate()) {
                              log('hub value: ${controller.serviceHubController!.text}');
                              HelperFunctions.showLoadingDialogue(context);
                              controller.createNewService();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
