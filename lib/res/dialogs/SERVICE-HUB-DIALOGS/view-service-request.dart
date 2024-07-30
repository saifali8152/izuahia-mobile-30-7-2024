import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/service_request_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';

Widget viewServiceRequestPopUp({
  required BuildContext context,
  required ServiceRequest serviceRequestItem,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      // height: height * .75,
      height: height * .70,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: height * .3,
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColors.orangeLight,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(serviceRequestItem.serviceImage), fit: BoxFit.cover)),
                ),
                Positioned(
                    top: 20,
                    right: 20,
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: customIconButton(
                            onTap: () {
                              Get.back();
                            },
                            assets: Assets.cancel)))
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceRequestItem.serviceName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  8.verticalSpace,
                  Text(
                    serviceRequestItem.description,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                  ),
                  8.verticalSpace,
                  const Text(
                    'Comments:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                        color: AppColors.textColor),
                  ),
                  8.verticalSpace,
                  serviceRequestItem.allComments.isEmpty
                      ? const Center(
                          child: Text(
                            'No Data Found',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.textColor,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: Get.height * 0.16,
                          child: ListView.builder(
                            itemCount: serviceRequestItem.allComments.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        serviceRequestItem.allComments[index].commentImage.isNotEmpty
                                            ? CircleAvatar(
                                                radius: 12,
                                                child: Image.network(serviceRequestItem.allComments[index].commentImage),
                                              )
                                            : const CircleAvatar(
                                                radius: 12,
                                                backgroundImage: AssetImage(Assets.profileImage),
                                              ),
                                              5.horizontalSpace,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              serviceRequestItem.allComments[index].commentBy,
                                              textAlign: TextAlign.justify,
                                              textDirection: TextDirection.ltr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Montserrat',
                                                  color: AppColors.textColor),
                                            ),
                                            Text(
                                              serviceRequestItem.allComments[index].comment,
                                              textAlign: TextAlign.justify,
                                              textDirection: TextDirection.ltr,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat',
                                                color: AppColors.textColor,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      serviceRequestItem.allComments[index].commentDatetime,
                                      textAlign: TextAlign.justify,
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          color: AppColors.textColor),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
            // 20.verticalSpace,
            // const Spacer(),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 10),
            //     child: SizedBox(
            //       width: width * .28,
            //       height: height * .05,
            //       child: RoundButton(
            //         label: 'Add Quote',
            //         onPressed: () {},
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    ),
  );
}

Widget customIconButton({
  required VoidCallback onTap,
  required String assets,
}) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      color: AppColors.blackColor,
      borderRadius: BorderRadius.circular(2.0),
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onTap,
        child: SvgPicture.asset(
          assets,
          height: 15,
        )),
  );
}
