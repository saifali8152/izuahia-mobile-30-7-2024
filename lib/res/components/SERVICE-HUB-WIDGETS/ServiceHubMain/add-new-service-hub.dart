import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';

class AddNewServiceWidget extends StatefulWidget {
  const AddNewServiceWidget({super.key});

  @override
  State<AddNewServiceWidget> createState() => _AddNewServiceWidgetState();
}

class _AddNewServiceWidgetState extends State<AddNewServiceWidget> {
  final List<Map<String, dynamic>> list = [
    {'label': 'LEGAL ADVICE', 'icon': Assets.booth},
    {'label': 'CONSULTING', 'icon': Assets.booth},
    {'label': 'MANAGEMENT', 'icon': Assets.booth},
    // {'label': 'BOOTH4', 'icon': Assets.booth},
  ];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .2),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13), color: Color(0xffF5DD9F)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .13,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ServiceWidget(
                      label: list[index]['label'],
                      onTap: () {},
                      asset: list[index]['icon']);
                }),
          ),
          10.verticalSpace,
          _buildIndicatorRow(),
          20.verticalSpace,
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: width * .5,
                  height: height * .045,
                  child: RoundButton(
                      label: 'Add New Service',
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return addNewBoothPopUp(context);
                        //     });
                      }))),
        ],
      ),
    );
  }

  Widget _buildIndicatorRow() {
    List<Widget> indicators = [];
    int start = _currentPage - 1;
    int end = _currentPage + 1;

    if (_currentPage == 0) {
      start = _currentPage;
      end = _currentPage + 2;
    } else if (_currentPage == list.length - 1) {
      start = _currentPage - 2;
      end = _currentPage;
    }

    start = start.clamp(0, list.length - 1);
    end = end.clamp(0, list.length - 1);

    for (int i = start; i <= end; i++) {
      indicators.add(_buildPageIndicator(i == _currentPage));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}

Widget _buildPageIndicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    height: 5.0,
    width: isActive ? 40.0 : 40.0,
    decoration: BoxDecoration(
      color: isActive ? AppColors.yellow : AppColors.grey2,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class ServiceWidget extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final String asset;
  const ServiceWidget(
      {super.key,
      required this.label,
      required this.onTap,
      required this.asset});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              height: height * .085,
              width: width * .28,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  )),
              child: SvgPicture.asset(
                widget.asset,
                height: 25,
              ),
            ),
            Container(
              height: height * .032,
              width: width * .28,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  )),
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
