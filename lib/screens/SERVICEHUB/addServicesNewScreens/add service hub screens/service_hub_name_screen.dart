// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/service_hub_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/components/text-fields/text_form_field_business.dart';
import 'package:izuahia/screens/SERVICEHUB/addServicesNewScreens/add%20service%20hub%20screens/service_hub_phone_number_screen.dart';

class ServiceHubNameScreen extends StatelessWidget {
  const ServiceHubNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? hubNameFormKey = GlobalKey<FormState>();
    return GetBuilder(
      init: ServiceHubController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: hubNameFormKey,
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
                    "Service Hub Name",
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
                    "Expand your business services on Izuahia and\nsimplfy your operations. Easily handle bookings,\nschedule appointments, and engage with your\nclients. Our platform offers real-time scheduling,\nsecure payments and effective communication\ntools, all tailored to help you succeed. Grow your\nclient base and enhance your service offerings\neffortlessly with Izuahia",
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
                      title: 'Service Hub Name',
                      hintText: 'Enter Service Hub Name',
                      controller: controller.hubNameController,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Hub name is required';
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
                          if (hubNameFormKey.currentState!.validate()) {
                            Get.to(() => ServiceHubPhoneNumberScreen());
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
