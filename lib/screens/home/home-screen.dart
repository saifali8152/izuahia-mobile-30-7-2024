import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/home_page_controller.dart';
import 'package:izuahia/controllers/offtage-controller.dart';
import 'package:izuahia/controllers/slider-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/custom-app-bar.dart';
import 'package:izuahia/res/components/homepage/service-provider-widget.dart';
import 'package:izuahia/res/components/homepage/requests/service-request-widget.dart';
import 'package:izuahia/res/components/homepage/shop-items-widget.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/createRequestDialogues/create_request_dialogue.dart';
import 'package:izuahia/res/dialogs/inventory/add-new-inventory-dialog.dart';
import 'package:izuahia/utils/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final SliderController introScreenController = Get.put(SliderController());
  final OffStageController offStageController = Get.put(OffStageController());
  final HomeScreenController homeController = Get.put(HomeScreenController());
  bool isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        floatingActionButton: ClipOval(
          child: FloatingActionButton(
              heroTag: 'butn1',
              backgroundColor: AppColors.yellow,
              onPressed: () {
                offStageController.isOpenMenu();
              },
              child: const Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 30,
              )),
        ),
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
                child: SingleChildScrollView(
                    child:
                         GetBuilder(
                            init: HomeScreenController(),
                            builder: (homeController) {
                              return
                        Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * .28,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          introScreenController.changePage(page);
                        },
                        children: [
                          homeWidget(),
                          homeWidget(),
                          homeWidget(),
                        ],
                      ),
                    ),
                    // homeWidget(),
                    10.verticalSpace,
                    Obx(() => _buildPageIndicator(introScreenController.currentPage.value)),
                    12.verticalSpace,
                    Obx(() {
                      return homeController.isLoading.value
                          ? Column(
                              children: [
                                80.verticalSpace,
                                const CircularProgressIndicator(),
                              ],
                            )
                          : Column(children: [
                              ServiceProviderWidget(
                                serviceList: homeController.serviceList,
                              ),
                              12.verticalSpace,
                              ShopItemsWidget(inventoriesList: homeController.inventoryList),
                              12.verticalSpace,
                              ServiceRequestWidget(
                                requestsList: homeController.requestList,
                              ),
                              170.verticalSpace,
                            ]);
                    }),
                  ],
                )
                    ;}),
                    ),
              ),
            ),
            Positioned(
                right: width * .10,
                bottom: height * .088,
                child: Obx(() => Offstage(offstage: offStageController.isMenuOpen.value, child: floatingOptions()))),
          ],
        ));
  }

  Widget floatingOptions() {
    return Container(
      // height: Get.height * .18,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width * .45,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey3.withOpacity(0.6),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, -3),
            ),
            BoxShadow(
              color: AppColors.grey3.withOpacity(0.6),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
          color: AppColors.whiteColor),
      child: Column(
        children: [
          button(
              onTap: () {
                if (!HelperFunctions.isLoggedIn) {
                  showDialog(
                    context: context,
                    builder: loginPopUp,
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return serviceHubPopUp(context);
                      });
                }
              },
              buttonName: 'Add Service'),
          6.verticalSpace,
          button(
              onTap: () {
                if (!HelperFunctions.isLoggedIn) {
                  showDialog(
                    context: context,
                    builder: loginPopUp,
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return addNewInventoryPopUp(context);
                      });
                }
              },
              buttonName: 'Add Inventory'),
          6.verticalSpace,
          button(
              onTap: () {
                if (!HelperFunctions.isLoggedIn) {
                  showDialog(
                    context: context,
                    builder: loginPopUp,
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return addSalesAndBoothPopUp(context);

                        // return addSalesPointPopUp(context);
                      });
                }
              },
              buttonName: 'Add Sales'),
          6.verticalSpace,
          button(
              onTap: () {
                if (!HelperFunctions.isLoggedIn) {
                  showDialog(
                    context: context,
                    builder: loginPopUp,
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return createRequestPopUp(context);
                        // return addNewInventoryPopUp(context);
                      });
                }
              },
              buttonName: 'Create Request'),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int currentPage) {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 4.h,
      width: isActive ? 29.0 : 29.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.blackColor : AppColors.grey3,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    );
  }

  Widget homeWidget() {
    return Container(
      // height: Get.height * .25,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
            Color(0xffFFE7A1),
            Color(0xffFFC61A),
          ])),
      child: Column(
        children: [
          Image.asset(Assets.valueImage),
          10.verticalSpace,
          const Text(
            'Value',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.blackColor),
          ),
          10.verticalSpace,
          const Text(
            'Quality and affordability combined. Discover handpicked deals for maximum value on our platform.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.blackColor),
          ),
        ],
      ),
    );
  }
}
