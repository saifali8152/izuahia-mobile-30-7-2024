import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';

class ServiceHubSettingScreen extends StatefulWidget {
  const ServiceHubSettingScreen({super.key});

  @override
  State<ServiceHubSettingScreen> createState() => _ServiceHubSettingScreenState();
}

class _ServiceHubSettingScreenState extends State<ServiceHubSettingScreen> {
  // final DatePickerController controller = Get.put(DatePickerController());
  // final TextEditingController confirmPassController = TextEditingController();
  // final TextEditingController newPassController = TextEditingController();

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 10.h),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.grey2.withOpacity(0.4),
                                      offset: const Offset(0, 3),
                                      spreadRadius: 0,
                                      blurRadius: 3)
                                ],
                                color: AppColors.yellow),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.blackColor,
                              size: 18,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              Assets.trash,
                              color: Colors.red,
                            )),
                        GestureDetector(
                          onTap: () {},
                          child: const Text('See All',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                                fontSize: 12,
                              )),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    settingsWidget(),
                    8.verticalSpace,
                    Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Edit Profile Picture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Montserrat', color: Color(0xff555555), fontWeight: FontWeight.w600),
                            ),
                            8.horizontalSpace,
                            SvgPicture.asset(Assets.profileEdit)
                          ],
                        )),
                    12.verticalSpace,
                    textFieldWidget(),
                    15.verticalSpace,
                    reUseAbleRow(),
                    10.verticalSpace,
                    servicesWidget(onTap: () {}, title: 'Consulting'),
                    10.verticalSpace,
                    servicesWidget(onTap: () {}, title: 'Contact Drafting'),
                    10.verticalSpace,
                    servicesWidget(onTap: () {}, title: 'Litigation Representation'),
                    10.verticalSpace,
                    servicesWidget(onTap: () {}, title: 'Legal Research'),
                    10.verticalSpace,
                    selectDefaultCurrencyDropdown(items: ['USD', 'EUR', 'PKR'], onChanged: (value) {})
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: SafeArea(
                child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(width: width * .56, height: height * .055, child: deleteButton()),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: SizedBox(
                              width: width * .56, height: height * .055, child: RoundButton(label: 'Save', onPressed: () {})),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectDefaultCurrencyDropdown({required List<String> items, required void Function(String?)? onChanged}) {
    return Container(
      height: 40.h,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            spreadRadius: 0,
            blurRadius: 5,
            color: AppColors.grey2.withOpacity(0.1),
          ),
          BoxShadow(
            offset: const Offset(0, -3),
            spreadRadius: 0,
            blurRadius: 5,
            color: AppColors.grey3.withOpacity(0.1),
          ),
        ],
        color: AppColors.whiteColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text(
            'Select default currency:',
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: 14,
            ),
          ),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.blackColor,
            size: 15,
          ),
          dropdownColor: AppColors.grey1, // Dark grey color for the dropdown menu
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget deleteButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: AppColors.blackColor, width: 1)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: () {},
        child: const Text(
          'Delete',
          style: TextStyle(fontSize: 16, color: AppColors.blackColor, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        ),
      ),
    );
  }

  Widget reUseAbleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Services',
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              fontSize: 16,
            )),
        GestureDetector(
          onTap: () {},
          child: const Text('See More',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: AppColors.yellow,
                fontSize: 12,
              )),
        ),
      ],
    );
  }

  Widget settingsWidget() {
    // return Obx(() {
    return Container(
      height: Get.height * .09,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            // onTap: _boothController.previousBooth,
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.5),
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(0, 3),
                    )
                  ],
                  color: AppColors.blackColor),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.yellow,
                size: 17,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              Assets.logo,
              height: 150,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            // onTap: _boothController.nextBooth,
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.5),
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(0, 3),
                    )
                  ],
                  color: AppColors.blackColor),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.yellow,
                size: 17,
              ),
            ),
          )
        ],
      ),
    );
    // });
  }

  Widget servicesWidget({required VoidCallback? onTap, required String title}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey2.withOpacity(0.1)),
              BoxShadow(offset: const Offset(0, -3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey3.withOpacity(0.1)),
            ],
            color: AppColors.whiteColor
            // ignore: prefer_const_constructors
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                fontSize: 14,
              ),
            ),
            Row(
              children: [Image.asset(Assets.trash), Image.asset(Assets.edit)],
            )
          ],
        ),
      ),
    );
  }

  Widget textFieldWidget() {
    return Container(
      height: 35.h,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), boxShadow: [
        BoxShadow(offset: const Offset(0, 3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey2.withOpacity(0.1)),
        BoxShadow(offset: const Offset(0, -3), spreadRadius: 0, blurRadius: 5, color: AppColors.grey3.withOpacity(0.1))
      ]
          // ignore: prefer_const_constructors
          ),
      child: TextFormField(
        // controller:,

        style: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
          fontSize: 14,
        ),

        autovalidateMode: AutovalidateMode.onUserInteraction,

        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          fillColor: AppColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          hintText: 'WorkWave & Co',
          prefixIcon: IconButton(onPressed: () {}, icon: SvgPicture.asset(Assets.userIcon)),
          hintStyle: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
