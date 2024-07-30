// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/service_hub_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SERVICEHUB/addServicesNewScreens/add%20service%20hub%20screens/service_hub_add_service_screen.dart';

class ServiceHubUploadImageScreen extends StatelessWidget {
  const ServiceHubUploadImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: ServiceHubController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
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
                "Service Hub Image",
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
                "Upload an image to distinct your\nbusiness from others",
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
                    onTap: () {
                      Get.to(() => AerviceHubAddServiceScreen());
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
        );
      },
    );
  }
}
