import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izuahia/controllers/bottom-navbar-controller.dart';
import 'package:izuahia/controllers/search_screen_controller.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/delivery-components/components.dart';
import 'package:izuahia/screens/auth/login-screen.dart';
import 'package:izuahia/screens/auth/sign-up-screen.dart';
import 'package:izuahia/screens/notification/notification-screen.dart';
import 'package:izuahia/screens/search/search_screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    BottomNavigationController bottomNavigationController = Get.put(BottomNavigationController());
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 15, 0),
      child: GetBuilder(
          init: SearchScreenController(),
          builder: (searchScreenController) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.appLogo,
                  scale: 3.5,
                ),
                Row(
                  children: !HelperFunctions.isLoggedIn
                      ? [
                          customButton(
                            title: 'Login',
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            },
                            bgColor: AppColors.yellow,
                            textColor: AppColors.black01,
                          ),
                          10.horizontalSpace,
                          customButton(
                            title: "Sign Up",
                            onTap: () {
                              Get.to(() => const SignUpScreen());
                            },
                            bgColor: AppColors.yellow,
                            textColor: AppColors.black01,
                          ),
                        ]
                      : [
                          Visibility(
                            visible: searchScreenController.isSearchActive.value,
                            child: InkWell(
                              onTap: () {
                                searchScreenController.toggleSearch();
                              },
                              child: SvgPicture.asset(
                                Assets.search,
                                height: 28,
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Visibility(
                            visible: searchScreenController.isSearchActive.value,
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => const NotificationScreen());
                                },
                                child: SvgPicture.asset(
                                  Assets.notificationIcon,
                                  height: 28,
                                ),
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Visibility(
                            visible: searchScreenController.isSearchActive.value,
                            child: GestureDetector(
                              onTap: () async {
                                _showProfileMenu(context, bottomNavigationController);
                              },
                              child: SharedPrefs().getString('profile_pic') != null
                                  ? CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(SharedPrefs().getString('profile_pic')!),
                                    )
                                  : const CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(Assets.profileImage),
                                    ),
                            ),
                          ),
                          Visibility(
                              visible: !searchScreenController.isSearchActive.value,
                              child: searchField(searchScreenController: searchScreenController)),
                        ],
                )
              ],
            );
          }),
    );
  }

  void _showProfileMenu(BuildContext context, BottomNavigationController controller) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 110, 30, 0),
      items: [
        PopupMenuItem(
          child: customButton(
            title: 'Profile',
            onTap: () {
              controller.setCurrentIndex = 3;
              Get.back();
            },
            bgColor: AppColors.yellow,
            textColor: AppColors.black01,
          ),
        ),
        PopupMenuItem(
          child: customButton(
            title: 'Logout',
            onTap: () async {
              HelperFunctions.showLoadingDialogue(context);
              await HelperFunctions.toggleIsLoggedIn();
              Get.offAll(() => const LoginScreen());
            },
            bgColor: AppColors.yellow,
            textColor: AppColors.black01,
          ),
        ),
      ],
    );
  }

  Widget searchField({
    required SearchScreenController searchScreenController,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 180.w,
          height: 27.h,
          child: TextField(
            controller: searchScreenController.serchStringController,
            autofocus: true,
            style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.whiteColor),
            onSubmitted: (value) async {
              Get.to(() => const SearchScreen());
              searchScreenController.toggleSearch();
              await searchScreenController.getSearchData();
              searchScreenController.serchStringController.clear();
            },
            decoration: searhcFieldDecoration,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            if (Get.currentRoute != '/SearchScreen') {
              Get.to(() => const SearchScreen());
            }
            searchScreenController.toggleSearch();
            await searchScreenController.getSearchData();
            searchScreenController.serchStringController.clear();
          },
          color: AppColors.whiteColor,
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: searchScreenController.toggleSearch,
          color: AppColors.whiteColor,
        ),
      ],
    );
  }

  InputDecoration searhcFieldDecoration = InputDecoration(
    hintText: 'Search...',
    contentPadding: const EdgeInsets.only(left: 20),
    hintStyle: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.whiteColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: const BorderSide(color: AppColors.yellow, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: const BorderSide(color: AppColors.yellow, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: const BorderSide(color: AppColors.yellow, width: 1),
    ),
  );
}
