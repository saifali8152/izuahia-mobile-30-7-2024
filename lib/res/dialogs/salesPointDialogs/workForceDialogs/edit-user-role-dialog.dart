import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget editUserRolePopUp(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20), backgroundColor: AppColors.whiteColor, child: EditUserRole());
}

class EditUserRole extends StatefulWidget {
  const EditUserRole({super.key});

  @override
  State<EditUserRole> createState() => _EditUserRoleState();
}

class _EditUserRoleState extends State<EditUserRole> {
  String dropdownvalue = 'Select';
  var salesPointItems = [
    'Select',
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  List<String> tabs = [
    'Receipt',
    'Inventory',
    'Invoice',
    'Negotiations',
    'Bids',
    'Quotes',
    'Workforce',
    'Thread',
    'Team',
  ];

  List<String> selectedTags = [];
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit User Roles',
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
              10.verticalSpace,
              receiptDetailsWidget(onTap: () {}),
              10.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Sales Point',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 42,
                    decoration: BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(10), boxShadow: [
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
                      items: salesPointItems.map((String items) {
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
                        });
                      },
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Wrap(
                spacing: 20.0,
                runSpacing: 10.0,
                children: tabs.map((text) {
                  bool isSelected = selectedTags.contains(text);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedTags.remove(text);
                        } else {
                          selectedTags.add(text);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.yellow
                            : Colors.transparent,
                        border: Border.all(
                            color: isSelected
                                ? AppColors.yellow
                                : AppColors.blackColor,
                            width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              30.verticalSpace,
              Align(
                  alignment: Alignment.center,
                  child:
                      SizedBox(width: width * .28, height: height * .05, child: RoundButton(label: 'Submit', onPressed: () {}))),
            ],
          ),
        ),
      ),
    );
  }
}

Widget receiptDetailsWidget({
  required VoidCallback onTap,
}) {
  return Container(
    constraints: const BoxConstraints(maxHeight: double.infinity),
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 13.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.w, 4.h, 8.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textField(),
                        const Text(
                          'Customer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontFamily: 'Inter', color: AppColors.darkGrey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    17.horizontalSpace,
                    const Text('Select User',
                        style: TextStyle(
                            fontSize: 12, fontFamily: 'Montserrat', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
                  ],
                ),
                const Divider(
                  color: AppColors.blackColor,
                  thickness: 0.5,
                  indent: 100,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * .10,
                      width: Get.width * .19,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          image: const DecorationImage(image: AssetImage(Assets.profileImage), fit: BoxFit.cover),
                          color: AppColors.yellow2),
                    ),
                    20.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Name:',
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'Inter', color: AppColors.darkGrey, fontWeight: FontWeight.w600)),
                            8.horizontalSpace,
                            const Text('Inayat Ali',
                                style: TextStyle(
                                    fontSize: 10, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            const Text('Email:',
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'Inter', color: AppColors.darkGrey, fontWeight: FontWeight.w600)),
                            8.horizontalSpace,
                            const Text('inayatalibohio@gmail.com',
                                style: TextStyle(
                                    fontSize: 10, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // 4.verticalSpace,
                const Divider(
                  color: Color(0xff8D8E99),
                  thickness: 0.5,
                  indent: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget datePickerWidget({
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .047,
      width: Get.width,
      padding: const EdgeInsets.only(left: 10, right: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: AppColors.grey2,
              fontSize: 10,
            ),
          ),
          5.horizontalSpace,
          const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.darkGrey,
            size: 20,
          )
        ],
      ),
    ),
  );
}

Widget textField() {
  return SizedBox(
    height: Get.height * .02,
    width: Get.width * .2,
    child: Stack(
      children: [
        TextFormField(
          style: const TextStyle(fontSize: 6, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: const EdgeInsets.only(left: 25),
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10, fontFamily: 'Inter', color: AppColors.darkGrey),
            filled: true,
            // prefixIcon:
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.r),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.r),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.r),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
          ),
        ),
        const Positioned(
          top: 3,
          left: 5,
          child: Icon(
            Icons.search,
            color: Color(0xff8D8E99),
            size: 12,
          ),
        ),
      ],
    ),
  );
}
