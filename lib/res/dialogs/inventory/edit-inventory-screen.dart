import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/res/dialogs/inventory/add-new-inventory-dialog.dart';

class EditInventory extends StatefulWidget {
  const EditInventory({super.key});

  @override
  State<EditInventory> createState() => _EditInventoryState();
}

class _EditInventoryState extends State<EditInventory> {
  String conditionValue = 'Brand New';
  var conditionItems = [
    'Brand New',
    'Used (Like New)',
    'Used',
  ];
  String dileveryTermsValue = 'Delivery paid seperately';
  var dileveryTermsItems = [
    'Delivery paid seperately',
    'Inclusive of Delivery',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Inventory',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: customButtons(
                          onTap: () {
                            Get.back();
                          },
                          assets: Assets.cancel)),
                ],
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Inventory Name',
                hintText: 'Enter Inventory Name',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Selling Price',
                hintText: 'Enter Selling Price',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Item Color',
                hintText: 'Enter Color',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Size',
                hintText: 'Enter Size',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Quantity',
                hintText: 'Enter Quantity',
                keyboardType: TextInputType.number,
              ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Condition',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(8.r), boxShadow: [
                      BoxShadow(
                        // color: Colors.grey,
                        color: const Color(
                          0xff9392AD,
                        ).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ]),
                    child: DropdownButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      menuMaxHeight: height * .2,
                      value: conditionValue,
                      dropdownColor: AppColors.grey3,
                      elevation: 0,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: conditionItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          conditionValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Overview',
                hintText: 'Write Overview',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Specifications',
                hintText: 'Enter Specifications',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Specifications',
                hintText: 'Write Specifications',
              ),
              8.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Terms',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(8.r), boxShadow: [
                      BoxShadow(
                        // color: Colors.grey,
                        color: const Color(
                          0xff9392AD,
                        ).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ]),
                    child: DropdownButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      menuMaxHeight: height * .2,
                      value: dileveryTermsValue,
                      dropdownColor: AppColors.grey3,
                      elevation: 0,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dileveryTermsItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dileveryTermsValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // 8.verticalSpace,
              // textFormFieldWidget(
              //     title: 'Overview', hintText: 'Write Overview', maxLines: 5),
              8.verticalSpace,
              textFormFieldWidget(title: 'Description', hintText: 'Write Description', maxLines: 5),
              10.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Photo',
                    style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                  ),
                  4.verticalSpace,
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: height * .09,
                      width: width * .20,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                      child: const Icon(
                        Icons.photo_camera,
                        color: AppColors.grey2,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child: button(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return addMultiplePopUp(context);
                            });
                      },
                      buttonName: 'Add Multiple Inventory')),
              20.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: width * .24, height: height * .040, child: RoundButton(label: 'Add', onPressed: () {}))),
            ],
          ),
        ),
      ),
    );
  }
}

Widget button({required VoidCallback onTap, required String buttonName}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .032,
      width: Get.width * .5,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.yellow)),
      child: Text(
        buttonName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
          fontSize: 12,
        ),
      ),
    ),
  );
}
