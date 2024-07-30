// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/service_hub_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/components/text-fields/text_form_field_business.dart';
import 'package:izuahia/screens/SERVICEHUB/addServicesNewScreens/add%20service%20hub%20screens/service_hub_add_email_screen.dart';

class ServiceHubPhoneNumberScreen extends StatelessWidget {
  const ServiceHubPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? hubPhoneNumberFormKey = GlobalKey<FormState>();
    return GetBuilder(
      init: ServiceHubController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: hubPhoneNumberFormKey,
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
                    "Phone Number",
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
                    "Please enter your office Contact number to help customers reach you easily",
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
                        title: 'Phone',
                        hintText: 'Enter Phone',
                        keyboardType: TextInputType.phone,
                        controller: controller.phoneController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'phone is required';
                          } else if (!value.isPhoneNumber) {
                            return 'please enter a valid phone number';
                          }
                          return null;
                        }),
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
                          if (hubPhoneNumberFormKey.currentState!.validate()) {
                            Get.to(() => ServiceHubEmailScreen());
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
