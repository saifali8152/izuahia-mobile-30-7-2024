import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

class ViewServiceDeatilScreen extends StatefulWidget {
  final HomeServiceModel serviceModel;
  const ViewServiceDeatilScreen({
    super.key,
    required this.serviceModel,
  });

  @override
  State<ViewServiceDeatilScreen> createState() => _ViewServiceDeatilScreenState();
}

class _ViewServiceDeatilScreenState extends State<ViewServiceDeatilScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                // Container(
                //     alignment: Alignment.topCenter,
                //     height: height,
                //     width: width,
                //     color: AppColors.blackColor,
                //     child: CustomAppBar(
                //       onSearch: () {},
                //     )),
                Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(top: 15.h, right: 18.w, left: 18.w),
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * .22,
                              width: width,
                              decoration: BoxDecoration(
                                color: AppColors.orangeLight,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(widget.serviceModel.hubImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                                  assets: Assets.cancel,
                                ),
                              ),
                            )
                          ],
                        ),
                        10.verticalSpace,
                        Text(
                          widget.serviceModel.hubName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        3.verticalSpace,
                        Text(
                          widget.serviceModel.fullAddress,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.italic,
                              color: Color(0xff64748B)),
                        ),
                        3.verticalSpace,
                        Text(
                          widget.serviceModel.hubDescription,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: Color(0xff64748B)),
                        ),
                        20.verticalSpace,
                        widget.serviceModel.hubServices!.isEmpty
                            ? const Center(
                                child: Text("No Data Found"),
                              )
                            : SizedBox(
                                height: Get.height * .15,
                                child: ListView.builder(
                                    itemCount: widget.serviceModel.hubServices!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return customList(
                                        title: widget.serviceModel.hubServices![index].serviceName,
                                        onTap: () {},
                                        asset: widget.serviceModel.hubServices![index].serviceImage,
                                      );
                                    }),
                              ),
                        10.verticalSpace,
                        const Text(
                          'Similar Firms',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.bold),
                        ),
                        16.verticalSpace,
                        widget.serviceModel.similarFirms!.isEmpty
                            ? const Center(
                                child: Text("No Data Found"),
                              )
                            : SizedBox(
                                height: Get.height * .15,
                                child: ListView.builder(
                                    itemCount: widget.serviceModel.similarFirms!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (_) {
                                          //       return serviceViewPopUp(context: context, );
                                          //     });
                                        },
                                        child: Container(
                                          height: Get.height * .09,
                                          width: Get.width * .26,
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(widget.serviceModel.similarFirms![index].hubImage),
                                                  fit: BoxFit.cover)),
                                        ),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget customList({
    required String title,
    required String asset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Get.height * .09,
              width: Get.width * .20,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.orangeLight,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(asset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            5.verticalSpace,
            Text(
              title,
              style:
                  const TextStyle(fontSize: 6, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: Color(0xff64748B)),
            )
          ],
        ),
      ),
    );
  }
}
