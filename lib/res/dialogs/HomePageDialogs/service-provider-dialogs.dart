import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/add_hub_controller.dart';
import 'package:izuahia/controllers/service_controller.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/popups/login_popup.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/add-service.dart';
import 'package:izuahia/utils/helper_functions.dart';

ServiceController serviceController = Get.put(ServiceController());

// Service Fav Pop up
Widget serviceAddToCartPopUp({required BuildContext context, required HomeServiceModel serviceModel}) {
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
          children: [
            Stack(
              children: [
                Container(
                  height: height * .3,
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.orangeLight,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: NetworkImage(serviceModel.serviceImage), fit: BoxFit.cover),
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
                      assets: Assets.cancel,
                    ),
                  ),
                )
              ],
            ),
            10.verticalSpace,
            Text(
              serviceModel.serviceName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceModel.fullAddress,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                        color: AppColors.textColor),
                  ),
                  10.verticalSpace,
                  SizedBox(
                    height: Get.height * 0.15,
                    child: Text(
                      serviceModel.description,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  RoundButton(
                    label: "Add to Cart",
                    onPressed: () {},
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

// Service View Pop up
Widget serviceViewPopUp({
  required BuildContext context,
  required HomeServiceModel serviceModel,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
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
          children: [
            Stack(
              children: [
                Container(
                  height: height * .22,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(serviceModel.serviceImage),
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
                      assets: Assets.cancel,
                    ),
                  ),
                )
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
                        serviceModel.serviceName,
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
                            await serviceController.addServiceToFavorites(
                              serviceId: serviceModel.sId,
                            );
                          }
                        },
                        assets: Assets.favIcon,
                      )
                    ],
                  ),
                  // 8.verticalSpace,
                  Text(
                    serviceModel.fullAddress,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                      color: AppColors.textColor,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    serviceModel.description,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: AppColors.textColor,
                    ),
                  ),
                  25.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Information',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Montserrat',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            8.verticalSpace,
                            infoWidget(title: serviceModel.phone, icon: Icons.phone),
                            8.verticalSpace,
                            infoWidget(title: serviceModel.email, icon: Icons.email),
                          ],
                        ),
                      ),
                      // 20.horizontalSpace,
                      Expanded(
                        flex: 0,
                        child: InkWell(
                          onTap: () async {
                            HelperFunctions.showLoadingDialogue(context);
                            await serviceController.launchMap(
                                latitude: serviceModel.latitude,
                                longitude: serviceModel.longitude,
                                serviceName: serviceModel.serviceName,
                                fullAddress: serviceModel.fullAddress);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 86.h,
                            width: 137.w,
                            decoration: BoxDecoration(
                                color: AppColors.orangeLight,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.blackColor, width: 1),
                                image: const DecorationImage(image: AssetImage(Assets.map), fit: BoxFit.cover)),
                          ),
                        ),
                      )
                    ],
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

// Service Comment Pop up
Widget serviceCommentPopUp({
  required BuildContext context,
  required HomeServiceModel serviceModel,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
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
          children: [
            Stack(
              children: [
                Container(
                  height: height * .22,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        serviceModel.serviceImage,
                      ),
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
                      assets: Assets.cancel,
                    ),
                  ),
                )
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceModel.serviceName,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // 8.verticalSpace,
                  Text(
                    serviceModel.fullAddress,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat-Itallic',
                      color: AppColors.textColor,
                    ),
                  ),
                  8.verticalSpace,

                  textFormFieldWidget(
                    title: 'Comment / Inquiry',
                    controller: serviceController.commentController,
                    hintText: 'Write Comment / Inquiry',
                    maxLines: 7,
                  ),
                  20.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: width * .3,
                      height: height * .05,
                      child: RoundButton(
                        label: 'Submit',
                        onPressed: () async {
                          HelperFunctions.showLoadingDialogue(context);
                          await serviceController.addServiceComment(serviceId: serviceModel.sId);
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

// Service Hub Pop up
Widget serviceHubPopUp(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: customButtons(
                      onTap: () {
                        Get.back();
                      },
                      assets: Assets.cancel)),
            ),
            30.verticalSpace,
            const Text(
              'Service Providers\n Near You',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
            ),
            30.verticalSpace,
            hubButton(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return serviceNewHubPopUp(context);
                      });
                },
                title: 'Add New Hub'),
            30.verticalSpace,
            hubButton(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return addServicePopUp(context);
                      });
                },
                title: 'Add New Service'),
          ],
        ),
      ),
    ),
  );
}

