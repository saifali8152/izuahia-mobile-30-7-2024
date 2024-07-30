// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/booth_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20booth%20screens/add_booth_description_screen.dart';

class AddBoothLocationScreen extends StatefulWidget {
  const AddBoothLocationScreen({super.key});

  @override
  State<AddBoothLocationScreen> createState() => _AddBoothLocationScreenState();
}

class _AddBoothLocationScreenState extends State<AddBoothLocationScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? boothLocationFormKey = GlobalKey<FormState>();
    return GetBuilder(
      init: SalesPointBoothController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: boothLocationFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(Assets.appLogo),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Where is your business located? Giving\nexact information of your business\noffice location will help customer\nwithin that area to find you",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          'Select Location',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.whiteColor),
                        ),
                        6.verticalSpace,
                        TextFormField(
                          controller: controller.boothLocationController,
                          decoration: newLocationDeco,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                          onChanged: (value) {
                            if (!controller.listenerAdded) {
                              controller.boothLocationController!
                                  .addListener(controller.listener);
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
                        ),
                        // Obx(
                        //   () =>
                        Container(
                          height: controller.placesList.isEmpty ? 0 : 150,
                          color: AppColors.whiteColor,
                          child: ListView.builder(
                            itemCount: controller.placesList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () async {
                                  controller.boothLocationController!
                                      .removeListener(controller.listener);
                                  controller.turnOffListener();
                                  controller.boothLocationController!.text =
                                      controller.placesList[index]
                                          ['description'];
                                  controller.placesList = [];
                                  controller.getLatLongFromPlaceId(
                                      controller.boothLocationController!.text);
                                },
                                title: Text(controller.placesList[index]
                                    ['description']),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigator?.pop();
                          controller.placesList = [];
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "Previous",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (boothLocationFormKey.currentState!.validate()) {
                            Get.to(() => AddBoothDescriptionScreen());
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
