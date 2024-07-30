import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget serviceHubAddReceiptPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  final DatePickerController controller = Get.put(DatePickerController());
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Receipt',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel)),
                ],
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Receipt Title',
                hintText: 'Enter Receipt Title',
              ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Obx(() {
                    String formattedDate = DateFormat('yyyy-MM-dd')
                        .format(controller.selectedDate.value);
                    return datePickerWidget(
                        title: formattedDate,
                        onTap: () {
                          controller.selectDate(context);
                        });
                  }),
                ],
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Quote No',
                hintText: 'Enter Quote No',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Amount Received',
                hintText: 'Enter Amount Received',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                  title: 'Note', hintText: 'Write Note', maxLines: 5),
              10.verticalSpace,
              receiptDetailsWidget(onTap: () {}),
              30.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: width * .28,
                      height: height * .05,
                      child: RoundButton(label: 'Submit', onPressed: () {}))),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget receiptDetailsWidget({
  required VoidCallback onTap,
}) {
  return Container(
    constraints: const BoxConstraints(maxHeight: double.infinity),
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 13.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(13.w, 4.h, 8.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textField(),
                        const Text(
                          'Customer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Inter',
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    17.horizontalSpace,
                    const Text('Customer Details',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const Divider(
                  color: AppColors.blackColor,
                  thickness: 0.5,
                  indent: 100,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * .10,
                      width: Get.width * .19,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          image: const DecorationImage(
                              image: AssetImage(Assets.profileImage),
                              fit: BoxFit.cover),
                          color: AppColors.yellow2),
                    ),
                    20.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Name:',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.w600)),
                            8.horizontalSpace,
                            const Text('Inayat Ali',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            const Text('Email:',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.w600)),
                            8.horizontalSpace,
                            const Text('inayatalibohio@gmail.com',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // 4.verticalSpace,
                const Divider(
                  color: Color(0xff8D8E99),
                  thickness: 0.5,
                  indent: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget datePickerWidget({
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .047,
      width: Get.width,
      padding: const EdgeInsets.only(left: 10, right: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: AppColors.grey2,
              fontSize: 10,
            ),
          ),
          5.horizontalSpace,
          const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.darkGrey,
            size: 20,
          )
        ],
      ),
    ),
  );
}

Widget textField() {
  return SizedBox(
    height: Get.height * .02,
    width: Get.width * .2,
    child: TextFormField(
      style: const TextStyle(
          fontSize: 6,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: AppColors.blackColor),
      decoration: InputDecoration(
        hintText: 'Search',
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.transparent,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.darkGrey),
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.blackColor,
          size: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.r),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.r),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.r),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    ),
  );
}
