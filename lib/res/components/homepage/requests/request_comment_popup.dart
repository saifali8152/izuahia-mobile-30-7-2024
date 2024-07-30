import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/homepage/requests/buttons.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/request_controller.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/utils/helper_functions.dart';

Widget requestCommentPopUp({
  required BuildContext context,
  required String title,
  String? imagePath,
  required String location,
  String? irId,
  String? srId,
  required String requestType,
  required List dropDownList,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;

  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .72,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder(
            init: RequestsController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height * .22,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: imagePath == null
                                  ? const DecorationImage(image: AssetImage(Assets.noImage), fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: NetworkImage(imagePath),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                              top: 20,
                              right: 20,
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: customButtons(
                                      onTap: () {
                                        Get.back();
                                      },
                                      assets: Assets.cancel)))
                        ],
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            // 8.verticalSpace,
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat-Itallic',
                                color: AppColors.textColor,
                              ),
                            ),
                            8.verticalSpace,

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  requestType == 'inventory' ? "Select Sales Point" : 'Select Service Hub',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                6.verticalSpace,
                                DropdownButton<String>(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  menuMaxHeight: height * .2,
                                  value: requestType == 'inventory' ? dropDownList[0].spId : dropDownList[0].shId,
                                  dropdownColor: AppColors.grey3,
                                  elevation: 0,
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(10),
                                  underline: Container(),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: dropDownList.map((datum) {
                                    return DropdownMenuItem<String>(
                                      value: requestType == 'inventory' ? datum.spId : datum.shId,
                                      child: Text(
                                        requestType == 'inventory' ? datum.spName : datum.hubName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.grey2,
                                          fontSize: 10,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.dropDownValueController!.text = newValue!;
                                  },
                                ),
                              ],
                            ),
                            8.verticalSpace,
                            textFormFieldWidget(
                              title: 'Comment / Inquiry',
                              controller: controller.commentController,
                              hintText: 'Write Comment / Inquiry',
                              onValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'comment can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 7,
                            ),
                            20.verticalSpace,
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: width * .3,
                                height: height * .05,
                                child: RoundButton(
                                  label: 'Submit',
                                  onPressed: () async {
                                    log('inventory id: $irId');
                                    if (controller.formKey.currentState!.validate()) {
                                      HelperFunctions.showLoadingDialogue(context);
                                      if (requestType == 'inventory') {
                                        await controller.commentInventory(
                                          inventoryRequestId: irId!,
                                          salesPointId: controller.dropDownValueController!.text.isNotEmpty
                                              ? controller.dropDownValueController!.text.isNotEmpty
                                              : requestType == 'inventory'
                                                  ? dropDownList[0].spId
                                                  : dropDownList[0].shId,
                                        );
                                      } else {
                                        await controller.commentService(
                                          serviceRequestId: srId!,
                                          serviceHubId: controller.dropDownValueController!.text.isNotEmpty
                                              ? controller.dropDownValueController!.text.isNotEmpty
                                              : requestType == 'inventory'
                                                  ? dropDownList[0].spId
                                                  : dropDownList[0].shId,
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    ),
  );
}
