import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/add-button.dart';
import 'package:izuahia/res/dialogs/inventory/add-new-inventory-dialog.dart';
import 'package:izuahia/res/dialogs/inventory/edit-inventory-dialog.dart';
import 'package:izuahia/screens/salesPointScreens/inventory/sales-point-inventory-search-screen.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({super.key});

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  final List<Map<String, dynamic>> itemList = [
    {'image': Assets.mobile},
    {'image': Assets.laptop1},
    {'image': Assets.shoe},
    {'image': Assets.profileImage},
    {'image': Assets.mobile},
    {'image': Assets.laptop2},
    {'image': Assets.shoe},
    {'image': Assets.profileImage},
    {'image': Assets.profileImage},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: AppColors.yellow2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Assets.logo,
                  height: 45,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              20.horizontalSpace,
              const Text(
                'EZYBROT LIMITED',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          12.verticalSpace,
          Container(
            height: height * .048,
            width: width,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.25), offset: const Offset(0, 4), spreadRadius: 0, blurRadius: 4)
                ],
                border: const Border(left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('BOOTH 1',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  endIndent: 20,
                  height: 1,
                ),
              ),
              Text('INVENTORY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  indent: 20,
                  height: 1,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: filterWidget()),
              8.horizontalSpace,
              Expanded(flex: 2, child: textField()),
              8.horizontalSpace,
              Expanded(child: addButton(onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return addNewInventoryPopUp(context);
                    });
              }))
            ],
          ),
          12.verticalSpace,
          SizedBox(
            height: height * .4,
            child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: itemList.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 18, mainAxisSpacing: 14),
                itemBuilder: (context, index) {
                  return inventoryItemWidget(
                      image: itemList[index]['image'],
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return editInventoryPopUp(context);
                            });
                      });
                }),
          )
        ],
      ),
    );
  }

  Widget filterWidget() {
    return Container(
      height: Get.height * .030,
      width: Get.width,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.filterIcon,
            color: AppColors.blackColor,
          ),
          5.horizontalSpace,
          const Text('Filter',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontFamily: 'Inter', color: AppColors.darkGrey, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget textField() {
    return SizedBox(
      height: Get.height * .030,
      width: Get.width,
      child: TextFormField(
        onTap: () {
          Get.to(() => const InventorySearchScreen());
        },
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.whiteColor,
          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.darkGrey),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 22,
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
    );
  }

  Widget inventoryItemWidget({required String image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return shopItemViewPopUp(context: context, );
        //     });
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: Get.height * .13,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(3)),
                child: const Icon(
                  Icons.edit,
                  color: AppColors.blackColor,
                  size: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
