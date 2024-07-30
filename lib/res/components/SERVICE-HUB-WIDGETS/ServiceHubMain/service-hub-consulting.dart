import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/booth-controller.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/SERVICEHUB/Applications/service-hub-team-screen.dart';
import 'package:izuahia/screens/SERVICEHUB/Ledger/service-hub-ledger-screen.dart';
import 'package:izuahia/screens/SERVICEHUB/Negotiation/service-hub-negotation.dart';
import 'package:izuahia/screens/SERVICEHUB/Quotes/service-hub-quote-home.dart';
import 'package:izuahia/screens/SERVICEHUB/Receipts/service-hub-receipt.dart';
import 'package:izuahia/screens/SERVICEHUB/Threads/service-hub-thread-screen.dart';
import 'package:izuahia/screens/SERVICEHUB/WorkForce/service-hub-work-force.dart';

class ServiceHubConsultingWidget extends StatefulWidget {
  const ServiceHubConsultingWidget({super.key});

  @override
  State<ServiceHubConsultingWidget> createState() =>
      _ServiceHubConsultingWidgetState();
}

class _ServiceHubConsultingWidgetState
    extends State<ServiceHubConsultingWidget> {
  final BoothController _boothController = Get.put(BoothController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .32),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: const Color(0xffD3BBBA)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          boothHeader(),
          26.verticalSpace,
          Wrap(
            runSpacing: 10.h,
            children: List.generate(
                11,
                (index) => boothButton(index, () {
                      switch (index) {
                        case 0:
                          Get.to(() => const ServiceHubRecepitScreen());
                          break;
                        // case 1:
                        //   Get.to(() => const SalesPointInventoryHomeScreen());
                        //   break;
                        case 2:
                          Get.to(() => const ServiceHubQuotesHomeScreen());
                          break;
                        // case 3:
                        //   Get.to(() => const SalesPointInVoiceHomeScreen());
                        //   break;
                        case 4:
                          Get.to(() => const ServiceHubNegotiationScreen());
                          break;
                        // case 5:
                        //   Get.to(() => const SalesPointBidHomeScreen());
                        //   break;
                        case 6:
                          Get.to(() => const ServiceHubWorkForceScreen());
                          break;
                        case 7:
                          Get.to(() => const ServiceHubThreadScreen());
                          break;
                        case 8:
                          Get.to(() => const ServiceHubTeamScreen());
                          break;
                        case 9:
                          Get.to(() => const ServiceHubLedgerScreen());
                          break;
                        // case 10:
                        //   Get.to(() => const SalesPoitnStockCountScreen());
                        //   break;

                        default:
                          print("Screen not defined for index $index");
                      }
                    })),
          ),
        ],
      ),
    );
  }

  Widget boothHeader() {
    return Obx(() {
      return Container(
        height: Get.height * .05,
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _boothController.previousBooth,
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.5),
                        blurRadius: 3,
                        spreadRadius: 0,
                        offset: const Offset(0, 3),
                      )
                    ],
                    color: AppColors.blackColor),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.yellow,
                  size: 20,
                ),
              ),
            ),
            Text(
              'CONSULTING ${_boothController.boothNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: _boothController.nextBooth,
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.5),
                        blurRadius: 3,
                        spreadRadius: 0,
                        offset: const Offset(0, 3),
                      )
                    ],
                    color: AppColors.blackColor),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.yellow,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget boothButton(int index, VoidCallback onTap) {
    List<String> labels = [
      'RECEIPT',
      'INVENTORY',
      'QUOTES',
      'INVOICE',
      'NEGOTIATIONS',
      'BIDS',
      'WORKFORCE',
      'THREAD',
      'APPLICATIONS',
      'LEDGER',
      'STOCK COUNT'
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.blackColor, width: 1),
          color: Colors.white,
        ),
        child: Text(
          labels[index],
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
