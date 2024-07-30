// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SERVICEHUB/addServicesNewScreens/add%20service%20hub%20screens/service_hub_name_screen.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20sales%20point%20screens/sales_point_name_screen.dart';

class SelectBusinessScreen extends StatefulWidget {
  const SelectBusinessScreen({super.key});

  @override
  State<SelectBusinessScreen> createState() => _SelectBusinessScreenState();
}

class _SelectBusinessScreenState extends State<SelectBusinessScreen> {
  String optionA = "A";

  String optionB = "B";

  String selectedOption = "A";

  @override
  Widget build(BuildContext context) {
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
            "Start, Manage, and Grow Your Business With Ease on Izuahia",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Expand your business services on Izuahia and\nsimplfy your operations. Easily handle bookings,\nschedule appointments, and engage with your\nclients. Our platform offers real-time scheduling,\nsecure payments and effective communication\ntools, all tailored to help you succeed. Grow your\nclient base and enhance your service offerings\neffortlessly with Izuahia",
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Choose Your Business Type",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = optionA;
              });
            },
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow, width: 3),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Selling items",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Radio(
                      value: optionA,
                      groupValue: selectedOption,
                      activeColor: AppColors.yellow,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => AppColors.yellow),
                      onChanged: (value) {
                        setState(() {
                          selectedOption = optionA;
                        });
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = optionB;
              });
            },
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow, width: 3),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Offering Services",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Radio(
                      value: optionB,
                      groupValue: selectedOption,
                      activeColor: AppColors.yellow,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => AppColors.yellow),
                      onChanged: (value) {
                        setState(() {
                          selectedOption = optionB;
                        });
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              if (selectedOption == optionA) {
                Get.to(() => SalesPointNameScreen());
              } else if (selectedOption == optionB) {
                Get.to(() => ServiceHubNameScreen());
              }
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(right: 15),
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    "Add your business",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
