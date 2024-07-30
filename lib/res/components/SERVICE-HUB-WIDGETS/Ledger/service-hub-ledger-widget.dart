import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/ledgerDialogs/add-ledger-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/ledgerDialogs/ledger-details.dart';

class ServiceHubLedgerWidget extends StatefulWidget {
  const ServiceHubLedgerWidget({super.key});

  @override
  State<ServiceHubLedgerWidget> createState() => _ServiceHubLedgerWidgetState();
}

class _ServiceHubLedgerWidgetState extends State<ServiceHubLedgerWidget> {
  final DatePickerController controller = Get.put(DatePickerController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .8,
      // constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13), color: AppColors.yellow2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    Assets.logo,
                    height: 45,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                20.horizontalSpace,
                const Text(
                  'WORKWAVE AND CO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            12.verticalSpace,
            Container(
              height: height * .048,
              width: width,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.25),
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                        blurRadius: 4)
                  ],
                  border: const Border(
                      left: BorderSide(color: AppColors.blackColor, width: 8))),
              child: const Text('CONSULTING',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700)),
            ),
            12.verticalSpace,
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.blackColor,
                    endIndent: 20,
                    height: 1.5,
                  ),
                ),
                Text('LEDGER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600)),
                Expanded(
                  child: Divider(
                    color: AppColors.blackColor,
                    indent: 20,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    String formattedDate = DateFormat('yyyy-MM-dd')
                        .format(controller.selectedDate.value);
                    return datePickerWidget(
                        title: formattedDate,
                        onTap: () {
                          controller.selectDate(context);
                        });
                  }),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Obx(() {
                    String formattedDate = DateFormat('yyyy-MM-dd')
                        .format(controller.selectedDate.value);
                    return datePickerWidget(
                        title: formattedDate,
                        onTap: () {
                          controller.selectDate(context);
                        });
                  }),
                ),
                8.horizontalSpace,
                Expanded(child: textField()),
              ],
            ),
            12.verticalSpace,
            addLedgerItemWidget(
              context: context,
              onTap: () {},
            ),
            5.verticalSpace,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Ledger',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700)),
            ),
            12.verticalSpace,
            SizedBox(
              height: height,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return recentLedgerItemWidget(onTap: () {});
                  }),
            )
          ],
        ),
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
        height: Get.height * .033,
        width: Get.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500)),
            5.horizontalSpace,
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.darkGrey,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .035,
      width: Get.width,
      child: TextFormField(
        onTap: () {},
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.darkGrey),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
      ),
    );
  }

  Widget recentLedgerItemWidget({required VoidCallback onTap}) {
    return Container(
      // height: Get.height * .17,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        // boxShadow: [
        //   BoxShadow(
        //       color: AppColors.blackColor.withOpacity(0.25),
        //       offset: const Offset(0, 4),
        //       spreadRadius: 0,
        //       blurRadius: 4),
        // ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Purchase of Telecoms Cable',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              Text('28-02-2024',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      color: Color(0xff9B9B9B),
                      fontWeight: FontWeight.w600)),
            ],
          ),
          2.verticalSpace,
          const Divider(
            endIndent: 120,
          ),
          2.verticalSpace,
          Row(
            children: [
              const Text('Posted by::',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' Inayat Ali',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          4.verticalSpace,
          Row(
            children: [
              const Text('Ledger Type:',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(' Cash Spent',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          5.verticalSpace,
          Row(
            children: [
              const Text('Ledger Amount:',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              3.horizontalSpace,
              const Text(" \$656700",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          4.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Note:',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w600)),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonWidget(title: 'Delete', onTap: () {}),
                        5.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return ledgerDetailsPopUp(context);
                                });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(3)),
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.blackColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          8.verticalSpace,
        ],
      ),
    );
  }
}

Widget addLedgerItemWidget(
    {required VoidCallback onTap, required BuildContext context}) {
  return Container(
    // height: Get.height * .17,
    constraints: const BoxConstraints(maxHeight: double.infinity),
    width: Get.width,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      // boxShadow: [
      //   BoxShadow(
      //       color: AppColors.blackColor.withOpacity(0.25),
      //       offset: const Offset(0, 4),
      //       spreadRadius: 0,
      //       blurRadius: 4),
      // ],
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Available Balance:',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600)),
            3.horizontalSpace,
            const Text(" \$656700",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        2.verticalSpace,
        const Divider(
          endIndent: 120,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cash Spent',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600)),
                  Text("43000",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cash  Received',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600)),
                  Text("43000",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buttonWidget(
                    title: 'Add Ledger',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return addLedgerPopUp(context);
                          });
                    }),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buttonWidget({required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .03,
      width: Get.width * .15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
      child: Text(title,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: AppColors.yellow,
              fontWeight: FontWeight.w500)),
    ),
  );
}
