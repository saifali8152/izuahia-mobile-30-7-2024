import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/inventory_controller.dart';
import 'package:izuahia/controllers/shop-items-view-tab-controller.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/homepage/shopItemTabs/shop-item-feature-tab.dart';
import 'package:izuahia/res/components/homepage/shopItemTabs/shop-item-tab-views.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/utils/helper_functions.dart';

// Add Stop Items Pop up

InventoryController inventoryController = Get.put(InventoryController());

// Shop ItemView Pop up
Widget shopItemViewPopUp({required BuildContext context, required HomeInventoryModel inventoryModel}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  final ShopItemTabController itemTabController = Get.put(ShopItemTabController());
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * .22,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(inventoryModel.inventoryImages[0]), fit: BoxFit.cover)),
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
                            assets: Assets.cancel)))
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        inventoryModel.inventoryName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                      ),
                      customButtons(
                        onTap: () async {
                          if (!HelperFunctions.isLoggedIn) {
                            showDialog(
                              context: context,
                              builder: loginPopUp,
                            );
                          } else {
                            HelperFunctions.showLoadingDialogue(context);
                            await inventoryController.addInventoryToFavorites(
                              inventoryId: inventoryModel.inventoryId,
                            );
                          }
                        },
                        assets: Assets.favIcon,
                      )
                    ],
                  ),
                  Text(
                    '${inventoryModel.sellingPrice} ${inventoryModel.inventoryBudgetCurrency}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600),
                  ),
                  8.verticalSpace,
                  const Text(
                    'Summary Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  12.verticalSpace,
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 6, 5, 2),
                      alignment: Alignment.center,
                      height: height * .042,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.grey3.withOpacity(0.5),
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: const Offset(0, 3))
                          ],
                          border: Border.all(color: AppColors.yellow, width: 1)),
                      child: Obx(() {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: custonTabs(
                                    onTap: () {
                                      itemTabController.setCurrentIndex = 0;
                                    },
                                    isSelected: itemTabController.currentIndex.value == 0,
                                    title: 'Overview')),
                            Expanded(
                                child: custonTabs(
                                    onTap: () {
                                      itemTabController.setCurrentIndex = 1;
                                    },
                                    isSelected: itemTabController.currentIndex.value == 1,
                                    title: 'Features')),
                            Expanded(
                                child: custonTabs(
                                    onTap: () {
                                      itemTabController.setCurrentIndex = 2;
                                    },
                                    isSelected: itemTabController.currentIndex.value == 2,
                                    title: 'Specification')),
                          ],
                        );
                      })),
                  10.verticalSpace,
                  tabBarViews(inventoryModel: inventoryModel),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget tabBarViews({required HomeInventoryModel inventoryModel}) {
  return GetBuilder(
      init: ShopItemTabController(),
      builder: (itemTabController) {
        return [
          ShopItemOverviewTabView(
            overview: inventoryModel.overview,
            quantity: inventoryModel.quantity,
          ),
          ShopItemFeatureTabViews(
            features: inventoryModel.features,
            imagesList: inventoryModel.inventoryImages,
          ),
          ShopItemSpecificationsTabView(
            specification: inventoryModel.specifications,
            quantity: inventoryModel.quantity,
          )
        ][itemTabController.currentIndex.value];
      });
}

Widget custonTabs({
  required VoidCallback onTap,
  required bool isSelected,
  required String title,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.yellow : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: AppColors.blackColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

// Shop Item Comment Pop up
Widget shopItemsCommentPopUp({required BuildContext context, required HomeInventoryModel inventoryModel}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .68,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * .22,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(inventoryModel.inventoryImages[0]),
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
                        assets: Assets.cancel),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventoryModel.inventoryName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  8.verticalSpace,
                  textFormFieldWidget(
                    title: 'Comment / Inquiry',
                    controller: inventoryController.commentController,
                    hintText: 'Write Comment / Inquiry',
                    maxLines: 8,
                  ),
                  25.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: width * .27,
                      height: height * .044,
                      child: RoundButton(
                        label: 'Submit',
                        onPressed: () async {
                          HelperFunctions.showLoadingDialogue(context);
                          if (inventoryController.commentController.text.isNotEmpty) {
                            await inventoryController.addInventoryComment(
                              inventoryId: inventoryModel.inventoryId,
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Shop Item Hand Shake Pop up
Widget shopItemBidPopup({
  required BuildContext context,
  required HomeInventoryModel inventoryModel,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .65,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * .3,
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.orangeLight,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(inventoryModel.inventoryImages[0]),
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
                            assets: Assets.cancel)))
              ],
            ),
            12.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventoryModel.inventoryName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    inventoryModel.description,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.textColor),
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 95.0),
              child: hubButton(
                  onTap: () {
                    if (SharedPrefs().getString('default_currency') == inventoryModel.inventoryBudgetCurrency) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return shopItemHandShakeBidPopUp(context: context, inventoryModel: inventoryModel);
                          });
                    } else {
                      HelperFunctions.showSnackBar(
                        title: "Currency doesn't match",
                        msg: "Your default currency doesn't match the item's currency",
                        durationInSeconds: 5,
                      );
                    }
                  },
                  title: 'Bid'),
            ),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: hubButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return shopItemHandShakeBNagotiationPopUp(context: context, inventoryModel: inventoryModel);
                        });
                  },
                  title: 'Negotiation'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Shop Item HandShake
