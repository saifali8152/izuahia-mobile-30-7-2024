// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/sales_point_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/components/text-fields/text_form_field_business.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20sales%20point%20screens/sales_point_phone_number_screen.dart';

class SalesPointNameScreen extends StatelessWidget {
  const SalesPointNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? salesPointNameFormKey = GlobalKey<FormState>();
    return GetBuilder(
      init: SalesPointController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: salesPointNameFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Assets.appLogo),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Sales Point Name",
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
                      hintText: 'Enter Sales Point Name',
                      controller: controller.salesPointNameController,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Sales Point name is required';
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
                          controller.salesPointNameController!.text = "";
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
                          if (salesPointNameFormKey.currentState!
                              .validate()) {
                            Get.to(() => SalePointPhoneNumberScreen());
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
