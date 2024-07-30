import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/favorite_controller.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/confirm_delete_popup.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/shop-items-dialogs.dart';
import 'package:izuahia/screens/profile/Favorite/confirm_delete_favorite.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> itemList = [Assets.master, Assets.paypal, Assets.applePay, Assets.payment4];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //     alignment: Alignment.topCenter,
              //     height: height,
              //     width: width,
              //     color: AppColors.blackColor,
              //     child: CustomAppBar(
              //       onSearch: () {},
              //     )),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: GestureDetector(
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
              ),
              Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 150.h),
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            const Text(
                              'FAVORITE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: AppColors.blackColor,
                                ))
                          ],
                        ),
                        GetBuilder(
                            init: FavoritesController(),
                            builder: (favoritesController) {
                              return SizedBox(
                                height: height,
                                child: favoritesController.isLoading.value
                                    ? const Center(child: CircularProgressIndicator())
                                    : favoritesController.allFavoritesList.isEmpty
                                        ? const Center(
                                            child: Text("No Data Found"),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            itemCount: favoritesController.allFavoritesList.length,
                                            itemBuilder: (context, index) {
                                              return favoritesController.allFavoritesList[index].fType == 'service'
                                                  ? serviceFavItem(
                                                      serviceModel: favoritesController.allFavoritesList[index].serviceModel!,
                                                      favId: favoritesController.allFavoritesList[index].fId,
                                                      context: context,
                                                    )
                                                  : inventoryFavItem(
                                                      inventoryModel: favoritesController.allFavoritesList[index].inventoryModel!,
                                                      favId: favoritesController.allFavoritesList[index].fId,
                                                      context: context,
                                                    );
                                            }),
                              );
                            }),
                        70.verticalSpace,
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

Widget serviceFavItem({required HomeServiceModel serviceModel, required BuildContext context, required String favId}) {
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) => serviceViewPopUp(
          context: context,
          serviceModel: serviceModel,
        ),
      );
    },
    child: Container(
      height: Get.height * .15,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * .12,
                width: Get.width * .19,
                margin: const EdgeInsets.only(right: 10, top: 12, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage(serviceModel.serviceImage), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      serviceModel.serviceName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Address:',
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        Text(
                          serviceModel.fullAddress,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Description:',
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        Text(
                          serviceModel.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: customButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => confirmDeletePopup(
                          context: context,
                          onNoTap: () {},
                          onYesTap: () {
                            Get.find<FavoritesController>().deleteFavorite(favoriteId: favId);
                          }),
                    );
                  },
                  title: 'Delete'))
        ],
      ),
    ),
  );
}

Widget inventoryFavItem({
  required HomeInventoryModel inventoryModel,
  required BuildContext context,
  required String favId,
}) {
  return Container(
    height: Get.height * .15,
    width: Get.width,
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      boxShadow: [
        BoxShadow(color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4),
      ],
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * .12,
              width: Get.width * .19,
              margin: const EdgeInsets.only(right: 10, top: 12, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(image: AssetImage(Assets.laptop2), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    inventoryModel.inventoryName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Price:',
                          style: TextStyle(
                              fontSize: 10, fontFamily: 'Inter', color: Color(0xff9B9B9B), fontWeight: FontWeight.w400)),
                      3.horizontalSpace,
                      Text(
                        '${inventoryModel.sellingPrice} ${inventoryModel.inventoryBudgetCurrency}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'Inter',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Inter',
                          color: Color(0xff9B9B9B),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      3.horizontalSpace,
                      Text(
                        inventoryModel.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'Inter',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customButton(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return shopItemHandShakeBNagotiationPopUp(context: context, inventoryModel: inventoryModel);
                                });
                          },
                          title: 'Negotiate'),
                      16.horizontalSpace,
                      customButton(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return shopItemHandShakeBidPopUp(context: context, inventoryModel: inventoryModel);
                                });
                          },
                          title: 'Bid'),
                      16.horizontalSpace,
                      customButton(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => confirmDeleteFavoritePopup(
                                context: context,
                                onNoTap: () {
                                  Get.back();
                                },
                                onYesTap: () {
                                  Get.find<FavoritesController>().deleteFavorite(favoriteId: favId);
                                },
                              ),
                            );
                          },
                          title: 'Delete')
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 4),
          child: SvgPicture.asset(Assets.cart1),
        )
      ],
    ),
  );
}

Widget customButton({required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .03,
      // width: Get.width * .15,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
      child: Text(title,
          style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
    ),
  );
}
