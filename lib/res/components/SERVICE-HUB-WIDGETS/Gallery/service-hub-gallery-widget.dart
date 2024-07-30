import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';

class ServiceHubGalleryWidget extends StatefulWidget {
  const ServiceHubGalleryWidget({super.key});

  @override
  State<ServiceHubGalleryWidget> createState() =>
      _ServiceHubGalleryWidgetState();
}

class _ServiceHubGalleryWidgetState extends State<ServiceHubGalleryWidget> {
  final DatePickerController controller = Get.put(DatePickerController());

  List<String> items = [
    Assets.gallery3,
    Assets.gallery2,
    Assets.gallery3,
    Assets.gallery2,
    Assets.gallery2,
    Assets.gallery3,
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;
    return Container(
      height: height * .78,
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
                  height: 1.5,
                ),
              ),
              Text('GALLERY',
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
                  height: 1.5,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
              itemBuilder: (context, index) {
                return _buildGridItem(index, items[index]);
              },
              itemCount: items.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGridItem(int index, String assets) {
    return Container(
      // margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(image: AssetImage(assets), fit: BoxFit.cover),
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
        height: Get.height * .033,
        width: Get.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500)),
            5.horizontalSpace,
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.darkGrey,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
