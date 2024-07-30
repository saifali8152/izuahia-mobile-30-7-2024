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
import 'package:izuahia/res/dialogs/salesPointDialogs/receiptDialogs/add-receipt-dialog.dart';

// Add Ledger PopUp
Widget addLedgerPopUp(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: AddLedgerDialog());
}

class AddLedgerDialog extends StatefulWidget {
  const AddLedgerDialog({super.key});

  @override
  State<AddLedgerDialog> createState() => _AddLedgerDialogState();
}

class _AddLedgerDialogState extends State<AddLedgerDialog> {
  String dropdownvalue = 'Select';
  var items = [
    'Select',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  String dileveryTermsValue = 'Select From List';
  var dileveryTermsItems = [
    'Select From List',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .77,
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
                    'Add Ledger',
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
                title: 'Ledger Title',
                hintText: 'Enter Ledget Title',
              ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ledger Category',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColors.grey3,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey,
                            color: const Color(
                              0xff9392AD,
                            ).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: DropdownButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      menuMaxHeight: height * .2,
                      value: dropdownvalue,
                      dropdownColor: AppColors.grey3,
                      elevation: 0,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
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
              // 8.verticalSpace,
              // textFormFieldWidget(
              //   title: 'Cash Ledger Type',
              //   hintText: 'Write Specifications',
              // ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cash Ledger Type',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColors.grey3,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey,
                            color: const Color(
                              0xff9392AD,
                            ).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: DropdownButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      menuMaxHeight: height * .2,
                      value: dileveryTermsValue,
                      dropdownColor: AppColors.grey3,
                      elevation: 0,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dileveryTermsItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dileveryTermsValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Ledger Amount',
                hintText: 'Enter Amount Received',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                  title: 'Note', hintText: 'Write Note', maxLines: 5),
              35.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: width * .24,
                      height: height * .045,
                      child: RoundButton(label: 'Add', onPressed: () {}))),
            ],
          ),
        ),
      ),
    );
  }
}

// Edit Ledger PopUp

Widget editLedgerPopUp(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: EditLedgerDialog());
}

class EditLedgerDialog extends StatefulWidget {
  const EditLedgerDialog({super.key});

  @override
  _EditLedgerDialogState createState() => _EditLedgerDialogState();
}

class _EditLedgerDialogState extends State<EditLedgerDialog> {
  String dropdownvalue = 'Select';
  var items = [
    'Select',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  String dileveryTermsValue = 'Select From List';
  var dileveryTermsItems = [
    'Select From List',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .77,
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
                    'Edit Ledger',
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
                title: 'Ledger Title',
                hintText: 'Enter Ledget Title',
              ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ledger Category',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColors.grey3,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey,
                            color: const Color(
                              0xff9392AD,
                            ).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: DropdownButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      menuMaxHeight: height * .2,
                      value: dropdownvalue,
                      dropdownColor: AppColors.grey3,
                      elevation: 0,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
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
              // 8.verticalSpace,
              // textFormFieldWidget(
              //   title: 'Cash Ledger Type',
              //   hintText: 'Write Specifications',
              // ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cash Ledger Type',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColors.grey3,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey,
                            color: const Color(
                              0xff9392AD,
                            ).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: DropdownButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      menuMaxHeight: height * .2,
                      value: dileveryTermsValue,
                      dropdownColor: AppColors.grey3,
                      elevation: 0,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dileveryTermsItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dileveryTermsValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Ledger Amount',
                hintText: 'Enter Amount Received',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                  title: 'Note', hintText: 'Write Note', maxLines: 5),
              35.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: width * .24,
                      height: height * .045,
                      child: RoundButton(label: 'Add', onPressed: () {}))),
            ],
          ),
        ),
      ),
    );
  }
}
