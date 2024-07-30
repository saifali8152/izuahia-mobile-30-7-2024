// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/booth_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20booth%20screens/add_booth_name_screen.dart';

class BoothSelectSalesScreen extends StatefulWidget {
  const BoothSelectSalesScreen({super.key});

  @override
  State<BoothSelectSalesScreen> createState() => _BoothSelectSalesScreenState();
}

class _BoothSelectSalesScreenState extends State<BoothSelectSalesScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: SalesPointBoothController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async => await Get.to(() => CustomBottomScreen()),
          child: Scaffold(
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
                  "Select Sales Point",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Sales Point',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                      ),
                    ),
                    6.verticalSpace,
                    Obx(() {
                      if (controller.salesPointList.isEmpty) {
                        return Container(
                          height: 45,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xff9392AD,
                                ).withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            controller.isLoading.value
                                ? 'Loading...'
                                : 'No hubs available',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xff9392AD,
                              ).withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          menuMaxHeight: height * .2,
                          value: controller
                                  .salesPointController!.text.isEmpty
                              ? controller.salesPointList[0].spId
                              : controller.salesPointController!.text,
                          dropdownColor: AppColors.grey3,
                          elevation: 0,
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          underline: Container(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items:
                              controller.salesPointList.map((salesPoint) {
                            return DropdownMenuItem<String>(
                              value: salesPoint.spId,
                              child: Text(
                                salesPoint.spName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey2,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.salesPointController!.text =
                                newValue!;
                            controller.update();
                          },
                        ),
                      );
                    }),
                  ],
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
                        Get.to(() => AddBoothNameScreen());
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
          ),
        );
      },
    );
  }
}
