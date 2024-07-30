// Service Hub Pop up
import 'package:flutter/material.dart';
import 'package:izuahia/controllers/add_inventory_request_controller.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

//***** ADD NEW INVENTORY POINT *****/
Widget addInventoryRequest(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20), backgroundColor: AppColors.whiteColor, child: AddInventory());
}

class AddInventory extends StatefulWidget {
  const AddInventory({super.key});

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  String dropdownvalue = 'Brand New';
  var items = [
    'Brand New',
    'Used (like New)',
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
              init: AddInventoryRequestController(),
              builder: (addInventoryRequestController) {
                return Form(
                  key: addInventoryRequestController.inventoryeRequestFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add Inventory Request',
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
                        controller: addInventoryRequestController.inventoryNameController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'inventory name is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Inventory Budget',
                        hintText: 'Enter budget',
                        controller: addInventoryRequestController.inventoryBudgetController,
                        keyboardType: TextInputType.number,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'inventory budget is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Item Color',
                        hintText: 'Enter Color',
                        controller: addInventoryRequestController.itemColorController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'color is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Size',
                        hintText: 'Enter Size',
                        controller: addInventoryRequestController.sizeController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'size is required';
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
                        controller: addInventoryRequestController.quantityController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Quantity is required';
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
                            decoration:
                                BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(8.r), boxShadow: [
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
                              value: dropdownvalue,
                              dropdownColor: AppColors.grey3,
                              elevation: 0,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              underline: Container(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
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
                                  dropdownvalue = newValue!;
                                  addInventoryRequestController.conditionController!.text = newValue;
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
                            decoration:
                                BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(8.r), boxShadow: [
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

                                  addInventoryRequestController.inventoryTypeController!.text = newValue;
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
                        controller: addInventoryRequestController.overviewController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Overview is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Features',
                        hintText: 'Enter Features',
                        controller: addInventoryRequestController.featuresController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
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
                          controller: addInventoryRequestController.specificationsController,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Specifications are required';
                            } else {
                              return null;
                            }
                          }),
                      8.verticalSpace,
                      const Text(
                        'Select Location',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                      6.verticalSpace,
                      TextFormField(
                        controller: addInventoryRequestController.locationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Location is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: deco,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                        ),
                        onChanged: (value) {
                          if (!addInventoryRequestController.listenerAdded) {
                            addInventoryRequestController.locationController!.addListener(addInventoryRequestController.listener);
                            addInventoryRequestController.turnOnListener();
                          }
                        },
                      ),
                      SizedBox(
                        height: addInventoryRequestController.placesList.isEmpty ? 0 : 150,
                        child: ListView.builder(
                          itemCount: addInventoryRequestController.placesList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                addInventoryRequestController.locationController!
                                    .removeListener(addInventoryRequestController.listener);
                                addInventoryRequestController.turnOffListener();
                                addInventoryRequestController.locationController!.text =
                                    addInventoryRequestController.placesList[index]['description'];
                                addInventoryRequestController.placesList = [];
                                addInventoryRequestController
                                    .getLatLongFromPlaceId(addInventoryRequestController.locationController!.text);
                              },
                              title: Text(addInventoryRequestController.placesList[index]['description']),
                            );
                          },
                        ),
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
                            decoration:
                                BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(8.r), boxShadow: [
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
                                  addInventoryRequestController.deliveryTermsController!.text = newValue;
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
                        controller: addInventoryRequestController.descriptionController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
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
                              await addInventoryRequestController.pickImages();
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
                            if (addInventoryRequestController.images.isEmpty) {
                              return const Text('No images selected.');
                            } else {
                              List<Widget> imageWidgets = [];
                              for (int i = 0; i < addInventoryRequestController.images.length && i < 3; i++) {
                                imageWidgets.add(Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.file(
                                    addInventoryRequestController.images[i],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ));
                              }

                              if (addInventoryRequestController.images.length > 3) {
                                imageWidgets.add(Container(
                                  width: 80,
                                  height: 80,
                                  color: AppColors.grey3,
                                  child: Center(
                                    child: Text(
                                      "+ ${addInventoryRequestController.images.length - 3} more",
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
                      20.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * .24,
                          height: height * .040,
                          child: RoundButton(
                            label: 'Add',
                            onPressed: () async {
                              if (addInventoryRequestController.inventoryeRequestFormKey!.currentState!.validate() &&
                                  addInventoryRequestController.images.isNotEmpty) {
                                HelperFunctions.showLoadingDialogue(context);

                                await addInventoryRequestController.createInventoryRequest();
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

dynamic deco = InputDecoration(
  fillColor: AppColors.grey3,
  hintText: 'Enter Location',
  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
  ),
  hintStyle: const TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
    color: AppColors.grey2,
    fontSize: 10,
  ),
);

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
