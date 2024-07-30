import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/bids_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget profileBidPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * .13,
                    width: width * .3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                              Assets.workwave,
                            ),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel))
                ],
              ),
            ),
            12.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Workwave & Co',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                  8.verticalSpace,
                  const Text(
                    "Apply in Bidding",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                  ),
                  15.verticalSpace,
                  const Divider(
                    color: AppColors.grey2,
                    thickness: 0.6,
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      const Text(
                        "Actual Price:",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.grey2),
                      ),
                      20.horizontalSpace,
                      const Text(
                        "2300",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      const Text(
                        "Your Bid:",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.grey2),
                      ),
                      20.horizontalSpace,
                      Expanded(child: textField())
                    ],
                  ),
                  12.verticalSpace,
                  const Divider(
                    color: AppColors.grey2,
                    thickness: 0.6,
                  ),
                  25.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: width * .30, height: height * .042, child: RoundButton(label: 'Submit Bid', onPressed: () {})),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget textField() {
  return SizedBox(
    height: Get.height * .035,
    width: Get.width,
    child: TextFormField(
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.blackColor),
      decoration: InputDecoration(
        hintText: 'Enter Your Bid Here',
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: AppColors.whiteColor,
        hintStyle: const TextStyle(fontSize: 10, color: Color(0xffC4C4C4)),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
      ),
    ),
  );
}

// View Bid Dialog

Widget profileViewBidPopUp({required BuildContext context, required BidsModel bidModel}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bid Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel))
                ],
              ),
            ),
            4.verticalSpace,
            const Divider(
              color: AppColors.grey2,
              thickness: 0.6,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bid Date',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontFamily: 'Montserrat', color: Color(0xff666666), fontWeight: FontWeight.w600),
                      ),
                      Text(
                        bidModel.createdAt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Montserrat', color: Color(0xff666666), fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: height * .12,
                      width: width * .32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                bidModel.inventoryImages[0],
                              ),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  4.verticalSpace,
                  const Divider(
                    color: AppColors.grey2,
                    thickness: 0.6,
                  ),
                  8.verticalSpace,
                  const Text(
                    "Bid Summary",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Actual Price:",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                      20.horizontalSpace,
                      Text(
                        bidModel.actualPrice,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: Color(0xff666666),
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Bid Price:",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                      20.horizontalSpace,
                      Text(
                        bidModel.bidPrice,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: Color(0xff666666),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  const Divider(
                    color: AppColors.grey2,
                    thickness: 0.6,
                  ),
                  8.verticalSpace,
                  const Text(
                    "Customer Details",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(Assets.profileImage),
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${SharedPrefs().getString("first_name")} ${SharedPrefs().getString("last_name")}',
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.blackColor,
                            ),
                          ),
                          3.verticalSpace,
                          Text(
                            '${SharedPrefs().getString('email')}',
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Color(0xff666666),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  25.verticalSpace,
                  Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          bidModel.bidStatus,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff08E761),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
