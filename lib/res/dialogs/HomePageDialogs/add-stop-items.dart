import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/inventory_controller.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/confirm_delete_popup.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/shop-items-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class AddStopItems extends StatefulWidget {
  final HomeInventoryModel inventoryModel;
  const AddStopItems({super.key, required this.inventoryModel});

  @override
  State<AddStopItems> createState() => _AddStopItemsState();
}

class _AddStopItemsState extends State<AddStopItems> {
  InventoryController inventoryController = Get.put(InventoryController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        height: height * .85,
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
                    height: height * .25,
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(widget.inventoryModel.inventoryImages[0]), fit: BoxFit.cover)),
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
                    Text(
                      widget.inventoryModel.inventoryName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                    8.verticalSpace,
                    Text(
                      widget.inventoryModel.description,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.textColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: SizedBox(
                            height: 85,
                            child: ListView.builder(
                                itemCount: widget.inventoryModel.inventoryImages.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return customWidget(imagePath: widget.inventoryModel.inventoryImages[index]);
                                }),
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blackColor),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.yellow,
                            ),
                          ),
                        )
                      ],
                    ),
                    12.verticalSpace,
                    const Text(
                      'Specifications',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: height * .050,
                      child: ListView.builder(
                          itemCount: widget.inventoryModel.specifications.split(",").length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              height: height * .15,
                              width: width * .25,
                              margin: const EdgeInsets.only(top: 10, right: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: AppColors.yellow2),
                              child: Text(
                                widget.inventoryModel.specifications.split(",")[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }),
                    ),
                    20.verticalSpace,
                    const Text(
                      'Add to cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                    addToCartWidget(),
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
                            String data = await inventoryController.addToCart(
                              inventoryId: widget.inventoryModel.inventoryId,
                              boothId: widget.inventoryModel.boothIdFk,
                            );

                            if (data.contains("delete")) {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => confirmDeletePopup(
                                    context: context,
                                    onYesTap: () async {
                                      Get.back();
                                      HelperFunctions.showLoadingDialogue(context);
                                      await inventoryController.addToCart(
                                        inventoryId: widget.inventoryModel.inventoryId,
                                        boothId: widget.inventoryModel.boothIdFk,
                                        isDelete: "1",
                                      );
                                    },
                                    onNoTap: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              }
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

  Widget addToCartWidget() {
    return Container(
      alignment: Alignment.center,
      height: Get.height * .05,
      width: Get.width,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 3, spreadRadius: 0, color: AppColors.grey3.withOpacity(0.5), offset: const Offset(0, 3))
          ],
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.yellow2, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          countButton(onTap: inventoryController.decrement, icon: Assets.decrement),
          // 10.horizontalSpace,
          Obx(() {
            return countWidget(cartQuantity: '${inventoryController.cartCount.value}');
          }),
          // 10.horizontalSpace,
          countButton(onTap: inventoryController.increment, icon: Assets.increment)
        ],
      ),
    );
  }

  Widget countWidget({required String cartQuantity}) {
    return Container(
      height: Get.height * .035,
      width: Get.width * .08,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(4)),
      child: Text(
        cartQuantity,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontFamily: 'Montserrat', color: AppColors.yellow, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget countButton({
    required VoidCallback onTap,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.yellow, width: 1)),
        child: SvgPicture.asset(
          icon,
          color: AppColors.yellow,
        ),
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
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(5.0),
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
            height: 15,
          )),
    );
  }
}
