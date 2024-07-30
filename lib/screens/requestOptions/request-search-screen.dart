// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/home_requests_controller.dart';
import 'package:izuahia/models/hub_model.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/models/sales_point_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/request_comment_popup.dart';
import 'package:izuahia/res/components/homepage/requests/request_view_popup.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/utils/helper_functions.dart';

class RequestSearchScreen extends StatefulWidget {
  const RequestSearchScreen({super.key});

  @override
  State<RequestSearchScreen> createState() => _RequestSearchScreenState();
}

class _RequestSearchScreenState extends State<RequestSearchScreen> {
  @override
  Widget build(BuildContext context) {
    CreateRequestRepo repo = CreateRequestRepo();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GetBuilder(
              init: HomeRequestsController(),
              builder: (requestsController) {
                return Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.yellow),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.blackColor,
                              size: 18,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.blackColor,
                            endIndent: 10,
                            height: 1,
                            indent: 10,
                          ),
                        ),
                        const Text('REQUESTS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 2,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600)),
                        const Expanded(
                          child: Divider(
                            color: AppColors.blackColor,
                            indent: 10,
                            height: 1,
                            endIndent: 10,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    SizedBox(
                      height: Get.height * .035,
                      width: Get.width,
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
                        onChanged: requestsController.setSearchString,
                        decoration: InputDecoration(
                          hintText: 'Search: Requests',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          fillColor: AppColors.whiteColor,
                          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.darkGrey),
                          filled: true,
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: Container(
                                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 12),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(3)),
                                child: Transform.scale(
                                  scale: 0.6,
                                  child: SvgPicture.asset(
                                    Assets.cancel,
                                    color: AppColors.blackColor,
                                    height: 20,
                                  ),
                                )),
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
                    ),
                    15.verticalSpace,
                    Expanded(
                      child: Obx(() {
                        return requestsController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : requestsController.allRequestsList.isEmpty
                                ? const Center(
                                    child: Text('No Data Found..'),
                                  )
                                : GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: 290, mainAxisSpacing: 10, crossAxisSpacing: 10),
                                    itemCount: requestsController.filteredRequestsList.length,
                                    itemBuilder: (context, index) {
                                      HomeRequestModel request = requestsController.filteredRequestsList[index];
                                      return Card(
                                        clipBehavior: Clip.hardEdge,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              request.requestType == 'inventory'
                                                  ? request.inventoryImages![0]
                                                  : request.serviceImage ?? "",
                                              height: MediaQuery.sizeOf(context).height * 0.14,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    request.requestType == 'inventory'
                                                        ? request.inventoryName ?? ""
                                                        : request.serviceName ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Montserrat',
                                                        color: AppColors.blackColor,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  2.verticalSpace,
                                                  Text(
                                                    request.requestType == 'inventory'
                                                        ? 'Quantity: ${request.quantity}'
                                                        : request.fullAddress ?? "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 13, fontFamily: 'Montserrat', color: Colors.black),
                                                  ),
                                                  2.verticalSpace,
                                                  Text(
                                                    request.description ?? "",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 11, fontFamily: 'Montserrat', color: Colors.black),
                                                  ),
                                                  10.verticalSpace,
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      customButtons(
                                                          onTap: () {
                                                            showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return requestViewPopUp(
                                                                    context: context,
                                                                    description: request.description!,
                                                                    name: request.requestType == 'inventory'
                                                                        ? request.inventoryName!
                                                                        : request.serviceName!,
                                                                    imagePath: request.requestType == 'inventory'
                                                                        ? request.inventoryImages![0]
                                                                        : request.serviceImage!,
                                                                    quantity: request.requestType == 'inventory'
                                                                        ? request.quantity
                                                                        : request.fullAddress,
                                                                    requestType: request.requestType,
                                                                  );
                                                                });
                                                          },
                                                          assets: Assets.eyeIcon),
                                                      customButtons(
                                                          onTap: () async {
                                                            if (!HelperFunctions.isLoggedIn) {
                                                              showDialog(
                                                                context: context,
                                                                builder: loginPopUp,
                                                              );
                                                            } else {
                                                              HelperFunctions.showLoadingDialogue(context);
                                                              if (request.requestType == 'inventory') {
                                                                final List<SalesPointDatum> data =
                                                                    await repo.selectSalesPoint(fromHome: true);
                                                                if (data.isEmpty) {
                                                                  HelperFunctions.showSnackBar(
                                                                    title: 'No Sales Points Added',
                                                                    msg: "Please add a sales point first",
                                                                  );
                                                                } else {
                                                                  if (context.mounted) {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder: (context) => requestCommentPopUp(
                                                                        context: context,
                                                                        title: request.inventoryName!,
                                                                        imagePath: request.inventoryImages![0],
                                                                        location: request.fullAddress!,
                                                                        irId: request.irId,
                                                                        srId: request.srId,
                                                                        requestType: request.requestType,
                                                                        dropDownList: data,
                                                                      ),
                                                                    );
                                                                  }
                                                                }
                                                              } else {
                                                                final List<HubDatum> data = await repo.selectHub(fromHome: true);
                                                                if (data.isEmpty) {
                                                                  HelperFunctions.showSnackBar(
                                                                    title: 'No Hubs Added',
                                                                    msg: "Please add a hub first",
                                                                  );
                                                                } else {
                                                                  if (context.mounted) {
                                                                    if (context.mounted) {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (context) => requestCommentPopUp(
                                                                          context: context,
                                                                          title: request.serviceName!,
                                                                          imagePath: request.serviceImage!,
                                                                          location: request.fullAddress!,
                                                                          irId: request.irId,
                                                                          srId: request.srId,
                                                                          requestType: request.requestType,
                                                                          dropDownList: data,
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          },
                                                          assets: Assets.msgIcon),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                      }),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

Widget customButtons({
  required VoidCallback onTap,
  required String assets,
}) {
  return Container(
    height: 35,
    width: 35,
    decoration: BoxDecoration(
      color: const Color(0xffFFF9E5),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap,
        child: SvgPicture.asset(
          assets,
          height: 16,
        )),
  );
}
