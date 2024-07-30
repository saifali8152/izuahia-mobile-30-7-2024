import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/invoices_controller.dart';
import 'package:izuahia/models/invoices_model.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/ProfileSecDialogs/InvoicesDialogs/invoicesDialogs.dart';

class ProfileInvoices extends StatefulWidget {
  const ProfileInvoices({super.key});

  @override
  State<ProfileInvoices> createState() => _ProfileInvoicesState();
}

class _ProfileInvoicesState extends State<ProfileInvoices> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 10.h),
        child: GetBuilder(
            init: InvoicesController(),
            builder: (invoicesController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.grey2.withOpacity(0.4),
                                offset: const Offset(0, 3),
                                spreadRadius: 0,
                                blurRadius: 3)
                          ],
                          color: AppColors.yellow),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor,
                        size: 18,
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'INVOICE',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Obx(() {
                          return datePickerWidget(
                              title: invoicesController.fromDate.value.isEmpty ? "From Date" : invoicesController.fromDate.value,
                              onTap: () {
                                invoicesController.setFromDate(context);
                              });
                        }),
                      ),
                      7.horizontalSpace,
                      Expanded(
                        child: Obx(() {
                          return datePickerWidget(
                              title: invoicesController.toDate.value.isEmpty ? "To Date" : invoicesController.toDate.value,
                              onTap: () {
                                invoicesController.setToDate(context);
                              });
                        }),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  textField(
                    onChanged: invoicesController.setSearchString,
                  ),
                  12.verticalSpace,
                  Expanded(
                    child: SizedBox(
                      height: height,
                      child: invoicesController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.yellow,
                              ),
                            )
                          : invoicesController.filteredInvoicesList.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No Invoices Found',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: invoicesController.filteredInvoicesList.length,
                                  itemBuilder: (context, index) {
                                    return invoiceItemWidget(
                                      invoicesModel: invoicesController.filteredInvoicesList[index],
                                    );
                                  }),
                    ),
                  )
                ],
              );
            }),
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
        height: Get.height * .030,
        width: Get.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: AppColors.whiteColor, borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColors.yellow)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 10, fontFamily: 'Inter', color: AppColors.darkGrey, fontWeight: FontWeight.w500)),
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

  Widget textField({required void Function(String) onChanged}) {
    return SizedBox(
      height: Get.height * .030,
      width: Get.width,
      child: TextFormField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.darkGrey),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColors.yellow, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColors.yellow, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColors.yellow, width: 1),
          ),
        ),
      ),
    );
  }

  Widget invoiceItemWidget({required InvoicesModel invoicesModel}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return profileInvoiceDetailsPopUp(context);
            });
      },
      child: Container(
        // height: Get.height * .12,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child:
            //  Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            // Container(
            //   height: Get.height * .09,
            //   width: Get.width * .30,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       image: DecorationImage(
            //           image: AssetImage(image), fit: BoxFit.cover),
            //       color: AppColors.yellow2),
            // ),
            // 10.horizontalSpace,
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice No : ${invoicesModel.invoiceNo}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('28-02-2024',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Inter',
                        color: Color(0xff9B9B9B),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            2.verticalSpace,
            // const Text('Invoice Name',
            //     style: TextStyle(
            //         fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w400)),
            // 4.verticalSpace,
            Row(
              children: [
                Text(
                  'Invoice Amount: ${invoicesModel.invoiceTotalPrice}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                5.horizontalSpace,
                const Text(
                  '4112',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        //   ],
        // ),
        // GestureDetector(
        //   onTap: () {},
        //   child: Container(
        //     height: 24,
        //     width: 24,
        //     decoration: BoxDecoration(
        //         color: AppColors.yellow,
        //         borderRadius: BorderRadius.circular(3)),
        //     child: const Icon(
        //       Icons.edit,
        //       color: AppColors.blackColor,
        //       size: 20,
        //     ),
        //   ),
        // ),
        // Checkbox(value: false, onChanged: (value) {})
        //   ],
        // ),
      ),
    );
  }
}
