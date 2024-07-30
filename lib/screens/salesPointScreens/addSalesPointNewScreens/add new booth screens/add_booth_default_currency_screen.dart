// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/booth_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/currency_drop_down.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20booth%20screens/add_booth_image_screen.dart';

class BoothDefaultCurrencyScreen extends StatefulWidget {
  const BoothDefaultCurrencyScreen({super.key});

  @override
  State<BoothDefaultCurrencyScreen> createState() =>
      _BoothDefaultCurrencyScreenState();
}

class _BoothDefaultCurrencyScreenState
    extends State<BoothDefaultCurrencyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SalesPointBoothController(),
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
                "Select Booth Currency",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: CurrencyDropdownButton(
                  color: AppColors.yellow,
                  fontColor: AppColors.blackColor,
                  hintText: "Select Default Currency",
                  items: const [
                    'USD',
                    'EUR',
                    'JPY',
                    'GBP',
                    'AUD',
                    'CAD',
                    'CHF',
                    'CNY',
                    'SEK',
                    'NZD'
                  ],
                  controller: controller.currencyController!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Currency is required";
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
                      controller.currencyController!.text = "";
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "        ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AddBoothUploadImageScreen());
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
