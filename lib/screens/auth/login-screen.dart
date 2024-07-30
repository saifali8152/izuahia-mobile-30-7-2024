import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/login-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-field-widget.dart';
import 'package:izuahia/screens/auth/sign-up-screen.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder(
        init: LoginController(),
        builder: (loginController) {
          return Form(
            key: loginController.signinFormKey,
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(color: AppColors.blackColor),
              child: Column(
                children: [
                  100.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.off( CustomBottomScreen());
                    },
                    child: Transform.scale(
                      scale: 0.8,
                      child: Image.asset(
                        Assets.appLogo,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: Container(
                      height: height,
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                        child: Column(
                          children: [
                            const Text(
                              'LOG IN',
                              style: TextStyle(fontSize: 24, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                            ),
                            10.verticalSpace,
                            customTextFieldWidget(
                                hintText: 'Email',
                                controller: loginController.emailController,
                                                          keyboardType: TextInputType.emailAddress,

                                preffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      Assets.user,
                                      height: 25,
                                    ),
                                  ),
                                ),
                                onValidator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter Email';
                                  } else if (!val.isEmail) {
                                    return 'please enter a valid email address';
                                  }
                                  return null;
                                }),
                            10.verticalSpace,
                            customTextFieldWidget(
                                hintText: 'Password',
                                controller: loginController.passController,
                                obscureText: true,
                                preffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      Assets.lock,
                                      height: 25,
                                    ),
                                  ),
                                ),
                                onValidator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                }),
                            15.verticalSpace,
                            RoundButton(
                              label: 'Login',
                              onPressed: () async {
                                if (loginController.signinFormKey!.currentState!.validate()) {
                                  HelperFunctions.showLoadingDialogue(context);

                                  await loginController.login();
                                }
                              },
                            ),
                            15.verticalSpace,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.grey2,
                                    thickness: 1,
                                    indent: 30,
                                    endIndent: 15,
                                  ),
                                ),
                                Text(
                                  'or sign in using',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      color: AppColors.grey2,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(child: Divider(color: AppColors.grey2, thickness: 1, endIndent: 30, indent: 15)),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            googleButton(),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don’t have an account?',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      color: AppColors.grey2,
                                      fontWeight: FontWeight.w600),
                                ),
                                4.horizontalSpace,
                                TextButton(
                                  onPressed: () {
                                    Get.off(() => const SignUpScreen());
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget googleButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: Container(
          height: 40,
          width: 190,
          decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(10), boxShadow: [
            BoxShadow(color: AppColors.blackColor.withOpacity(0.25), blurRadius: 3, spreadRadius: 0, offset: Offset(0, 3))
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(Assets.google),
              Text(
                'Sign with Google',
                style:
                    TextStyle(fontSize: 14, color: AppColors.blackColor, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
