// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/sales_point_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/components/text-fields/text_form_field_business.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20sales%20point%20screens/sales_point_location_screen.dart';

class SalesPointWebsiteScreen extends StatelessWidget {
  const SalesPointWebsiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? salesPointWebsiteFormKey = GlobalKey<FormState>();
    return GetBuilder(
      init: SalesPointController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: salesPointWebsiteFormKey,
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
                    "Website",
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
                    "Does your business have a website? If\nso, tell us about it.",
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
                    child: textFormFieldBusinessWidget(
                      hintText: 'Enter Website',
                      controller: controller.salesPointWebsiteController,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Website is required';
                        }
                        return null;
                      },
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
                          controller.salesPointWebsiteController?.text = "";
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
                          Get.to(() => SalesPointLocationScreen());
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
