import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';

class ServiceHubWorkWaveWidget extends StatefulWidget {
  const ServiceHubWorkWaveWidget({super.key});

  @override
  State<ServiceHubWorkWaveWidget> createState() =>
      _ServiceHubWorkWaveWidgetState();
}

class _ServiceHubWorkWaveWidgetState extends State<ServiceHubWorkWaveWidget> {
  final List<Map<String, dynamic>> list = [
    {'label': '23', 'title': 'Booth Counter', 'icon': Assets.shopIcon},
    {'label': '05', 'title': 'Bids and Negotiation', 'icon': Assets.handIcon},
    {'label': '45', 'title': 'Work Force', 'icon': Assets.icon},
  ];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      // height: height * .32,
      constraints: BoxConstraints(minHeight: height * .35),
      width: width,
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: const Color(0xffEFCEA8)),
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
          20.verticalSpace,
          SizedBox(
            height: height * .15,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return WorkWaveWidget(
                    label: list[index]['label'],
                    onTap: () {},
                    asset: list[index]['icon'],
                    title: list[index]['title'],
                  );
                }),
          ),
          10.verticalSpace,
          _buildIndicatorRow(),
          15.verticalSpace,
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: width * .45,
                  height: height * .045,
                  child: RoundButton(
                      label: 'Add New Hub',
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return addSalesPointPopUp(context);
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

class WorkWaveWidget extends StatefulWidget {
  final String label;
  final String title;
  final VoidCallback onTap;
  final String asset;
  const WorkWaveWidget(
      {super.key,
      required this.label,
      required this.onTap,
      required this.asset,
      required this.title});

  @override
  State<WorkWaveWidget> createState() => _WorkWaveWidgetState();
}

class _WorkWaveWidgetState extends State<WorkWaveWidget> {
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
            Column(
              children: [
                Container(
                  height: height * .032,
                  width: width * .27,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      )),
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  height: height * .085,
                  width: width * .27,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            color: AppColors.grey2.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 4)
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      )),
                  child: Transform.scale(
                    scale: 0.7,
                    child: SvgPicture.asset(
                      widget.asset,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
            // 3.verticalSpace,
            // Text(
            //   widget.title,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(
            //       fontSize: 10,
            //       fontFamily: 'Inter',
            //       color: AppColors.blackColor,
            //       fontWeight: FontWeight.w700),
            // ),
          ],
        ),
      ),
    );
  }
}
