import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/profile_controller.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/custom-app-bar.dart';
import 'package:izuahia/screens/PROFILE/Bids/profile-bid-screen.dart';
import 'package:izuahia/screens/PROFILE/Career/career-screen.dart';
import 'package:izuahia/screens/PROFILE/Favorite/favorite-screen.dart';
import 'package:izuahia/screens/PROFILE/Invoices/profile-invoices.dart';
import 'package:izuahia/screens/PROFILE/Negotiaiton/profile-negotiation-screen.dart';
import 'package:izuahia/screens/PROFILE/Receipts/profile-receipts-screen.dart';
import 'package:izuahia/screens/PROFILE/Request/service-hub-request-screen.dart';
import 'package:izuahia/screens/profile/Ordering/ordering_screen.dart';
import 'package:izuahia/screens/profile/Gallery/profile-gallery-screen.dart';
import 'package:izuahia/screens/profile/Settings/select_location_popup.dart';
import 'package:izuahia/screens/profile/Settings/user-profile-settings.dart';
import 'package:izuahia/screens/profile/delivery/delivery_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> list = [
    {
      'asset': Assets.profileCart,
      'title': 'Ordering',
      'type': 'ordering',
    },
    {
      'asset': Assets.profileFav,
      'title': 'Favorites',
      'type': 'fav',
    },
    {
      'asset': Assets.profileCareer,
      'title': 'Career',
      'type': 'career',
    },
    {
      'asset': Assets.profileGallery,
      'title': 'Gallery',
      'type': 'gallery',
    },
    {
      'asset': Assets.profileReq,
      'title': 'Requests',
      'type': 'req',
    },
    {
      'asset': Assets.profileInvoice,
      'title': 'Invoices',
      'type': 'invoice',
    },
    {
      'asset': Assets.profileReceipt,
      'title': 'Receipts',
      'type': 'receipts',
    },
    {
      'asset': Assets.profileNego,
      'title': 'Negotiation',
      'type': 'nego',
    },
    {
      'asset': Assets.profileBid,
      'title': 'Bids',
      'type': 'bid',
    },
    {
      'asset': Assets.truck,
      'title': 'Delivering',
      'type': 'delivering',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Stack(
            children: [
              GetBuilder(
                  init: ProfileController(),
                  builder: (controller) {
                    return Container(
                      alignment: Alignment.topCenter,
                      height: height,
                      width: width,
                      color: AppColors.blackColor,
                      child: const CustomAppBar(),
                    );
                  }),
              Positioned(
                height: height,
                top: height * .18,
                child: Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(top: 12.h, bottom: 220.h),
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          profileHeader(),
                          10.verticalSpace,
                          const Text(
                            'Manage Everything Here ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            itemCount: list.length - 1,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.98,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return profileWidgets(
                                onTap: () {
                                  if (list[index]['type'] == 'ordering') {
                                    Get.to(() => const OrderingScreen());
                                  } else if (list[index]['type'] == 'fav') {
                                    Get.to(() => const FavoriteScreen());
                                  } else if (list[index]['type'] == 'career') {
                                    Get.to(() => const CareerScreen());
                                  } else if (list[index]['type'] == 'req') {
                                    Get.to(() => const RequestScreen());
                                  } else if (list[index]['type'] == 'invoice') {
                                    Get.to(() => const ProfileInvoices());
                                  } else if (list[index]['type'] == 'receipts') {
                                    Get.to(() => const ProfileReceiptScreen());
                                  } else if (list[index]['type'] == 'nego') {
                                    Get.to(() => const ProfileNegotiationScreen());
                                  } else if (list[index]['type'] == 'bid') {
                                    Get.to(() => const ProfileBidScreen());
                                  } else if (list[index]['type'] == 'gallery') {
                                    Get.to(() => const ProfileGalleryScreen());
                                  } else {}
                                },
                                title: list[index]['title'],
                                asset: list[index]['asset'],
                              );
                            },
                          ),
                          Center(
                            child: SizedBox(
                              height: Get.height * .132,
                              width: Get.width * .28,
                              child: profileWidgets(
                                onTap: () {
                                  if (list[list.length - 1]['type'] == 'delivering') {
                                    Get.to(() => const DeliveryScreen());
                                  }
                                },
                                title: list[list.length - 1]['title'],
                                asset: list[list.length - 1]['asset'],
                              ),
                            ),
                          ),
                          80.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget profileHeader() {
    return Container(
      alignment: Alignment.center,
      // height: Get.height * .12,
      width: Get.width,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(color: const Color(0xffFFF1DB), borderRadius: BorderRadius.circular(20)),
      child: GetBuilder(
          init: ProfileController(),
          builder: (profileController) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (SharedPrefs().getString('profile_pic') != null)
                          CircleAvatar(
                            radius: 22,
                            child: Image.network(SharedPrefs().getString('profile_pic')!),
                          ),
                        if (SharedPrefs().getString('profile_pic') == null)
                          const CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(Assets.profileImage),
                          ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                                color: Color(0xff666666),
                              ),
                            ),
                            3.verticalSpace,
                            Text(
                              '${SharedPrefs().getString('first_name')} ${SharedPrefs().getString('last_name')}'
                                      .capitalizeFirst ??
                                  "",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                                color: AppColors.blackColor,
                              ),
                            ),
                            3.verticalSpace,
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Balance",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Color(0xff666666),
                          ),
                        ),
                        3.verticalSpace,
                        Row(
                          children: [
                            Text(
                              "${SharedPrefs().getString('wallet')}",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  color: AppColors.blackColor),
                            ),
                            5.horizontalSpace,
                            Text(
                              '${SharedPrefs().getString('default_currency')}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const UserProfileSettingdScreen());
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Edit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'Montserrat', color: Color(0xff555555), fontWeight: FontWeight.w600),
                          ),
                          4.horizontalSpace,
                          SvgPicture.asset(Assets.profileEdit),
                        ],
                      ),
                    ),
                    10.horizontalSpace,
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => selectDefaultLocationPopup(context),
                        );
                      },
                      child: SizedBox(
                        width: Get.width * .60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                SharedPrefs().getString('default_location') ?? "Location not found",
                                // textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff555555),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            4.horizontalSpace,
                            SvgPicture.asset(Assets.profileEdit),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget profileWidgets({
    required VoidCallback onTap,
    required String title,
    required String asset,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(color: AppColors.grey3.withOpacity(0.5), offset: const Offset(0, 5), blurRadius: 7, spreadRadius: 0)
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(asset),
            10.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Montserrat',
                  color: AppColors.blackColor,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
