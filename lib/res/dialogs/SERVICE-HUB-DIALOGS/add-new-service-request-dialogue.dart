// Service Hub Pop up

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/add_service_request_controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';
import 'package:izuahia/utils/helper_functions.dart';

//***** ADD NEW SERVICE REQUEST *****/
Widget addServiceRequestPopUp(BuildContext context) {
  return const Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: AddServiceRequestDialogue(),
  );
}

class AddServiceRequestDialogue extends StatefulWidget {
  const AddServiceRequestDialogue({super.key});

  @override
  State<AddServiceRequestDialogue> createState() => _AddServiceRequestDialogueState();
}

class _AddServiceRequestDialogueState extends State<AddServiceRequestDialogue> {
  String dropdownvalue = 'Rigid';
  var items = [
    'Rigid',
    'Flexbile',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GetBuilder(
        init: AddServiceRequestController(),
        builder: (serviceRequestController) {
          return Form(
            key: serviceRequestController.serviceRequestFormKey,
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
                            'Add Service Request',
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
                        title: 'Service Name',
                        hintText: 'Enter Service Name',
                        controller: serviceRequestController.serviceNameController,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Service name is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      textFormFieldWidget(
                        title: 'Service Budget',
                        hintText: 'Enter Service Budget',
                        controller: serviceRequestController.serviceBudgetcontroller,
                        keyboardType: TextInputType.number,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Service budget is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      // const CurrencyTextField(),
                      8.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Budget Flexibility',
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
                                  serviceRequestController.budgetFlexiblityController!.text = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      const Text(
                        'Select Location',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                      ),
                      6.verticalSpace,
                      TextFormField(
                        controller: serviceRequestController.locationController,
                        decoration: deco,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.blackColor,
                        ),
                        onChanged: (value) {
                          if (!serviceRequestController.listenerAdded) {
                            serviceRequestController.locationController!.addListener(serviceRequestController.listener);
                            serviceRequestController.turnOnListener();
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
                        height: serviceRequestController.placesList.isEmpty ? 0 : 150,
                        child: ListView.builder(
                          itemCount: serviceRequestController.placesList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                serviceRequestController.locationController!.removeListener(serviceRequestController.listener);
                                serviceRequestController.turnOffListener();
                                serviceRequestController.locationController!.text =
                                    serviceRequestController.placesList[index]['description'];
                                serviceRequestController.placesList = [];
                                serviceRequestController.getLatLongFromPlaceId(serviceRequestController.locationController!.text);
                              },
                              title: Text(serviceRequestController.placesList[index]['description']),
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
                          controller: serviceRequestController.descriptionController,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'description is required';
                            } else {
                              return null;
                            }
                          }),
                      10.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Service Image/Logo',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                          ),
                          4.verticalSpace,
                          InkWell(
                              onTap: () {
                                serviceRequestController.showImageSourceSelectionDialog();
                              },
                              child: Obx(
                                () => Container(
                                  height: height * .09,
                                  width: width * .20,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                                  child: serviceRequestController.image != null
                                      ? Image.file(
                                          serviceRequestController.image!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.photo_camera,
                                          color: AppColors.grey2,
                                          size: 40,
                                        ),
                                ),
                              )),
                          if (serviceRequestController.image == null)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Please select a service image/logo',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
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
                              if (serviceRequestController.serviceRequestFormKey!.currentState!.validate()) {
                                HelperFunctions.showLoadingDialogue(context);

                                await serviceRequestController.createServiceRequest();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
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

class CurrencyTextField extends StatefulWidget {
  const CurrencyTextField({super.key});

  @override
  _CurrencyTextFieldState createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  String dropdownValue = 'USD';
  final List<String> items = ['USD', 'EUR', 'GBP', 'INR'];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Service Budget',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
          ),
          6.verticalSpace,
          TextField(
            controller: _controller,

            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: AppColors.grey3,
              hintText: 'Enter Service Budget',
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
              // suffixIcon: Container(
              //   padding: const EdgeInsets.only(left: 10, right: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[300],
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(8.r),
              //       bottomRight: Radius.circular(8.r),
              //     ),
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       value: dropdownValue,
              //       icon: const Icon(Icons.keyboard_arrow_down),
              //       dropdownColor: Colors.grey[300],
              //       elevation: 0,
              //       borderRadius: BorderRadius.circular(10.r),
              //       items: items.map((String item) {
              //         return DropdownMenuItem<String>(
              //           value: item,
              //           child: Text(
              //             item,
              //             style: const TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //               fontSize: 16,
              //             ),
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           dropdownValue = newValue!;
              //         });
              //       },
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
                      GooglePlaceAutoCompleteTextField(
                        textEditingController: serviceRequestController.locationController!,
                        googleAPIKey: "AIzaSyAJqWJNX_nUocDT2Q-QPHiJZcCyAU34fm00",
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
                        boxDecoration: BoxDecoration(
                          color: AppColors.grey3,
                          borderRadius: BorderRadius.circular(8.r),
                          // borderSide: const BorderSide(color: AppColors.grey3, width: 1),
                        ),
                        inputDecoration: InputDecoration(
                          fillColor: AppColors.grey3,
                          hintText: 'Enter location',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          filled: true,
                          hintStyle: const TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey2,
                            fontSize: 10,
                          ),
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
                        ),
                        debounceTime: 800, // default 600 ms, // optional by default null is set
                        isLatLngRequired: true, // if you required coordinates from place detail
                        getPlaceDetailWithLatLng: (Prediction prediction) {
                          // this method will return latlng with place detail
                          print("placeDetails" + prediction.lng.toString());
                        }, // this callback is called when isLatLngRequired is true
                        itemClick: (Prediction prediction) {
                          serviceRequestController.locationController!.text = prediction.description ?? 'desc';
                          log('location: ${prediction.lat} + ${prediction.lng} ');
                          // serviceRequestController.locationController!.selection = TextSelection.fromPosition(
                          //   TextPosition(
                          //     offset: prediction.description?.length ?? 0,
                          //   ),
                          // );
                        },
                        // if we want to make custom list item builder
                        itemBuilder: (context, index, Prediction prediction) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(child: Text(prediction.description ?? ""))
                              ],
                            ),
                          );
                        },
                        // if you want to add seperator between list items
                        seperatedBuilder: const Divider(),
                        // want to show close icon
                        isCrossBtnShown: true,
                        // optional container padding
                        containerHorizontalPadding: 0,
                      ),
*/

// GooglePlacesAutoCompleteTextFormField(
//   textEditingController: serviceRequestController.locationController!,
//   googleAPIKey: "AIzaSyAJqWJNX_nUocDT2Q-QPHiJZcCyAU34fm0",
//   debounceTime: 400,
//   isLatLngRequired: true,
//   validator: (value) {
//     if (value!.isEmpty) {
//       return 'Location is required';
//     }
//     return null;
//   },
//   style: const TextStyle(
//       fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
//   decoration: deco,
//   getPlaceDetailWithLatLng: (prediction) {
//     // this method will return latlng with place detail
//     log("Coordinates: (${prediction.lat},${prediction.lng})");
//     serviceRequestController.latitude.value = prediction.lat ?? '0.0';
//     serviceRequestController.longitude.value = prediction.lng ?? '0.0';
//   }, // this callback is called when isLatLngRequired is true
//   itmClick: (prediction) {
//     serviceRequestController.locationController!.text = prediction.description ?? "test descriptions ss";
//   },
//   countries: ['PK', 'US'],
//   // buildCounter: ,
// ),
