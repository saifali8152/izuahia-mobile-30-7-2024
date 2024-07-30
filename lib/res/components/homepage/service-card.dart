import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/screens/home/view-service-detail-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ServiceCard extends StatelessWidget {
  final HomeServiceModel serviceModel;
  const ServiceCard({
    super.key,
    required this.serviceModel,
  });

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.only(
        right: 12,
      ),
      // height: Get.height * .26,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: width * .42,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.whiteColor, boxShadow: [
        BoxShadow(color: AppColors.grey3.withOpacity(0.6), spreadRadius: 0, blurRadius: 4, offset: const Offset(0, 3))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(() =>  ViewServiceDeatilScreen(serviceModel: serviceModel));
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: Image.network(
                serviceModel.serviceImage,
                fit: BoxFit.cover,
                height: 140,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceModel.serviceName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                ),
                3.verticalSpace,
                Text(
                  serviceModel.fullAddress,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                ),
                5.verticalSpace,
                Text(
                  serviceModel.description,
                  style: const TextStyle(
                      fontSize: 9, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                ),
              ],
            ),
          ),
          5.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //     child: customButtons(
                //         onTap: () {
                //           showDialog(
                //               context: context,
                //               builder: (_) {
                //                 return !HelperFunctions.isLoggedIn
                //                     ? loginPopUp(context)
                //                     : serviceAddToCartPopUp(
                //                         context: context,
                //                         serviceModel: serviceModel,
                //                       );
                //               });
                //         },
                //         assets: Assets.addIcon)),
                // 5.horizontalSpace,
                Expanded(
                    child: customButtons(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return serviceViewPopUp(context: context, serviceModel: serviceModel);
                              });
                        },
                        assets: Assets.eyeIcon)),
                5.horizontalSpace,
                Expanded(
                    child: customButtons(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return !HelperFunctions.isLoggedIn
                                    ? loginPopUp(context)
                                    : serviceCommentPopUp(
                                        context: context,
                                        serviceModel: serviceModel,
                                      );
                              });
                        },
                        assets: Assets.msgIcon)),
              ],
            ),
          ),
          15.verticalSpace,
        ],
      ),
    );
  }

  Widget customButtons({
    required VoidCallback onTap,
    required String assets,
  }) {
    return Container(
      height: 30,
      width: 30,
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
}
