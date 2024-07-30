import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:izuahia/controllers/edit_profile_controller.dart';
import 'package:izuahia/controllers/home_page_controller.dart';
import 'package:izuahia/controllers/profile_controller.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/utils/helper_functions.dart';

final HomeScreenController homeController = Get.find<HomeScreenController>();

Widget selectDefaultLocationPopup(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  ProfileController profileScreenController = Get.find<ProfileController>();
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .5,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                height: 30,
                width: 30,
                child: customButtons(
                    onTap: () {
                      Get.back();
                    },
                    assets: Assets.cancel),
              ),
            ),
            GetBuilder(
                init: EditProfileController(),
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Select Default Location",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: AppColors.textColor,
                        ),
                      ),
                      6.verticalSpace,
                      Obx(() {
                        return controller.isLocationSelected.value
                            ? Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.grey3, borderRadius: BorderRadius.all(Radius.circular(5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.55,
                                        child: Text(
                                          controller.locationController!.text,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          log('message');
                                          controller.clearLocation();
                                        },
                                        icon: const Icon(Icons.clear),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : TextFormField(
                                controller: controller.locationController,
                                decoration: InputDecoration(
                                  fillColor: AppColors.grey3,
                                  hintText: 'Enter Location',
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      HelperFunctions.showLoadingDialogue(context);
                                      controller.locationController!.removeListener(controller.listener);
                                      controller.turnOffListener();
                                      controller.placesList = [];
                                      await homeController.getUserLocation();
                                      controller.locationController!.text = await homeController.getAddress(
                                          double.parse(homeController.latitude.value),
                                          double.parse(homeController.longitude.value));
                                      await homeController.getHomeData();
                                      homeController.update();
                                      profileScreenController.update();
                                      SharedPrefs().setBool('default_location_set', true);
                                      SharedPrefs().setString('default_location', controller.locationController!.text);
                                      controller.isLocationSelected.value = true; // Update this line
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.gps_fixed),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey2,
                                    fontSize: 10,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  color: AppColors.blackColor,
                                ),
                                onChanged: (value) {
                                  log('printed $value');
                                  if (!controller.listenerAdded) {
                                    controller.locationController!.addListener(controller.listener);
                                    controller.turnOnListener();
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Location is required';
                                  } else {
                                    return null;
                                  }
                                },
                                enabled: !controller.isLocationSelected.value, // Add this line
                              );
                      }),
                      SizedBox(
                        height: controller.placesList.isEmpty ? 0 : 150,
                        child: ListView.builder(
                          itemCount: controller.placesList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                HelperFunctions.showLoadingDialogue(context);
                                controller.locationController!.removeListener(controller.listener);
                                controller.turnOffListener();
                                controller.locationController!.text = controller.placesList[index]['description'];
                                controller.placesList = [];
                                await controller.getLatLongFromPlaceId(controller.locationController!.text);
                                await homeController.getHomeData();
                                SharedPrefs().setString('default_location', controller.locationController!.text);
                                controller.isLocationSelected.value = true; // Update this line
                                Get.back();
                                controller.update();
                                homeController.update();
                                profileScreenController.update();
                              },
                              title: Text(controller.placesList[index]['description']),
                            );
                          },
                        ),
                      ),
                      8.verticalSpace,
                    ],
                  );
                }),
          ],
        ),
      ),
    ),
  );
}

Widget customButtons({
  required VoidCallback onTap,
  required String assets,
}) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      color: AppColors.blackColor,
      borderRadius: BorderRadius.circular(2.0),
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onTap,
        child: SvgPicture.asset(
          assets,
          height: 15,
        )),
  );
}
