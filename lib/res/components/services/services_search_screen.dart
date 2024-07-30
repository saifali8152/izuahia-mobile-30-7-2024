import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/service_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/service-card.dart';

class ServicesSearchScreen extends StatefulWidget {
  const ServicesSearchScreen({super.key});

  @override
  State<ServicesSearchScreen> createState() => _ServicesSearchScreenState();
}

class _ServicesSearchScreenState extends State<ServicesSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GetBuilder(
              init: ServiceController(),
              builder: (serviceController) {
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
                        const Text('SERVICES',
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
                        onChanged: serviceController.setSearchString,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
                        decoration: InputDecoration(
                          hintText: 'Search Services',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          fillColor: AppColors.whiteColor,
                          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.darkGrey),
                          filled: true,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(3)),
                                    child: Transform.scale(
                                      scale: 0.6,
                                      child: SvgPicture.asset(
                                        Assets.filterIcon,
                                        color: AppColors.blackColor,
                                        height: 20,
                                      ),
                                    )),
                              ),
                              GestureDetector(
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
                            ],
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
                        return serviceController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : serviceController.allServicesList.isEmpty
                                ? const Center(
                                    child: Text('No Data Found..'),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 70),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: Get.height * 0.36,
                                      mainAxisSpacing: 15.h,
                                      crossAxisSpacing: 0,
                                    ),
                                    itemCount: serviceController.filteredServicesList.length,
                                    itemBuilder: (context, index) => ServiceCard(
                                      serviceModel: serviceController.filteredServicesList[index],
                                    ),
                                  );
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
