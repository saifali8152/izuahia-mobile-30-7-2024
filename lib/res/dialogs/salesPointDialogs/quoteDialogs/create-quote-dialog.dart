import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';
import 'package:izuahia/res/dialogs/HomePageDialogs/service-provider-dialogs.dart';

Widget createQuotePopUp(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;

  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: height * .75,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
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
                    'Create Quote',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700),
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
              20.verticalSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       'Quote Title',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //           fontSize: 14,
              //           fontFamily: 'Montserrat',
              //           color: AppColors.blackColor,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         height: 24,
              //         width: 24,
              //         decoration: BoxDecoration(
              //             color: AppColors.yellow,
              //             borderRadius: BorderRadius.circular(3)),
              //         child: const Icon(
              //           Icons.edit,
              //           color: AppColors.blackColor,
              //           size: 20,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const Divider(
              //   thickness: 1,
              //   color: Color(0xff8D8E99),
              // ),
              textFormFieldWidget(
                  title: 'Quote Detail',
                  hintText: 'Enter Quote Title',
                  label: 'Quote Title'),
              10.verticalSpace,
              inventoryTextField(),
              10.verticalSpace,
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Quote No: 30',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //           fontSize: 10,
              //           fontFamily: 'Inter',
              //           color: AppColors.blackColor,
              //           fontWeight: FontWeight.w500),
              //     ),
              //     Text(
              //       '28-02-2024',
              //       textAlign: TextAlign.justify,
              //       style: TextStyle(
              //           fontSize: 10,
              //           fontFamily: 'Inter',
              //           fontStyle: FontStyle.italic,
              //           color: AppColors.grey2,
              //           fontWeight: FontWeight.w400),
              //     ),
              //   ],
              // ),
              // 8.verticalSpace,
              quoteWidget(),
              5.verticalSpace,
              quoteWidget(),
              12.verticalSpace,
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              const Text(
                'Quote Summary',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600),
              ),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              3.verticalSpace,
              const DetailItem(title: 'Price:', value: '2400'),
              const DetailItem(title: 'Tax:', value: '124'),
              const DetailItem(title: 'Total Price:', value: '2524'),
              const Divider(
                color: Color(0xff8D8E99),
                thickness: 0.5,
              ),
              15.verticalSpace,
              customerDetailsWidget(onTap: () {}),
              10.verticalSpace,
              textFormFieldWidget(
                  title: 'Note', hintText: 'Write Note', maxLines: 5),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: width * .24,
                          height: height * .042,
                          child:
                              RoundButton(label: 'Submit', onPressed: () {}))),
                  10.horizontalSpace,
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: width * .24,
                          height: height * .042,
                          child: RoundButton(label: 'Save', onPressed: () {}))),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget quoteWidget() {
  bool isChecked = false;
  return Container(
    height: Get.height * .12,
    width: Get.width,
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.grey2, width: 1),
    ),
    child: Stack(
      children: [
        Row(
          children: [
            Container(
              height: Get.height * .12,
              width: Get.width * .23,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(Assets.profileImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemDetailItem(
                            title: '1.',
                            value: '',
                          ),
                          ItemDetailItem(
                            title: 'Item Name:',
                            value: 'Denum Jacket',
                          ),
                          ItemDetailItem(
                            title: 'Quantity:',
                            value: '01',
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemDetailItem(
                                      title: 'Color:',
                                      value: 'Blue',
                                    ),
                                    ItemDetailItem(
                                      title: 'Condition:',
                                      value: 'New',
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemDetailItem(
                                      title: 'Size:',
                                      value: 'XL',
                                    ),
                                    ItemDetailItem(
                                      title: 'Price:',
                                      value: '879',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          right: -5,
          child: Checkbox(
            value: isChecked,
            onChanged: (bool? newValue) {
              isChecked = newValue ?? false;
            },
          ),
        ),
      ],
    ),
  );
}


// Widget quoteWidget() {
//   bool isChecked = false;
//   return Container(
//     height: Get.height * .12,
//     width: Get.width,
//     decoration: BoxDecoration(
//       color: AppColors.whiteColor,
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: AppColors.grey2, width: 1),
//     ),
//     child: Row(
//       children: [
//         Container(
//           height: Get.height * .12,
//           width: Get.width * .23,
//           decoration: BoxDecoration(
//             image: const DecorationImage(
//               image: AssetImage(Assets.profileImage),
//               fit: BoxFit.cover,
//             ),
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ItemDetailItem(
//                       title: '1.',
//                       value: '',
//                     ),
//                     ItemDetailItem(
//                       title: 'Item Name:',
//                       value: 'Denum Jacket',
//                     ),
//                     ItemDetailItem(
//                       title: 'Quantity:',
//                       value: '01',
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ItemDetailItem(
//                               title: 'Color:',
//                               value: 'Blue',
//                             ),
//                             ItemDetailItem(
//                               title: 'Condition:',
//                               value: 'New',
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: 50),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ItemDetailItem(
//                               title: 'Size:',
//                               value: 'XL',
//                             ),
//                             ItemDetailItem(
//                               title: 'Price:',
//                               value: '879',
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Checkbox(
//                     value: isChecked,
//                     onChanged: (bool? newValue) {
//                       isChecked = newValue ?? false;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget inventoryTextField() {
  return SizedBox(
    height: Get.height * .087,
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inventory',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              color: AppColors.blackColor),
        ),
        6.verticalSpace,
        TextFormField(
          onTap: () {},
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xff8D8E99)),
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xff8D8E99),
              size: 25,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customerDetailsWidget({
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
                              fontSize: 10,
                              fontFamily: 'Inter',
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    17.horizontalSpace,
                    const Text('Customer Details',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600)),
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
                          image: const DecorationImage(
                              image: AssetImage(Assets.profileImage),
                              fit: BoxFit.cover),
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
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.w600)),
                            8.horizontalSpace,
                            const Text('Inayat Ali',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            const Text('Email:',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.w600)),
                            8.horizontalSpace,
                            const Text('inayatalibohio@gmail.com',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)),
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

Widget textField() {
  return SizedBox(
    height: Get.height * .02,
    width: Get.width * .2,
    child: Stack(
      children: [
        TextFormField(
          style: const TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: const EdgeInsets.only(left: 25),
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                fontFamily: 'Inter',
                color: AppColors.darkGrey),
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

class ItemDetailItem extends StatelessWidget {
  final String title;
  final String value;

  const ItemDetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Inter',
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w500),
          ),
          4.horizontalSpace,
          Text(
            value,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Inter',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
