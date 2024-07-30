
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/homepage/home_create_quote_popup.dart';
import 'package:izuahia/res/components/homepage/requests/buttons.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/utils/helper_functions.dart';

  Widget requestViewPopUp({
    String? quantity,
    required BuildContext context,
    required String name,
    required String description,
   String? imagePath,
    required String requestType,
  }) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    CreateRequestRepo repo = CreateRequestRepo();
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        height: height * .65,
        width: width,
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .27,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: 
                      imagePath == null ? const DecorationImage(image: AssetImage(Assets.noImage), fit: BoxFit.cover) : 
                      DecorationImage(image:
                       NetworkImage(imagePath), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      top: 20,
                      right: 20,
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: button(
                              onTap: () {
                                Get.back();
                              },
                              assets: Assets.cancel)))
                ],
              ),
              10.verticalSpace,
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(requestType == 'inventory')
                    Text(
                      'Quantity: $quantity',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: Color(0xff64748B)),
                    ),
                    10.verticalSpace,
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Color(0xff64748B),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: SizedBox(
                            width: width * .30,
                            height: height * .04,
                            child: RoundButton(
                                label: 'Add Quote',
                                onPressed: () async {
                                  if (!HelperFunctions.isLoggedIn) {
                                    showDialog(
                                      context: context,
                                      builder: loginPopUp,
                                    );
                                  } else if (requestType == 'inventory') {
                                    HelperFunctions.showLoadingDialogue(context);
                                    final List data = await repo.selectSalesPoint(fromHome: true);
                                    if (data.isEmpty) {
                                      HelperFunctions.showSnackBar(
                                        title: 'No Sales Points Added',
                                        msg: "Please add a sales point first",
                                      );
                                    } else {
                                      if (context.mounted) {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return homeCreateQuotePopUp(context);
                                            });
                                      }
                                    }
                                  } else {
                                    final List data = await repo.selectHub(fromHome: true);
                                    if (data.isEmpty) {
                                      HelperFunctions.showSnackBar(
                                        title: 'No Hubs Added',
                                        msg: "Please add a hub first",
                                      );
                                    } else {
                                      if (context.mounted) {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return homeCreateQuotePopUp(context);
                                            });
                                      }
                                    }
                                  }
                                })),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }