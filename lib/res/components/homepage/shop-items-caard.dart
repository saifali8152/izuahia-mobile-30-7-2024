import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/add-stop-items.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/shop-items-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ShopItemsCard extends StatelessWidget {
  final HomeInventoryModel inventoryModel;
  const ShopItemsCard({
    super.key,
    required this.inventoryModel,
  });

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.only(top: 10.h, right: 12, bottom: 10.h),

      // height: height * .26,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: width * .40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.whiteColor, boxShadow: [
        BoxShadow(color: AppColors.grey3.withOpacity(0.6), spreadRadius: 0, blurRadius: 4, offset: const Offset(0, 3))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: Image.network(
              inventoryModel.inventoryImages[0],
              fit: BoxFit.cover,
              height: 135,
              width: double.infinity,
            ),
          ),
          // 8.verticalSpace,
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inventoryModel.inventoryName,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                ),
                3.verticalSpace,
                Row(
                  children: [
                    Text(
                      '${inventoryModel.sellingPrice} ${inventoryModel.inventoryBudgetCurrency}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter', color: AppColors.blackColor),
                    ),
                    10.horizontalSpace,
                  ],
                ),
                5.verticalSpace,
                Text(
                  inventoryModel.description,
                  style: const TextStyle(
                      fontSize: 9, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: customButtons(
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
                                      return AddStopItems(
                                        inventoryModel: inventoryModel,
                                      );
                                    });
                              }
                            },
                            assets: Assets.addIcon)),
                    5.horizontalSpace,
                    Expanded(
                        child: customButtons(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return shopItemViewPopUp(context: context, inventoryModel: inventoryModel);
                                  });
                            },
                            assets: Assets.eyeIcon)),
                    5.horizontalSpace,
                    Expanded(
                        child: customButtons(
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
                                      return shopItemsCommentPopUp(
                                        context: context,
                                        inventoryModel: inventoryModel,
                                      );
                                    });
                              }
                            },
                            assets: Assets.msgIcon)),
                    5.horizontalSpace,
                    Expanded(
                        child: customButtons(
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
                                      return shopItemBidPopup(context: context, inventoryModel: inventoryModel);
                                    });
                              }
                            },
                            assets: Assets.handIcon2)),
                  ],
                )
              ],
            ),
          ),
          // 8.verticalSpace,
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
