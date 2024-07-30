import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/thread-dialogs.dart/thread-booth-comments.dart';

class CommentsTabScreen extends StatelessWidget {
  const CommentsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> itemList = [
      {'image': Assets.mobile},
      {'image': Assets.laptop1},
      {'image': Assets.shoe},
      {'image': Assets.profileImage},
      {'image': Assets.mobile},
      {'image': Assets.laptop2},
      {'image': Assets.shoe},
      {'image': Assets.profileImage},
      {'image': Assets.profileImage},
    ];

    final height = MediaQuery.sizeOf(context).height;
    // final width = MediaQuery.sizeOf(context).width;

    return Expanded(
      child: SizedBox(
        height: height,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return negotiationTabItemWidget(
                  image: itemList[index]['image'],
                  onTap: () {},
                  context: context);
            }),
      ),
    );
  }

  Widget negotiationTabItemWidget(
      {required String image,
      required VoidCallback onTap,
      required BuildContext context}) {
    return Container(
      height: Get.height * .13,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.blackColor.withOpacity(0.25),
              offset: const Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 4),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * .133,
                width: Get.width * .26,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    image: DecorationImage(
                        image: AssetImage(Assets.laptop2), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('02-03-2024',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Inter',
                            color: Color(0xff9B9B9B),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400)),
                    2.verticalSpace,
                    const Text('HP Laptop',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700)),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Quanatity:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: Color(0xff9B9B9B),
                                fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        const Text('01',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Color:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: Color(0xff9B9B9B),
                                fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        const Text('Grey',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Size:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: Color(0xff9B9B9B),
                                fontWeight: FontWeight.w400)),
                        3.horizontalSpace,
                        const Text('15 Inch',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        const Text('Price:',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400)),
                        5.horizontalSpace,
                        const Text('4550',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          4.horizontalSpace,
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttons(
                    title: 'Comment',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return threadBoothCommentPopUp(context);
                          });
                    }),
                IntrinsicWidth(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: Get.height * 0.065,
                        width: Get.width * .12,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: const DecorationImage(
                            image: AssetImage(Assets.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10, left: 5),
                          child: Text(
                            'Inayat Ali',
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Inter',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttons({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * .03,
        // width: Get.width * .25,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(5)),
        child: Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                color: AppColors.yellow,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
