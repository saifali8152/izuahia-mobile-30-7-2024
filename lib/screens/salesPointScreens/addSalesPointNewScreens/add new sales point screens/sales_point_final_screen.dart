// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/sales_point_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20booth%20screens/add_booth_select_sale_screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class SalesPointFinalScreen extends StatelessWidget {
  const SalesPointFinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SalesPointController(),
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
                "Add Booth",
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
                "Booths are outlets, shops, warehouses, or\nminilocations of your business. To sell items\nyou need to add at least one booth",
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
                      .createNewsalesPoint()
                      .then((value) => Get.to(() => BoothSelectSalesScreen()));
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
                      "Click to add a Booth",
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
                          .createNewsalesPoint()
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
