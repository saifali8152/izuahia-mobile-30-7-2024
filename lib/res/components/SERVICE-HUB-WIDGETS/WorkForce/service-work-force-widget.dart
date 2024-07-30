import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/add-button.dart';
import 'package:izuahia/res/components/salesPoint/bids/bid-home-widget.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/workForceDialogs/add-user-to-work-force-dialog.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/workForceDialogs/edit-user-role-dialog.dart';

class ServiceWorkForceWidget extends StatefulWidget {
  const ServiceWorkForceWidget({super.key});

  @override
  State<ServiceWorkForceWidget> createState() => _ServiceWorkForceWidgetState();
}

class _ServiceWorkForceWidgetState extends State<ServiceWorkForceWidget> {
  final List<Map<String, dynamic>> itemList = [
    {
      'image': Assets.profileImage,
      'label': 'Account Owner',
    },
    {
      'image': Assets.profileImage,
      'label': 'Business Manager',
    },
    {
      'image': Assets.shoe,
      'label': 'Team Manager',
    },
    {
      'image': Assets.profileImage,
      'label': 'Account Owner',
    },
    {
      'image': Assets.profileImage,
      'label': 'Team Manager',
    },
    {
      'image': Assets.profileImage,
      'label': 'Account Owner',
    },
    {
      'image': Assets.profileImage,
      'label': 'Business Managerr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .8,
      // constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13), color: AppColors.yellow2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Assets.logo,
                  height: 45,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              20.horizontalSpace,
              const Text(
                'WORKWAVE AND CO',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          12.verticalSpace,
          Container(
            height: height * .048,
            width: width,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 4)
                ],
                border: const Border(
                    left: BorderSide(color: AppColors.blackColor, width: 8))),
            child: const Text('CONSULTING',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700)),
          ),
          12.verticalSpace,
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  endIndent: 20,
                  height: 1,
                ),
              ),
              Text('WORKFORCE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600)),
              Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  indent: 20,
                  height: 1,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Align(
            alignment: Alignment.centerRight,
            child: addButton(onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return addUserToWorkForcePopUp(context);
                  });
            }),
          ),
          12.verticalSpace,
          Expanded(
            child: SizedBox(
              height: height,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return workForceItemWidget(
                        onTap: () {}, label: itemList[index]['label']);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget workForceItemWidget({
    required VoidCallback onTap,
    required String label,
  }) {
    return Container(
      // height: Get.height * .12,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        // color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * .15,
            width: Get.width * .26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                    image: AssetImage(Assets.profileImage), fit: BoxFit.cover),
                color: AppColors.yellow2),
          ),
          // 13.horizontalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(13.w, 4.h, 8.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return editUserRolePopUp(context);
                              });
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(3)),
                          child: const Icon(
                            Icons.edit,
                            color: AppColors.blackColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.blackColor,
                    thickness: 0.5,
                  ),
                  2.verticalSpace,
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
                  4.verticalSpace,
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
                  5.verticalSpace,
                  Align(
                      alignment: Alignment.centerRight,
                      child: bidButton(title: 'Delete', onTap: () {})),
                  // Container(
                  //   height: 2,
                  //   width: Get.width,
                  //   decoration: BoxDecoration(
                  //       border: Border(
                  //           top: BorderSide(color: AppColors.blackColor))),
                  // )
                  const Divider(
                    color: AppColors.blackColor,
                    thickness: 0.5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
