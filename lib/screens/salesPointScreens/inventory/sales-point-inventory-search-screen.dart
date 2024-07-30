import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/inventory_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/shop-items-caard.dart';

class InventorySearchScreen extends StatefulWidget {
  const InventorySearchScreen({super.key});

  @override
  State<InventorySearchScreen> createState() => _InventorySearchScreenState();
}

class _InventorySearchScreenState extends State<InventorySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GetBuilder(
              init: InventoryController(),
              builder: (inventoryController) {
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
                        const Text('INVENTORY',
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
                        onChanged: inventoryController.setSearchString,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
                        decoration: InputDecoration(
                          hintText: 'Search Inventories',
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
                        return inventoryController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : inventoryController.allInventoriesList.isEmpty
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
                                    itemCount: inventoryController.filteredInventoriesList.length,
                                    itemBuilder: (context, index) => ShopItemsCard(
                                      inventoryModel: inventoryController.filteredInventoriesList[index],
                                    ),
                                  );
                      }),

                      //     GridView.builder(
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2, mainAxisExtent: 290, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      //   itemCount: 10,
                      //   itemBuilder: (context, index) => Card(
                      //     clipBehavior: Clip.hardEdge,
                      //     color: Colors.white,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Image.asset(
                      //           Assets.mobile,
                      //           height: MediaQuery.sizeOf(context).height * 0.14,
                      //           width: double.infinity,
                      //           fit: BoxFit.cover,
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               const Text(
                      //                 'iPhone 15 Pro',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     fontSize: 15,
                      //                     fontFamily: 'Montserrat',
                      //                     color: AppColors.blackColor,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //               2.verticalSpace,
                      //               RichText(
                      //                 text: const TextSpan(
                      //                     text: '₹599',
                      //                     style: TextStyle(
                      //                       fontSize: 14,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontFamily: 'Montserrat',
                      //                       color: Colors.black,
                      //                     ),
                      //                     children: [
                      //                       WidgetSpan(
                      //                           alignment: PlaceholderAlignment.baseline,
                      //                           baseline: TextBaseline.alphabetic,
                      //                           child: SizedBox(width: 5)),
                      //                       TextSpan(
                      //                         text: '₹599',
                      //                         style: TextStyle(
                      //                           fontSize: 13,
                      //                           fontFamily: 'Montserrat',
                      //                           fontWeight: FontWeight.normal,
                      //                           color: Colors.black,
                      //                           decoration: TextDecoration.lineThrough,
                      //                         ),
                      //                       )
                      //                     ]),
                      //               ),
                      //               2.verticalSpace,
                      //               const Text(
                      //                 'Sleek design and many interesting features',
                      //                 style: TextStyle(fontSize: 11, fontFamily: 'Montserrat', color: Colors.black),
                      //               ),
                      //               10.verticalSpace,
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                 children: [
                      //                   customButtons(onTap: () {}, assets: Assets.addIcon),
                      //                   customButtons(onTap: () {}, assets: Assets.eyeIcon),
                      //                   customButtons(onTap: () {}, assets: Assets.msgIcon),
                      //                   customButtons(onTap: () {}, assets: Assets.handIcon),

                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ))
                    )
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
