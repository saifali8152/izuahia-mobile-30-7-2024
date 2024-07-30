// Service Hub Pop up
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/inventory/add-inventory.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/add-new-sales-point-dialog.dart';

//***** ADD NEW INVENTORY POINT *****/
Widget addNewInventoryPopUp(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: AddInventory());
}

Widget addMultiplePopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        height: height * .75,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel)),
                ),
                60.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Multiple Inventory',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff002223),
                          fontWeight: FontWeight.w700),

                      //  TextStyle(
                      //     fontSize: 16,
                      //     fontFamily: 'Montserrat',
                      //     color: AppColors.blackColor,
                      //     fontWeight: FontWeight.w700),
                    ),
                    20.verticalSpace,
                    const Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor),
                    ),
                    4.verticalSpace,
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: height * .10,
                          width: width * .23,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.grey3),
                          child: SvgPicture.asset(
                            Assets.uploadFile,
                            height: 40,
                          )),
                    ),
                    4.verticalSpace,
                    Text('File format: .csv or xlsx',
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xff757575))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
}

Widget serviceProviderPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        height: height * .75,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel)),
                ),
                60.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Service Providers\n Near You',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff002223),
                          fontWeight: FontWeight.w700),
                    ),
                    40.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Column(
                        children: [
                          button(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return addNewHubPopUp(context);
                                    });
                              },
                              buttonName: 'Add New Hub'),
                          20.verticalSpace,
                          button(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return addServicePopUp(context);
                                    });
                              },
                              buttonName: 'Add New Service'),
                          6.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
}

Widget addSalesAndBoothPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        height: height * .75,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel)),
                ),
                60.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Service Providers\n Near You',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff002223),
                          fontWeight: FontWeight.w700),

                      //  TextStyle(
                      //     fontSize: 16,
                      //     fontFamily: 'Montserrat',
                      //     color: AppColors.blackColor,
                      //     fontWeight: FontWeight.w700),
                    ),
                    40.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Column(
                        children: [
                          button(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return addSalesPointPopUp(context);
                                    });
                              },
                              buttonName: 'Add New Sales Point'),
                          20.verticalSpace,
                          button(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return addNewBoothPopUp(context);
                                    });
                              },
                              buttonName: 'Add New Booth'),
                          20.verticalSpace,
                          button(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return addNewInventoryPopUp(context);
                                    });
                              },
                              buttonName: 'Add New Inventory'),
                          20.verticalSpace,
                          // button(
                          //     onTap: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (_) {
                          //             return addMultiplePopUp(context);
                          //           });
                          //     },
                          //     buttonName: 'Add Multiple Inventory'),
                          // 6.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
}

Widget button({required VoidCallback onTap, required String buttonName}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .032,
      width: Get.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.yellow)),
      child: Text(
        buttonName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
          fontSize: 12,
        ),
      ),
    ),
  );
}
