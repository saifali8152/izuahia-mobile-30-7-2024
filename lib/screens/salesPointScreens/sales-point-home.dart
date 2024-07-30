import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/booth-controller.dart';
import 'package:izuahia/controllers/bottom-navbar-controller.dart';
import 'package:izuahia/controllers/offtage-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/custom-app-bar.dart';
import 'package:izuahia/res/components/salesPoint/sales-point-category-widget.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/createRequestDialogues/create_request_dialogue.dart';
import 'package:izuahia/res/dialogs/inventory/add-new-inventory-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/add-new-sales-point-dialog.dart';
import 'package:izuahia/screens/SERVICEHUB/serviceHubSettings/service-hub-settings.dart';
import 'package:izuahia/screens/salesPointScreens/addSalesPointNewScreens/add%20new%20booth%20screens/add_booth_select_sale_screen.dart';
import 'package:izuahia/screens/salesPointScreens/bids/sales-point-bid-home-screen.dart';
import 'package:izuahia/screens/salesPointScreens/inventory/sales-point-inventory-home-screen.dart';
import 'package:izuahia/screens/salesPointScreens/invoice/sales-point-invoice-home.dart';
import 'package:izuahia/screens/salesPointScreens/ledger/sales-point-ledger-screen.dart';
import 'package:izuahia/screens/salesPointScreens/negotiations/sales-point-negotiations-home-screen.dart';
import 'package:izuahia/screens/salesPointScreens/quotes/sales-point-quotes-home.dart';
import 'package:izuahia/screens/salesPointScreens/receipt/sales-point-receipt-screen.dart';
import 'package:izuahia/screens/salesPointScreens/sales-point-delivery/sales_point_delivery_screen.dart';
import 'package:izuahia/screens/salesPointScreens/stockCount/sales-point-stock-count.dart';
import 'package:izuahia/screens/salesPointScreens/team/sales-point-team-screen.dart';
import 'package:izuahia/screens/salesPointScreens/thread/sales-point-booth-thread.dart';
import 'package:izuahia/screens/salesPointScreens/workforce/sales-point-booth-workforce.dart';
import 'package:izuahia/screens/select_business_screen.dart';

class SalesPointHomeScreen extends StatefulWidget {
  const SalesPointHomeScreen({super.key});

  @override
  State<SalesPointHomeScreen> createState() => _SalesPointHomeScreenState();
}

class _SalesPointHomeScreenState extends State<SalesPointHomeScreen> {
  List<Map<String, String>> itemList = [
    {'asset': Assets.receipt, 'title': 'Receipts'},
    {'asset': Assets.inventory, 'title': 'Inventory'},
    {'asset': Assets.invoice, 'title': 'Invoice'},
    {'asset': Assets.negoIcon, 'title': 'Negotiations'},
    {'asset': Assets.bids, 'title': 'Bids'},
    {'asset': Assets.quote, 'title': 'Quotes'},
    {'asset': Assets.workForce, 'title': 'Workforce'},
    {'asset': Assets.thread, 'title': 'Thread'},
    {'asset': Assets.application, 'title': 'Team'},
    {'asset': Assets.ledger, 'title': 'Ledger'},
    {'asset': Assets.stockCount, 'title': 'Stock Count'},
    {'asset': Assets.truck, 'title': 'Delivery'},
  ];

  final List<Map<String, dynamic>> list = [
    {'label': '23', 'icon': Assets.shopIcon},
    {'label': '03', 'icon': Assets.saleIcon},
    {'label': '05', 'icon': Assets.handIcon},
    {'label': '45', 'icon': Assets.icon},
  ];
  final ScrollController _scrollController = ScrollController();

  final BoothController _boothController = Get.put(BoothController());
  final OffStageController offStageController = Get.put(OffStageController());
  int _currentPage = 0;
  bool isMenuOpen = false;

  Widget _buildIndicatorRow() {
    List<Widget> indicators = [];
    int start = _currentPage - 1;
    int end = _currentPage + 1;

    if (_currentPage == 0) {
      start = _currentPage;
      end = _currentPage + 2;
    } else if (_currentPage == list.length - 1) {
      start = _currentPage - 2;
      end = _currentPage;
    }

    start = start.clamp(0, list.length - 1);
    end = end.clamp(0, list.length - 1);

    for (int i = start; i <= end; i++) {
      indicators.add(_buildPageIndicator(i == _currentPage));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 5.0,
      width: isActive ? 35.0 : 35.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.blackColor : AppColors.grey3,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ClipOval(
                child: FloatingActionButton(
                    heroTag: 'butn2',
                    elevation: 2,
                    backgroundColor: AppColors.yellow,
                    onPressed: () {
                      Get.to(() => const ServiceHubSettingScreen());
                    },
                    child: SvgPicture.asset(Assets.settings)),
              ),
            ),
            ClipOval(
              child: FloatingActionButton(
                  heroTag: 'butn3',
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
          ],
        ),
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.only(top: 120.h, left: 15.w, right: 15.w, bottom: 40.h),
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                children: [
                  // const SalesPointBusinessWidget(),
                  ezyBrotLimitedWidget(),
                  // const ServiceHubWorkWaveWidget(),
                  20.verticalSpace,
                  SizedBox(
                    height: height * .15,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: list.length,
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SalesCategoryWidget(
                            label: list[index]['label'],
                            onTap: () {},
                            asset: list[index]['icon'],
                          );
                        }),
                  ),
                  5.verticalSpace,

