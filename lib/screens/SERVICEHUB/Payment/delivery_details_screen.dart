import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/quoteDialogs/edit-quote-dialog.dart';
import 'package:izuahia/screens/SERVICEHUB/Payment/order_complete_screen.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  List<String> itemList = [Assets.master, Assets.paypal, Assets.applePay, Assets.payment4];

  var counter = 0;

  increment() {
    setState(() {
      counter++;
    });
  }

  decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'DELIVERY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                    10.verticalSpace,
                    const Text(
                      'Choose Pickup Location',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600),
                    ),
                    5.verticalSpace,
                    const PickupLocationTile(),
                    20.verticalSpace,
                    const Text(
                      'Choose Drop Off Location',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600),
                    ),
                    5.verticalSpace,
                    dropLocationTile(onTap: () {}, title: 'Sylvester Street, Oklahoma, USA'),
                    20.verticalSpace,
                    const Text(
                      'Select Delivery Firm',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600),
                    ),
                    5.verticalSpace,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              color: AppColors.grey2.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(0, -3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              color: AppColors.grey3.withOpacity(0.1),
                            ),
                          ],
                          color: AppColors.whiteColor),
                      child: Column(
                        children: [
                          inventoryTextField(),
                          10.verticalSpace,
                          const ItemTile(
                            title: 'Fastex Courier Service',
                            subtitle1: 'Fastest courier in the country!',
                            subtitle2: 'Average ETA: 2 days',
                            imagePath: Assets.scooter1,
                          ),
                          10.verticalSpace,
                          const ItemTile(
                            title: 'Tex Courier',
                            subtitle1: 'Fastest courier in the country!',
                            subtitle2: 'Average ETA: 2 days',
                            imagePath: Assets.scootr2,
                          ),
                          10.verticalSpace,
                          const ItemTile(
                            title: 'Petra Courier',
                            subtitle1: 'Fastest courier in the country!',
                            subtitle2: 'Average ETA: 2 days',
                            imagePath: Assets.courier,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 230.w,
                  height: 40.h,
                  child: RoundButton(
                    label: 'Complete Delivery Arrangement',
                    onPressed: () {
                      Get.to(() => const OrderCompleteScreen());
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Widget searchTextField() {
  return SizedBox(
    height: Get.height * .087,
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inventory',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', color: AppColors.blackColor),
        ),
        6.verticalSpace,
        TextFormField(
          onTap: () {},
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', fontSize: 14, color: Color(0xff8D8E99)),
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

Widget dropLocationTile({required VoidCallback? onTap, required String title}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 45.h,
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
          color: AppColors.whiteColor),
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
            children: [
              Image.asset(Assets.location),
              5.horizontalSpace,
              Image.asset(Assets.edit),
            ],
          )
        ],
      ),
    ),
  );
}

class ItemTile extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String imagePath;
  const ItemTile({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
              ),
              Text(
                subtitle1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PickupLocationTile extends StatelessWidget {
  const PickupLocationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.whiteColor, boxShadow: [
        BoxShadow(
          color: AppColors.grey3.withOpacity(0.6),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 3),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.college,
                scale: 1.5,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'iPhone World, Oklahoma, USA',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                  ),
                  RichText(
                    text: const TextSpan(
                        text: 'Contact: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: '+101 923 059 8572',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                  ),
                  RichText(
                    text: const TextSpan(
                        text: 'Email: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'iPhoneworld@gmail.com',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                  ),
                ],
              )
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                Assets.edit,
                color: AppColors.blackColor,
              )),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.yellow),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.blackColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