// Add New Hub Pop up
Widget serviceNewHubPopUp(BuildContext context) {
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
              init: AddHubController(),
              builder: (addHubController) {
                return Form(
                  key: addHubController.hubFormKey,
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
                        controller: addHubController.hubNameController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Hub name is required';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                          title: 'Phone',
                          hintText: 'Enter Phone',
                          keyboardType: TextInputType.phone,
                          controller: addHubController.phoneController,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'phone is required';
                            } else if (!value.isPhoneNumber) {
                              return 'please enter a valid phone number';
                            }
                            return null;
                          }),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Email',
                        hintText: 'Enter Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: addHubController.emailController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'email is required';
                          } else if (!value.isEmail) {
                            return 'please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Address',
                        hintText: 'Enter Address',
                        controller: addHubController.addressController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'address is required';
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
                        controller: addHubController.locationController,
                        decoration: deco,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                        ),
                        onChanged: (value) {
                          if (!addHubController.listenerAdded) {
                            addHubController.locationController!.addListener(addHubController.listener);
                            addHubController.turnOnListener();
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
                        height: addHubController.placesList.isEmpty ? 0 : 150,
                        child: ListView.builder(
                          itemCount: addHubController.placesList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                addHubController.locationController!.removeListener(addHubController.listener);
                                addHubController.turnOffListener();
                                addHubController.locationController!.text = addHubController.placesList[index]['description'];
                                addHubController.placesList = [];
                                addHubController.getLatLongFromPlaceId(addHubController.locationController!.text);
                              },
                              title: Text(addHubController.placesList[index]['description']),
                            );
                          },
                        ),
                      ),
                      // ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Description',
                        hintText: 'Write Description',
                        maxLines: 5,
                        controller: addHubController.descriptionController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'description is required';
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
                            'Upload Photo',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                          ),
                          4.verticalSpace,
                          InkWell(
                              onTap: () {
                                addHubController.showImageSourceSelectionDialog();
                              },
                              child: Obx(
                                () => Container(
                                  height: height * .09,
                                  width: width * .20,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                                  child: addHubController.image != null
                                      ? Image.file(
                                          addHubController.image!,
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
                          height: height * .05,
                          child: RoundButton(
                            label: 'Submit',
                            onPressed: () async {
                              if (addHubController.hubFormKey!.currentState!.validate()) {
                                HelperFunctions.showLoadingDialogue(context);

                                await addHubController.createNewHub();
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

dynamic deco = InputDecoration(
  fillColor: AppColors.grey3,
  hintText: 'Enter Locatoin',
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

dynamic newLocationDeco = InputDecoration(
  fillColor: AppColors.yellow,
  hintText: 'Enter Locatoin',
  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.r),
    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.r),
    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.r),
    borderSide: const BorderSide(color: AppColors.grey3, width: 1),
  ),
  hintStyle: const TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
    fontSize: 10,
  ),
);

// Add New Hub Pop up
Widget addServicePopUp(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20), backgroundColor: AppColors.whiteColor, child: AddService());
}

Widget hubButton({required VoidCallback onTap, required String title}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 25.h,
      width: 120.w,
      // constraints: const BoxConstraints(maxWidth: double.infinity),
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
        style: const TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
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
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      color: AppColors.blackColor,
      borderRadius: BorderRadius.circular(2.0),
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
          height: 15,
        )),
  );
}
