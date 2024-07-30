import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SERVICEHUB/service-hub-delivery/servicehub_deliveries_tab.dart';
import 'package:izuahia/screens/SERVICEHUB/service-hub-delivery/servicehub_orders_tab.dart';
import 'package:izuahia/screens/SERVICEHUB/service-hub-delivery/servicehub_request_tab.dart';

class ServiceHubDeliveryScreen extends StatefulWidget {
  const ServiceHubDeliveryScreen({super.key});

  @override
  State<ServiceHubDeliveryScreen> createState() => _ServiceHubDeliveryScreenState();
}

class _ServiceHubDeliveryScreenState extends State<ServiceHubDeliveryScreen> {
  List<String> itemList = [Assets.master, Assets.paypal, Assets.applePay, Assets.payment4];

  final ThreadTabController tabController = Get.put(ThreadTabController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: AppColors.yellow),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: height,
                    width: width,
                    padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 20.h),
                    decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'DELIVERY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                          ),
                        ),
                        10.verticalSpace,
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: tabButtons(
                                      onTap: () {
                                        tabController.setCurrentIndex(0);
                                      },
                                      title: 'Deliveries',
                                      isSelected: tabController.currentIndex.value == 0)),
                              8.horizontalSpace,
                              Expanded(
                                child: tabButtons(
                                  onTap: () {
                                    tabController.setCurrentIndex(1);
                                  },
                                  title: 'Requests',
                                  isSelected: tabController.currentIndex.value == 1,
                                ),
                              ),
                              8.horizontalSpace,
                              Expanded(
                                child: tabButtons(
                                  onTap: () {
                                    tabController.setCurrentIndex(2);
                                  },
                                  title: 'Orders',
                                  isSelected: tabController.currentIndex.value == 2,
                                ),
                              ),
                            ],
                          );
                        }),
                        12.verticalSpace,
                        tabViews(),
                        10.verticalSpace,
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

Widget tabViews() {
  return GetBuilder<ThreadTabController>(
      init: ThreadTabController(),
      builder: (controller) {
        return [
          const ServiceHubHistoryTab(),
          const Expanded(child: ServiceHubDeliveryRequestsTab()),
          const Expanded(child: ServiceHubDeliveryOrdersTab()),
        ][controller.currentIndex.value];
      }
      // },
      );
}

Widget tabButtons({
  required VoidCallback onTap,
  required var title,
  bool? isSelected,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .034,
      width: Get.width * .2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelected! ? AppColors.yellow : AppColors.whiteColor,
          border: Border.all(
            color: AppColors.yellow,
          ),
          borderRadius: BorderRadius.circular(25)),
      child: Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
    ),
  );
}
