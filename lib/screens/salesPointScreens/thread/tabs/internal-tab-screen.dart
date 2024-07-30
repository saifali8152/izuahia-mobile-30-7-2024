import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class InternalTabScreen extends StatelessWidget {
  const InternalTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // color: AppColors.whiteColor,
          height: MediaQuery.of(context).size.height * .43,
          child: Column(
            children: [
              commentWidget(),
              10.verticalSpace,
              commentWidget(),
              10.verticalSpace,
              commentWidget()
            ],
          ),
        ),
        commentField()
      ],
    );
  }

  Widget commentField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      child: Column(
        children: [
          const Divider(),
          10.verticalSpace,
          Stack(
            children: [
              SizedBox(
                height: Get.height * .05,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    filled: true,
                    hintText: 'Write Negotiation Text Here',
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(color: Color(0xff8D8E99), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(color: Color(0xff8D8E99), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(color: Color(0xff8D8E99), width: 1),
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8D8E99),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 30,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file_outlined,
                      color: AppColors.blackColor,
                    )),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.blackColor,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget commentWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    spreadRadius: 2,
                    blurRadius: 4)
              ],
              image: const DecorationImage(
                  image: AssetImage(Assets.profileImage), fit: BoxFit.cover)),
        ),
        10.horizontalSpace,
        Expanded(
          child: Container(
            height: Get.height * .046,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffD9D9D9)),
            child: const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
