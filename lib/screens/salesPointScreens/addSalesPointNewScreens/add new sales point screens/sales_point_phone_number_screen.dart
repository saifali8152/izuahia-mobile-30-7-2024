// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/sales_point_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/components/text-fields/text_form_field_business.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20sales%20point%20screens/sales_point_add_email_screen.dart';

class SalePointPhoneNumberScreen extends StatelessWidget {
  const SalePointPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? salesPointPhoneNumberFormKey = GlobalKey<FormState>();
    return GetBuilder(
      init: SalesPointController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Form(
              key: salesPointPhoneNumberFormKey,
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
                      controller: controller.salesPointPhoneNumberController,
                      keyboardType: TextInputType.phone,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number is required';
                        } else if (!value.isPhoneNumber) {
                          return 'Please Enter a valid phone number';
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
                          controller.salesPointPhoneNumberController!.text = "";
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
                          Get.to(() => SalesPointEmailScreen());
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
