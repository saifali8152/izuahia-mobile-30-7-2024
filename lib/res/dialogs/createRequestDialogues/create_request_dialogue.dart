import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/SERVICE-HUB-DIALOGS/add-new-service-request-dialogue.dart';
import 'package:izuahia/res/dialogs/inventory/add-inventory-request.dart';

Widget createRequestPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        height: height * .75,
        width: width,
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Request',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 16, color: const Color(0xff002223), fontWeight: FontWeight.w700),
                  ),
                  40.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Column(
                      children: [
                        customButton(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return addServiceRequestPopUp(context);
                                  });
                            },
                            buttonName: 'Service Request'),
                        20.verticalSpace,
                        customButton(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return addInventoryRequest(context);
                                  });
                            },
                            buttonName: 'Inventory Request'),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              child: SizedBox(
                height: 30,
                width: 30,
                child: customButtons(
                  onTap: () {
                    Get.back();
                  },
                  assets: Assets.cancel,
                ),
              ),
            )
          ],
        ),
      ));
}
