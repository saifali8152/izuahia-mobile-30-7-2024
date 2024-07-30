// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/service_hub_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SERVICEHUB/addServicesNewScreens/offering%20services%20screens/select_service_screen.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class AerviceHubAddServiceScreen extends StatelessWidget {
  const AerviceHubAddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Add Services",
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
                "What type of service does your\nbusiness offer? Tell us about them.",
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
                onTap: () async {
                   HelperFunctions.showLoadingDialogue(context);
                      await controller
                          .createNewHub()
                          .then((value) => Get.to(() => SelectServiceScreen()));
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Text(
                      "Click to add a Service",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
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
                      await controller
                          .createNewHub()
                          .then((value) => Get.to(() => CustomBottomScreen()));
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
        );
      },
    );
  }
}