Widget shopItemHandShakeBidPopUp({required BuildContext context, required HomeInventoryModel inventoryModel}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .7,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: inventoryController.bidFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .2,
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(inventoryModel.inventoryImages[0]), fit: BoxFit.cover)),
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
                              assets: Assets.cancel)))
                ],
              ),
              12.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inventoryModel.inventoryName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                    8.verticalSpace,
                    const Text(
                      "Apply in Bidding",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                    ),
                    15.verticalSpace,
                    const Divider(
                      color: AppColors.grey2,
                      thickness: 0.6,
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        const Text(
                          "Actual Price:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.grey2),
                        ),
                        20.horizontalSpace,
                        Text(
                          '${inventoryModel.sellingPrice} ${inventoryModel.inventoryBudgetCurrency}',
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        const Text(
                          "Your Bid:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.grey2),
                        ),
                        20.horizontalSpace,
                        Expanded(
                          child: textField(
                            controller: inventoryController.bidPriceController,
                            hint: 'Enter Your Bid Here',
                          ),
                        )
                      ],
                    ),
                    12.verticalSpace,
                    const Divider(
                      color: AppColors.grey2,
                      thickness: 0.6,
                    ),
                    25.verticalSpace,
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width * .35,
                        height: height * .052,
                        child: RoundButton(
                          label: 'Submit Bid',
                          onPressed: () async {
                            if (inventoryController.bidFormKey.currentState!.validate()) {
                              HelperFunctions.showLoadingDialogue(context);
                              await inventoryController.addInventoryBid(
                                inventoryId: inventoryModel.inventoryId,
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Shop Item HandShake
Widget shopItemHandShakeBNagotiationPopUp({required BuildContext context, required HomeInventoryModel inventoryModel}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      height: height * .7,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: inventoryController.negotiationFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .2,
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(inventoryModel.inventoryImages[0]), fit: BoxFit.cover)),
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
                              assets: Assets.cancel)))
                ],
              ),
              12.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inventoryModel.inventoryName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    8.verticalSpace,
                    const Text(
                      "Negotiation",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                    ),
                    8.verticalSpace,
                    const Divider(
                      color: AppColors.grey2,
                      thickness: 0.6,
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        const Text(
                          "Actual Price:",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.grey2,
                          ),
                        ),
                        20.horizontalSpace,
                        Text(
                          '${inventoryModel.sellingPrice} ${inventoryModel.inventoryBudgetCurrency}',
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Negotiated Amount:",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.grey2),
                          ),
                        ),
                        // 4.horizontalSpace,
                        Expanded(
                          flex: 2,
                          child: textField(
                            controller: inventoryController.negotiationPriceController,
                            hint: "Enter Negotiation Amount",
                          ),
                        )
                      ],
                    ),
                    12.verticalSpace,
                    const Divider(
                      color: AppColors.grey2,
                      thickness: 0.6,
                    ),
                    Obx(() {
                      return inventoryController.fileNameController.isNotEmpty
                          ? Column(
                              children: [
                                12.verticalSpace,
                                Text(
                                  inventoryController.fileNameController.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    color: AppColors.grey2,
                                  ),
                                ),
                                12.verticalSpace,
                              ],
                            )
                          : const SizedBox.shrink();
                    }),
                    negotiationTextField(
                      controller: inventoryController.negotiationTextController,
                      onFileSelectTap: () async {
                        await inventoryController.pickFile();
                      },
                      onSendTap: () async {
                        if (inventoryController.negotiationFormKey.currentState!.validate()) {
                          HelperFunctions.showLoadingDialogue(context);
                          await inventoryController.addInventoryNegotiation(
                            inventoryId: inventoryModel.inventoryId,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget textField({
  required TextEditingController controller,
  required String hint,
}) {
  return SizedBox(
    height: Get.height * .035,
    width: Get.width,
    child: TextFormField(
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.blackColor),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: AppColors.whiteColor,
        hintStyle: const TextStyle(fontSize: 11),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey2, width: 1),
        ),
      ),
    ),
  );
}

Widget negotiationTextField({
  required TextEditingController controller,
  required VoidCallback onFileSelectTap,
  required VoidCallback onSendTap,
}) {
  return SizedBox(
    height: Get.height * .044,
    width: Get.width,
    child: Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.blackColor),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Write Negotiation Text Here',
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            fillColor: AppColors.whiteColor,
            hintStyle: const TextStyle(fontSize: 8),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.blackColor,
            ),
            onPressed: onSendTap,
          ),
        ),
        Positioned(
          right: 35.0,
          child: IconButton(
            icon: const Icon(
              Icons.attach_file_outlined,
              color: AppColors.blackColor,
            ),
            onPressed: onFileSelectTap,
          ),
        ),
      ],
    ),
  );
}

Widget customWidget({required String imagePath}) {
  return Container(
    height: 85,
    width: 85,
    margin: const EdgeInsets.only(right: 10, top: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey3, width: 1),
        image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover)),
  );
}

Widget hubButton({required VoidCallback onTap, required String title}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 25.h,
      // width: 120.w,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(color: AppColors.grey1.withOpacity(0.4), spreadRadius: 0, blurRadius: 3, offset: const Offset(0, 3))
          ],
          border: Border.all(color: AppColors.yellow, width: 1)),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w400),
      ),
    ),
  );
}

Widget infoWidget({required String title, required IconData icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    height: 22,
    // width: 130.w,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.yellow,
          size: 16,
        ),
        6.horizontalSpace,
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 8.sp, fontFamily: 'Montserrat', color: AppColors.yellow, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget customButtons({
  required VoidCallback onTap,
  required String assets,
}) {
  return Container(
    height: 32,
    width: 32,
    decoration: BoxDecoration(
      color: AppColors.blackColor,
      borderRadius: BorderRadius.circular(5.0),
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
          height: 16,
        )),
  );
}
