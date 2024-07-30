// Service Hub Pop up
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/add_booth_controller.dart';
import 'package:izuahia/controllers/add_new_sales_point_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

//***** ADD NEW SALES POINT *****/
Widget addSalesPointPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GetBuilder(
              init: AddSalesPointController(),
              builder: (addNewSalesPointController) {
                return Form(
                  key: addNewSalesPointController.salesPointFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add New Sales Point',
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
                        title: 'Sales Point Name',
                        hintText: 'Enter Sales Point Name',
                        controller: addNewSalesPointController.salesPointNameController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Booth name is required';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Phone',
                        hintText: 'Enter Phone',
                        controller: addNewSalesPointController.phoneController,
                        keyboardType: TextInputType.phone,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number is required';
                          } else if (!value.isPhoneNumber) {
                            return 'Please Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Email',
                        hintText: 'Enter Email',
                        controller: addNewSalesPointController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else if (!value.isEmail) {
                            return 'Please Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Address',
                        hintText: 'Enter Address',
                        controller: addNewSalesPointController.addressController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      const Text(
                        'Select Location',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                      6.verticalSpace,
                      TextFormField(
                        controller: addNewSalesPointController.locationController,
                        decoration: deco,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                        ),
                        onChanged: (value) {
                          if (!addNewSalesPointController.listenerAdded) {
                            addNewSalesPointController.locationController!.addListener(addNewSalesPointController.listener);
                            addNewSalesPointController.turnOnListener();
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Location is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      // Obx(
                      //   () =>
                      SizedBox(
                        height: addNewSalesPointController.placesList.isEmpty ? 0 : 150,
                        child: ListView.builder(
                          itemCount: addNewSalesPointController.placesList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                addNewSalesPointController.locationController!
                                    .removeListener(addNewSalesPointController.listener);
                                addNewSalesPointController.turnOffListener();
                                addNewSalesPointController.locationController!.text =
                                    addNewSalesPointController.placesList[index]['description'];
                                addNewSalesPointController.placesList = [];
                                addNewSalesPointController
                                    .getLatLongFromPlaceId(addNewSalesPointController.locationController!.text);
                              },
                              title: Text(addNewSalesPointController.placesList[index]['description']),
                            );
                          },
                        ),
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Description',
                        hintText: 'Write Description',
                        maxLines: 5,
                        controller: addNewSalesPointController.descriptionController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ),
                      10.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Upload Photo',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: AppColors.blackColor,
                            ),
                          ),
                          4.verticalSpace,
                          InkWell(
                              onTap: () {
                                addNewSalesPointController.showImageSourceSelectionDialog();
                              },
                              child: Obx(
                                () => Container(
                                  height: height * .09,
                                  width: width * .20,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                                  child: addNewSalesPointController.image != null
                                      ? Image.file(
                                          addNewSalesPointController.image!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.photo_camera,
                                          color: AppColors.grey2,
                                          size: 40,
                                        ),
                                ),
                              )),
                        ],
                      ),
                      20.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * .28,
                          height: height * .045,
                          child: RoundButton(
                            label: 'Submit',
                            onPressed: () async {
                              if (addNewSalesPointController.salesPointFormKey!.currentState!.validate()) {
                                HelperFunctions.showLoadingDialogue(context);
                                await addNewSalesPointController.createNewsalesPoint();
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
    ),
  );
}

//***** ADD NEW BOOTH *****/
Widget addNewBoothPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GetBuilder(
              init: AddBoothController(),
              builder: (addBoothController) {
                return Form(
                  key: addBoothController.boothFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add New Booth',
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
                            if (addBoothController.salesPointList.isEmpty) {
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
                                  addBoothController.isLoading.value ? 'Loading...' : 'No hubs available',
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
                                value: addBoothController.salesPointController!.text.isEmpty
                                    ? addBoothController.salesPointList[0].spId
                                    : addBoothController.salesPointController!.text,
                                dropdownColor: AppColors.grey3,
                                elevation: 0,
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: addBoothController.salesPointList.map((salesPoint) {
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
                                  addBoothController.salesPointController!.text = newValue!;
                                  addBoothController.update();
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Booth Name',
                        hintText: 'Enter Booth Name',
                        controller: addBoothController.boothNameController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Booth name is required';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Phone',
                        hintText: 'Enter Phone',
                        controller: addBoothController.phoneController,
                        keyboardType: TextInputType.phone,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone number is required';
                          } else if (!value.isPhoneNumber) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Email',
                        hintText: 'Enter Email',
                        controller: addBoothController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else if (!value.isEmail) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Address',
                        hintText: 'Enter Address',
                        controller: addBoothController.addressController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      const Text(
                        'Select Location',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                      6.verticalSpace,
                      TextFormField(
                        controller: addBoothController.locationController,
                        decoration: deco,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                        ),
                        onChanged: (value) {
                          if (!addBoothController.listenerAdded) {
                            addBoothController.locationController!.addListener(addBoothController.listener);
                            addBoothController.turnOnListener();
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                      // Obx(
                      //   () =>
                      SizedBox(
                        height: addBoothController.placesList.isEmpty ? 0 : 150,
                        child: ListView.builder(
                          itemCount: addBoothController.placesList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                addBoothController.locationController!.removeListener(addBoothController.listener);
                                addBoothController.turnOffListener();
                                addBoothController.locationController!.text = addBoothController.placesList[index]['description'];
                                addBoothController.placesList = [];
                                addBoothController.getLatLongFromPlaceId(addBoothController.locationController!.text);
                              },
                              title: Text(addBoothController.placesList[index]['description']),
                            );
                          },
                        ),
                      ),
                      // ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Description',
                        hintText: 'Write Description',
                        controller: addBoothController.descriptionController,
                        maxLines: 5,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ),
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
                              onTap: () {
                                addBoothController.showImageSourceSelectionDialog();
                              },
                              child: Obx(
                                () => Container(
                                  height: height * .09,
                                  width: width * .20,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                                  child: addBoothController.image != null
                                      ? Image.file(
                                          addBoothController.image!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.photo_camera,
                                          color: AppColors.grey2,
                                          size: 40,
                                        ),
                                ),
                              )),
                        ],
                      ),
                      20.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * .28,
                          height: height * .045,
                          child: RoundButton(
                            label: 'Submit',
                            onPressed: () {
                              if (addBoothController.boothFormKey!.currentState!.validate()) {
                                HelperFunctions.showLoadingDialogue(context);
                                addBoothController.createNewbooth();
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
    ),
  );
}

//***** ADD NEW HUB *****/
Widget addNewHubPopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
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
                    'Add New Hub',
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
                title: 'Service Hub Name',
                hintText: 'Enter Service Hub Name',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Phone',
                hintText: 'Enter Phone',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Email',
                hintText: 'Enter Email',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Address',
                hintText: 'Enter Address',
              ),
              8.verticalSpace,
              textFormFieldWidget(
                title: 'Location',
                hintText: 'Enter Location',
              ),
              8.verticalSpace,
              textFormFieldWidget(title: 'Description', hintText: 'Write Description', maxLines: 5),
              10.verticalSpace,
              Row(
                children: [
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
                  30.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location on Google Map',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                        ),
                        4.verticalSpace,
                        InkWell(
                          onTap: () {},
                          child: Container(
                              height: height * .09,
                              width: width * .60,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                              child: Image.asset(
                                Assets.map,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              20.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child:
                      SizedBox(width: width * .28, height: height * .045, child: RoundButton(label: 'Submit', onPressed: () {}))),
            ],
          ),
        ),
      ),
    ),
  );
}
