// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/service_hub_service_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ServiceUploadImageScreen extends StatelessWidget {
  const ServiceUploadImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> imageFormKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: HubServiceController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: imageFormKey,
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
                    "Service Image",
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
                    "Upload an image to distinct your\nservices from others",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.showImageSourceSelectionDialog();
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Upload Photo",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(Icons.arrow_upward),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => Container(
                      height: height * .09,
                      width: width * .20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.yellow),
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
                        onTap: () async {
                          HelperFunctions.showLoadingDialogue(context);
                          await controller.createNewService().then(
                              (value) => Get.to(() => CustomBottomScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
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
