import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/sign-up-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/currency_drop_down.dart';
import 'package:izuahia/res/components/text-fields/text-field-widget.dart';
import 'package:izuahia/screens/auth/login-screen.dart';
import 'package:izuahia/screens/custom-bottom-screen.dart';
import 'package:izuahia/utils/helper_functions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true, splitScreenMode: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.blackColor,
      body: GetBuilder(
        init: SignupController(),
        builder: (signUpController) {
          return SingleChildScrollView(
            child: Form(
              key: signUpController.signupFormKey,
              child:
                  // true ? SizedBox() :
                  Column(
                children: [
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      Get.off(CustomBottomScreen());
                    },
                    child: Transform.scale(
                      scale: 0.5,
                      child: Image.asset(
                        Assets.appLogo,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
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
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                      child: Column(
                        children: [
                          const Text(
                            'SIGN UP',
                            style: TextStyle(fontSize: 24, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 20.h),
                          customTextFieldWidget(
                            controller: signUpController.nameController,
                            hintText: 'First name',
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          customTextFieldWidget(
                            controller: signUpController.lastnameController,
                            hintText: 'Last name',
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          customTextFieldWidget(
                            controller: signUpController.emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                return 'email is required';
                              } else if (!value.isEmail) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          customTextFieldWidget(
                            controller: signUpController.passController,
                            hintText: 'Password',
                            obscureText: true,
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          customTextFieldWidget(
                            controller: signUpController.confirmPassController,
                            obscureText: true,
                            hintText: 'Confirm Password',
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm password is required';
                              } else if (signUpController.passController!.text != value) {
                                return 'passwords do not match';
                              }
                              return null;
                            },
                          ),
                          // SizedBox(height: 12.h),
                          // const Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "Select Default Currency: ",
                          //     style: TextStyle(fontSize: 14, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                          //   ),
                          // ),
                          SizedBox(height: 12.h),
                          CurrencyDropdownButton(
                            hintText: "Select Default Currency",
                            items: const ['USD', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD', 'CHF', 'CNY', 'SEK', 'NZD'],
                            controller: signUpController.currencyController!,
                            validator: (value) {
                              log("pado");
                              if (value ==null || value.isEmpty) {
                                return "Currency is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          RoundButton(
                            label: 'Create Account',
                            onPressed: () async {
                              if (signUpController.signupFormKey!.currentState!.validate()) {
                                HelperFunctions.showLoadingDialogue(context);

                                await signUpController.signup();
                              }
                            },
                          ),
                          SizedBox(height: 15.h),
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
                                    fontSize: 14, fontFamily: 'Montserrat', color: AppColors.grey2, fontWeight: FontWeight.w600),
                              ),
                              Expanded(child: Divider(color: AppColors.grey2, thickness: 1, endIndent: 30, indent: 15)),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          googleButton(),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'Montserrat', color: AppColors.grey2, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4.h),
                              TextButton(
                                onPressed: () {
                                  Get.off(() => const LoginScreen());
                                },
                                child: const Text(
                                  'Sign In',
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
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          width: 210,
          decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(10), boxShadow: [
            BoxShadow(color: AppColors.blackColor.withOpacity(0.25), blurRadius: 3, spreadRadius: 0, offset: Offset(0, 3))
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(Assets.google),
              Text(
                'Sign-up with Google',
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
