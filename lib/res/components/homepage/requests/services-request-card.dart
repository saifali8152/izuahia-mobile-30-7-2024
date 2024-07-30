import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/models/hub_model.dart';
import 'package:izuahia/models/sales_point_model.dart';
import 'package:izuahia/repository/create_request_repo.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/buttons.dart';
import 'package:izuahia/res/components/homepage/requests/request_comment_popup.dart';
import 'package:izuahia/res/components/homepage/requests/request_view_popup.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ServiceRequestCard extends StatelessWidget {
  final String? asset;
  final String title;
  final String? quantity;
  final String description;
  final String requestType;
  final String location;
  final String? irId;
  final String? srId;
  const ServiceRequestCard({
    super.key,
    this.asset,
    required this.title,
    this.quantity,
    required this.description,
    required this.requestType,
    required this.location,
    this.irId,
    this.srId,
  });

  @override
  Widget build(BuildContext context) {
    CreateRequestRepo repo = CreateRequestRepo();
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.only(top: 10.h, right: 12, bottom: 10.h),

      // height: height * .26,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: width * .42,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.whiteColor, boxShadow: [
        BoxShadow(color: AppColors.grey3.withOpacity(0.6), spreadRadius: 0, blurRadius: 4, offset: const Offset(0, 3))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: asset == null
                ? Image.asset(
                    Assets.noImage,
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                  )
                : Image.network(
                    asset!,
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Assets.noImage,
                        fit: BoxFit.cover,
                        height: 140,
                        width: double.infinity,
                      );
                    }
                  ),
          ),
          // 8.verticalSpace,
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                ),
                3.verticalSpace,
                quantity == null
                    ? const SizedBox.shrink()
                    : Column(children: [
                        Text(
                          quantity!,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                        ),
                        5.verticalSpace,
                      ]),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 9, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                ),
                12.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: customButtons(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return requestViewPopUp(
                                          context: context,
                                          description: description,
                                          name: title,
                                          imagePath: asset,
                                          quantity: quantity,
                                          requestType: requestType);
                                    });
                              },
                              assets: Assets.eyeIcon)),
                      5.horizontalSpace,
                      Expanded(
                        child: customButtons(
                          onTap: () async {
                            if (!HelperFunctions.isLoggedIn) {
                              showDialog(
                                context: context,
                                builder: loginPopUp,
                              );
                            } else {
                              HelperFunctions.showLoadingDialogue(context);
                              if (requestType == 'inventory') {
                                final List<SalesPointDatum> data = await repo.selectSalesPoint(fromHome: true);
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
                                        title: title,
                                        imagePath: asset,
                                        location: location,
                                        irId: irId,
                                        srId: srId,
                                        requestType: requestType,
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
                                          title: title,
                                          imagePath: asset,
                                          location: location,
                                          irId: irId,
                                          srId: srId,
                                          requestType: requestType,
                                          dropDownList: data,
                                        ),
                                      );
                                    }
                                  }
                                }
                              }
                            }
                          },
                          assets: Assets.msgIcon,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
