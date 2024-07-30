import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/search_screen_controller.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/custom-app-bar.dart';
import 'package:izuahia/res/components/homepage/requests/services-request-card.dart';
import 'package:izuahia/res/components/homepage/service-card.dart';
import 'package:izuahia/res/components/homepage/shop-items-caard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchScreenController searchScreenController = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: height,
              width: width,
              color: AppColors.blackColor,
              child: const CustomAppBar(),
            ),
            Positioned(
              height: height,
              top: height * .18,
              child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.only(top: 12.h, bottom: 105.h),
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                child: SingleChildScrollView(child: Builder(builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      25.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Search results for: ${searchScreenController.serchStringController.text}",
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.black01),
                        ),
                      ),
                      25.verticalSpace,
                      Obx(() {
                        return searchScreenController.isLoading.value
                            ? Column(
                                children: [
                                  150.verticalSpace,
                                  const Center(child: CircularProgressIndicator()),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  // 8.verticalSpace,
                                  ExpansionPanelList.radio(
                                    initialOpenPanelValue: 1,
                                    dividerColor: Colors.transparent,
                                    elevation: 0,
                                    
                                    children: [
                                      ExpansionPanelRadio(
                                        value: 1,
                                        headerBuilder: (context, isExpanded) {
                                          return const Text(
                                            'Service Providers search results:',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black01),
                                          );
                                        },
                                        body: searchScreenController.serviceList.isEmpty
                                            ? SizedBox(
                                                height: Get.height * 0.17,
                                                child: const Center(
                                                  child: Text('No Data Found'),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 0.35,
                                                child: GridView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: searchScreenController.serviceList.length,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: Get.height * 0.36,
                                                    mainAxisSpacing: 15.h,
                                                    crossAxisSpacing: 0,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemBuilder: (context, index) {
                                                    return ServiceCard(
                                                      serviceModel: searchScreenController.serviceList[index],
                                                    );
                                                  },
                                                ),
                                              ),
                                      ),
                                      ExpansionPanelRadio(
                                        value: 2,
                                        headerBuilder: (context, isExpanded) {
                                          return const Text(
                                            'Shop items search results',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black01),
                                          );
                                        },
                                        body: searchScreenController.inventoryList.isEmpty
                                            ? SizedBox(
                                                height: Get.height * 0.17,
                                                child: const Center(
                                                  child: Text('No Data Found'),
                                                ),
                                              )
                                            : SizedBox(
                                                height: Get.height * 0.35,
                                                child: GridView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: searchScreenController.inventoryList.length,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: Get.height * 0.36,
                                                    mainAxisSpacing: 15.h,
                                                    crossAxisSpacing: 0,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemBuilder: (context, index) {
                                                    return ShopItemsCard(
                                                      inventoryModel: searchScreenController.inventoryList[index],
                                                    );
                                                  },
                                                ),
                                              ),
                                      ),
                                      ExpansionPanelRadio(
                                        value: 3,
                                        headerBuilder: (context, isExpanded) {
                                          return const Text(
                                            'Requests search results',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black01),
                                          );
                                        },
                                        body: searchScreenController.requestList.isEmpty
                                            ? SizedBox(
                                                height: Get.height * 0.17,
                                                child: const Center(
                                                  child: Text('No Data Found'),
                                                ),
                                              )
                                            : SizedBox(
                                                height: Get.height * 0.8,
                                                child: GridView.builder(
                                                  itemCount: searchScreenController.requestList.length,
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: Get.height * 0.36,
                                                    mainAxisSpacing: 15.h,
                                                    crossAxisSpacing: 0,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemBuilder: (context, index) {
                                                    return searchScreenController.requestList[index].requestType == 'inventory'
                                                        ? ServiceRequestCard(
                                                            asset: searchScreenController
                                                                    .requestList[index].inventoryImages!.isEmpty
                                                                ? null
                                                                : searchScreenController.requestList[index].inventoryImages![0],
                                                            title: searchScreenController.requestList[index].inventoryName!,
                                                            quantity: searchScreenController.requestList[index].quantity!,
                                                            description: searchScreenController.requestList[index].description!,
                                                            requestType: searchScreenController.requestList[index].requestType,
                                                            irId: searchScreenController.requestList[index].irId!,
                                                            location: searchScreenController.requestList[index].fullAddress!,
                                                          )
                                                        : ServiceRequestCard(
                                                            asset: searchScreenController.requestList[index].serviceImage!,
                                                            title: searchScreenController.requestList[index].serviceName!,
                                                            description: searchScreenController.requestList[index].description!,
                                                            requestType: searchScreenController.requestList[index].requestType,
                                                            location: searchScreenController.requestList[index].fullAddress!,
                                                            srId: searchScreenController.requestList[index].srId,
                                                          );
                                                  },
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),

                                  // 15.verticalSpace,

                                  // 10.verticalSpace,

                                  // 12.verticalSpace,
                                  // 8.verticalSpace,

                                  170.verticalSpace,
                                ]),
                              );
                      }),
                    ],
                  );
                })
                    // ;}),
                    ),
              ),
            ),
          ],
        ));
  }
}