                  _buildIndicatorRow(),
                  12.verticalSpace,
                  boothWidget(),
                  12.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          return consultingdWidget(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const SalesPoitnInventoryRecepitScreen());
                                  break;
                                case 1:
                                  Get.to(() => const SalesPointInventoryHomeScreen());
                                  break;
                                case 2:
                                  Get.to(() => const SalesPointInVoiceHomeScreen());
                                  break;
                                case 3:
                                  Get.to(() => const SalesPointNegotiationHomeScreen());
                                  break;
                                case 4:
                                  Get.to(() => const SalesPointBidHomeScreen());
                                  break;
                                case 5:
                                  Get.to(() => const SalesPointQuotesHomeScreen());
                                  break;
                                case 6:
                                  Get.to(() => const SalesPointBoothWorkForceScreen());
                                  break;
                                case 7:
                                  Get.to(() => const SalesPointBoothThreadScreen());
                                  break;
                                case 8:
                                  Get.to(() => const SalesPointTeamScreen());
                                  break;
                                case 9:
                                  Get.to(() => const SalesPointLedgerScreen());
                                  break;
                                case 10:
                                  Get.to(() => const SalesPoitnStockCountScreen());
                                  break;
                                case 11:
                                  Get.to(() => const SalesPointDeliveryScreen());
                                  break;

                                default:
                                  print("Screen not defined for index $index");
                              }
                            },
                            title: itemList[index]['title'].toString(),
                            asset: itemList[index]['asset'].toString(),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                height: height * .16,
                width: width,
                decoration: const BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    )),
                child: const CustomAppBar()),
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
                showDialog(
                    context: context,
                    builder: (_) {
                      return serviceHubPopUp(context);
                      // return addSalesAndBoothPopUp(context);
                    });
              },
              buttonName: 'Add Service'),
          6.verticalSpace,
          button(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return addNewInventoryPopUp(context);
                    });
              },
              buttonName: 'Add Inventory'),
          6.verticalSpace,
          button(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return addSalesPointPopUp(context);
                    });
              },
              buttonName: 'Add Sales'),
          6.verticalSpace,
          button(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return createRequestPopUp(context);
                      // return addNewInventoryPopUp(context);
                    });
              },
              buttonName: 'Create Request'),
        ],
      ),
    );
  }

  Widget ezyBrotLimitedWidget() {
    int index = 0;
    // return Obx(() {
    return Container(
      height: Get.height * .05,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              if(index > BottomNavigationController().salesPointList.length){
                index--;
              }
            },
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
                size: 17,
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Assets.logo,
                  height: 40,
                  width: 55,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                BottomNavigationController().salesPointList[index].spName.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                   Get.to(() => const SelectBusinessScreen());
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.yellow),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.whiteColor,
                    size: 16,
                  ),
                ),
              ),
              8.horizontalSpace,
              GestureDetector(
                onTap: (){
                  if(index < BottomNavigationController().salesPointList.length){
                index++;
              }
                },
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
                    size: 17,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    // });
  }

  Widget boothWidget() {
    return Obx(() {
      return Container(
        height: Get.height * .05,
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
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
                  size: 17,
                ),
              ),
            ),
            Text(
              'Booth ${_boothController.boothNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                     Get.to(() => const BoothSelectSalesScreen());
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.yellow),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                      size: 16,
                    ),
                  ),
                ),
                8.horizontalSpace,
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
                      size: 17,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget consultingdWidget({required VoidCallback? onTap, required String title, required String asset}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey2.withOpacity(0.2)),
              BoxShadow(offset: const Offset(0, -3), spreadRadius: 0, blurRadius: 6, color: AppColors.grey3.withOpacity(0.2)),
            ],
            color: AppColors.whiteColor
            // ignore: prefer_const_constructors
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                SvgPicture.asset(asset),
                8.horizontalSpace,
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.blackColor,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
