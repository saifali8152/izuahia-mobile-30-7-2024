import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/salesPoint/sales-point-category-widget.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/add-new-sales-point-dialog.dart';

class SalesPointBusinessWidget extends StatefulWidget {
  const SalesPointBusinessWidget({super.key});

  @override
  State<SalesPointBusinessWidget> createState() =>
      _SalesPointBusinessWidgetState();
}

class _SalesPointBusinessWidgetState extends State<SalesPointBusinessWidget> {
  final List<Map<String, dynamic>> list = [
    {'label': '23', 'icon': Assets.shopIcon},
    {'label': '03', 'icon': Assets.saleIcon},
    {'label': '05', 'icon': Assets.handIcon},
    {'label': '45', 'icon': Assets.icon},
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
                'EZYBROT LIMITED',
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
            height: height * .13,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SalesCategoryWidget(
                      label: list[index]['label'],
                      onTap: () {},
                      asset: list[index]['icon']);
                }),
          ),
          10.verticalSpace,
          _buildIndicatorRow(),
          15.verticalSpace,
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: width * .55,
                  height: height * .045,
                  child: RoundButton(
                      label: 'Add New Sales Point',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return addSalesPointPopUp(context);
                            });
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
