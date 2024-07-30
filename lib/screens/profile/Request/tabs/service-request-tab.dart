import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/profile_requests_controller.dart';
import 'package:izuahia/res/dialogs/SERVICE-HUB-DIALOGS/add-new-service-request-dialogue.dart';
import 'package:izuahia/res/dialogs/SERVICE-HUB-DIALOGS/view-service-request.dart';

class ServiceRequestTabScreen extends StatefulWidget {
  const ServiceRequestTabScreen({super.key});

  @override
  State<ServiceRequestTabScreen> createState() => _ServiceRequestTabScreenState();
}

class _ServiceRequestTabScreenState extends State<ServiceRequestTabScreen> {
  final ProfileRequestsController requestsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .7),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: AppColors.orangeLight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                      color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4)
                ],
                border: const Border(left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('SERVICE REQUEST',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() {
                  return datePickerWidget(
                      title: requestsController.serviceFromDate.value.isEmpty
                          ? 'From Date'
                          : requestsController.serviceFromDate.value,
                      onTap: () {
                        requestsController.setServiceFromDate(context);
                      });
                }),
              ),
              8.horizontalSpace,
              Expanded(
                child: Obx(() {
                  return datePickerWidget(
                      title: requestsController.serviceToDate.value.isEmpty ? 'To Date' : requestsController.serviceToDate.value,
                      onTap: () {
                        requestsController.setServiceToDate(context);
                      });
                }),
              ),
            ],
          ),
          12.verticalSpace,
          textField(),
          12.verticalSpace,
          SizedBox(
            height: height * .45,
            child: Obx(() {
              return requestsController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : requestsController.filteredServiceRequestsList.isEmpty
                      ? const Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: requestsController.filteredServiceRequestsList.length,
                          itemBuilder: (context, index) {
                            final request = requestsController.filteredServiceRequestsList[index];
                            return requestItemWidget(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => viewServiceRequestPopUp(
                                    context: context,
                                    serviceRequestItem: request,
                                  ),
                                );
                              },
                              image: request.serviceImage,
                              context: context,
                              title: requestsController.serviceRequestsList[index].serviceName,
                              date: request.createdAt,
                              budget: request.serviceBudget,
                              location: request.fullAddress,
                            );
                          });
            }),
          ),
          10.verticalSpace,
          detailButton(onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return addServiceRequestPopUp(context);
                });
          })
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

  Widget textField() {
    return SizedBox(
      height: Get.height * .035,
      width: Get.width,
      child: TextFormField(
        onChanged: (value) {
          requestsController.setServiceSearchString(value);
        },
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

  Widget requestItemWidget(
      {required String image,
      required VoidCallback onTap,
      required String title,
      required BuildContext context,
      required String date,
      required String budget,
      required String location}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * .12,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * .10,
                  width: Get.width * .26,
                  margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(date,
                          style: const TextStyle(
                              fontSize: 8, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w500)),
                      3.verticalSpace,
                      Text(title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)),
                      3.verticalSpace,
                      Row(
                        children: [
                          const Text('Location: ',
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Inter', color: Color(0xff757575), fontWeight: FontWeight.w600)),
                          3.horizontalSpace,
                          Text(location,
                              style: const TextStyle(
                                  fontSize: 10, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      3.verticalSpace,
                      Row(
                        children: [
                          const Text('Budget: ',
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Inter', color: Color(0xff757575), fontWeight: FontWeight.w600)),
                          3.horizontalSpace,
                          Text(budget,
                              style: const TextStyle(
                                  fontSize: 10, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align(
            //       alignment: Alignment.bottomRight,
            //       child: customButton(onTap: () {}, title: 'Delete')),
            // )
          ],
        ),
      ),
    );
  }

  Widget customButton({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        // width: Get.width * .15,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
        child: Text(title,
            style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget detailButton({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .04,
        width: Get.width * .2,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(20)),
        child: const Text('Add New',
            style: TextStyle(fontSize: 11, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
