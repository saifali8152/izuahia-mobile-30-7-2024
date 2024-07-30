import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/controllers/gallery_controller.dart';
import 'package:izuahia/models/gallery_model.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/utils/helper_functions.dart';

class ProfileGalleryScreen extends StatefulWidget {
  const ProfileGalleryScreen({super.key});

  @override
  State<ProfileGalleryScreen> createState() => _ProfileGalleryScreenState();
}

class _ProfileGalleryScreenState extends State<ProfileGalleryScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: height,
        width: width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 50.h),
        child: GetBuilder(
          init: GalleryController(),
          builder: (galleryController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            blurRadius: 3,
                          )
                        ],
                        color: AppColors.yellow),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.blackColor,
                      size: 18,
                    ),
                  ),
                ),
                16.verticalSpace,
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'GALLERY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                12.verticalSpace,
                Expanded(
                  child: galleryController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : galleryController.galleryImagesList.isEmpty
                          ? const Center(child: Text("No Data Found"))
                          : GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                              ),
                              itemCount: galleryController.galleryImagesList.length,
                              itemBuilder: (context, index) {
                                return _buildGridItem(
                                  controller: galleryController,
                                  galleryData: galleryController.galleryImagesList[index],
                                );
                              },
                            ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: customButton(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    height: Get.height * 0.35,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text("Choose an image to upload"),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Upload Photo',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Montserrat',
                                                    color: AppColors.blackColor),
                                              ),
                                              4.verticalSpace,
                                              InkWell(
                                                  onTap: () {
                                                    galleryController.showImageSourceSelectionDialog();
                                                  },
                                                  child: Obx(
                                                    () => Container(
                                                      height: height * .09,
                                                      width: width * .20,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5), color: AppColors.grey3),
                                                      child: galleryController.image != null
                                                          ? Image.file(
                                                              galleryController.image!,
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
                                        ),
                                        10.verticalSpace,
                                        customButton(
                                            onTap: () async {
                                              if (galleryController.image != null && context.mounted) {
                                                HelperFunctions.showLoadingDialogue(context);
                                                await galleryController.addGalleryImage();
                                                if (galleryController.imageAdded.value) {
                                                  await galleryController.getGalleryImages();
                                                }
                                                if (context.mounted) {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                }
                                              }
                                            },
                                            title: "Upload"),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      title: 'Upload Image'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required GalleryData galleryData,
    required GalleryController controller,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 7,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(galleryData.galleryImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: Container(
                          height: Get.height * 0.2,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Are you sure you want to delete this image?"),
                              5.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customButton(
                                      onTap: () async {
                                        HelperFunctions.showLoadingDialogue(context);
                                        await controller.deleteGalleryImage(
                                          userGalleryId: galleryData.ugId,
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      title: "Yes"),
                                  5.horizontalSpace,
                                  customButton(
                                      onTap: () {
                                        Get.back();
                                      },
                                      title: "No"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
            },
            icon: SvgPicture.asset(
              Assets.delete,
              color: AppColors.yellow,
            ),
          ),
        ),
      ],
    );
  }
}

Widget customButton({required VoidCallback onTap, required String title}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * .045,
      width: Get.width * .30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title,
          style: const TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
    ),
  );
}
