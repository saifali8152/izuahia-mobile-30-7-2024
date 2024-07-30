import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget threadNegotationCommentPopUp(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .80,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height * .22,
                          width: width,
                          decoration: BoxDecoration(
                              color: AppColors.orangeLight,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(image: AssetImage(Assets.mobile), fit: BoxFit.cover)),
                        ),
                        Positioned(
                            top: 20,
                            right: 20,
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: customButtons(
                                    onTap: () {
                                      Get.back();
                                    },
                                    assets: Assets.cancel))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'iPhone 15 Pro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Negotiation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      thickness: 1,
                      color: Color(0xff8D8E99),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Actual Price: 2300',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.grey2),
                        ),
                        Text(
                          'Negotiated Amount: 2100',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.grey2),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    commentWidget(),
                  ],
                ),
              ),
            ),
          ),
          commentField()
        ],
      ),
    ),
  );
}

Widget commentField() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    child: Column(
      children: [
        const Divider(),
        10.verticalSpace,
        Stack(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                filled: true,
                hintText: 'Write Negotiation Text Here',
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Color(0xff8D8E99), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Color(0xff8D8E99), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Color(0xff8D8E99), width: 1),
                ),
                hintStyle: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: Color(0xff8D8E99),
                  fontSize: 10,
                ),
              ),
            ),
            Positioned(
              right: 30,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.attach_file_outlined,
                    color: AppColors.blackColor,
                  )),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.blackColor,
                  )),
            )
          ],
        ),
      ],
    ),
  );
}

Widget commentWidget() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.2), offset: const Offset(0, 2), spreadRadius: 2, blurRadius: 4)
                ],
                image: const DecorationImage(image: AssetImage(Assets.profileImage), fit: BoxFit.cover)),
          ),
          10.horizontalSpace,
          Expanded(
            child: Container(
              height: Get.height * .05,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.grey3),
              child: const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      10.verticalSpace,
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: Get.height * .05,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.grey3),
              child: const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          10.horizontalSpace,
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.2), offset: const Offset(0, 2), spreadRadius: 2, blurRadius: 4)
                ],
                image: const DecorationImage(image: AssetImage(Assets.logo), fit: BoxFit.cover)),
          ),
        ],
      ),
    ],
  );
}
