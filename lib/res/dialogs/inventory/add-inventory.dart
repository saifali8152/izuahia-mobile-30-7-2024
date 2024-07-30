import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/add_new_inventory_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

class AddInventory extends StatefulWidget {
  const AddInventory({super.key});

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
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

  String inventoryTypesValue = 'New';
  var inventoryTypeItems = ['New', 'Return'];

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
          child: GetBuilder(
              init: AddInventoryController(),
              builder: (addInventoryController) {
                return Form(
                  key: addInventoryController.inventoryFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add New Inventory',
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
                        controller: addInventoryController.inventoryNameController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Inventory name is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Sales Point',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.blackColor,
                            ),
                          ),
                          6.verticalSpace,
                          Obx(() {
                            if (addInventoryController.salesPointList.isEmpty) {
                              return Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.grey3,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xff9392AD,
                                      ).withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  addInventoryController.isSalesPointLoading.value ? 'Loading...' : 'No Sales Points available',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey2,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: AppColors.grey3,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xff9392AD,
                                    ).withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: DropdownButton<String>(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                menuMaxHeight: height * .2,
                                value: addInventoryController.salesPointIdController!.text.isEmpty
                                    ? addInventoryController.salesPointList[0].spId
                                    : addInventoryController.salesPointIdController!.text,
                                dropdownColor: AppColors.grey3,
                                elevation: 0,
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: addInventoryController.salesPointList.map((salesPoint) {
                                  return DropdownMenuItem<String>(
                                    value: salesPoint.spId,
                                    child: Text(
                                      salesPoint.spName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.grey2,
                                        fontSize: 10,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  addInventoryController.salesPointIdController!.text = newValue!;
                                  addInventoryController.update();
                                  addInventoryController.selectBooth(spId: newValue);
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      8.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Booth',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.blackColor,
                            ),
                          ),
                          6.verticalSpace,
                          Obx(() {
                            if (addInventoryController.boothList.isEmpty) {
                              return Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.grey3,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xff9392AD,
                                      ).withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  addInventoryController.salesPointList.isEmpty
                                      ? "Select Sales Point First"
                                      : addInventoryController.isBoothLoading.value
                                          ? 'Loading...'
                                          : 'No Booth available',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey2,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: AppColors.grey3,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xff9392AD,
                                    ).withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: DropdownButton<String>(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                menuMaxHeight: height * .2,
                                value: addInventoryController.boothIdController!.text.isEmpty
                                    ? addInventoryController.salesPointList[0].spId
                                    : addInventoryController.boothIdController!.text,
                                dropdownColor: AppColors.grey3,
                                elevation: 0,
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: addInventoryController.salesPointList.map((salesPoint) {
                                  return DropdownMenuItem<String>(
                                    value: salesPoint.spId,
                                    child: Text(
                                      salesPoint.spName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.grey2,
                                        fontSize: 10,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  addInventoryController.boothIdController!.text = newValue!;
                                  addInventoryController.update();
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Selling Price',
                        hintText: 'Enter Selling Price',
                        keyboardType: TextInputType.number,
                        controller: addInventoryController.sellingPriceController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Selling price is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Item Color',
                        hintText: 'Enter Color',
                        controller: addInventoryController.itemColorController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Color is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Size',
                        hintText: 'Enter Size',
                        controller: addInventoryController.sizeController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Size is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Quantity',
                        hintText: 'Enter Quantity',
                        keyboardType: TextInputType.number,
                        controller: addInventoryController.quantityController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'quantity is required';
                          } else {
                            return null;
                          }
                        },
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Inventory Type',
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
                              value: inventoryTypesValue,
                              dropdownColor: AppColors.grey3,
                              elevation: 0,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              underline: Container(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: inventoryTypeItems.map((String items) {
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
                                  inventoryTypesValue = newValue!;
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
                        controller: addInventoryController.overviewController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Overview is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Features',
                        hintText: 'Write Features',
                        controller: addInventoryController.featuresController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Features are required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Specifications',
                        hintText: 'Write Specifications',
                        controller: addInventoryController.specificationsController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Specifications are required';
                          } else {
                            return null;
                          }
                        },
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
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Description',
                        hintText: 'Write Description',
                        maxLines: 5,
                        controller: addInventoryController.descriptionController,
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      10.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Upload Photos',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                          ),
                          4.verticalSpace,
                          InkWell(
                            onTap: () async {
                              await addInventoryController.pickImages();
                            },
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
                          4.verticalSpace,
                          Obx(() {
                            if (addInventoryController.images.isEmpty) {
                              return const Text('No images selected.');
                            } else {
                              List<Widget> imageWidgets = [];
                              for (int i = 0; i < addInventoryController.images.length && i < 3; i++) {
                                imageWidgets.add(Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.file(
                                    addInventoryController.images[i],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ));
                              }
                  
                              if (addInventoryController.images.length > 3) {
                                imageWidgets.add(Container(
                                  width: 80,
                                  height: 80,
                                  color: AppColors.grey3,
                                  child: Center(
                                    child: Text(
                                      "+ ${addInventoryController.images.length - 3} more",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          color: AppColors.grey2),
                                    ),
                                  ),
                                ));
                              }
                  
                              return Wrap(
                                children: imageWidgets,
                              );
                            }
                          }),
                        ],
                      ),
                      // 12.verticalSpace,
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: button(
                      //         onTap: () {
                      //           showDialog(
                      //               context: context,
                      //               builder: (context) {
                      //                 return addMultiplePopUp(context);
                      //               });
                      //         },
                      //         buttonName: 'Add Multiple Inventory')),
                      20.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * .24,
                          height: height * .040,
                          child: RoundButton(
                            label: 'Add',
                            onPressed: () async {
                              if (addInventoryController.inventoryFormKey!.currentState!.validate()) {
                                HelperFunctions.showLoadingDialogue(context);
                                await addInventoryController.addNewInventory();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

Widget customButton({required VoidCallback onTap, required String buttonName}) {
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
