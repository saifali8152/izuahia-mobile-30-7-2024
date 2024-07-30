import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/salesPoint/booth-item-widget.dart';
import 'package:izuahia/res/dialogs/salesPointDialogs/add-new-sales-point-dialog.dart';

class AddBoothWidget extends StatefulWidget {
  const AddBoothWidget({super.key});

  @override
  State<AddBoothWidget> createState() => _AddBoothWidgetState();
}

class _AddBoothWidgetState extends State<AddBoothWidget> {
  final List<Map<String, dynamic>> list = [
    {'label': 'BOOTH1', 'icon': Assets.booth},
    {'label': 'BOOTH2', 'icon': Assets.booth},
    {'label': 'BOOTH3', 'icon': Assets.booth},
    {'label': 'BOOTH4', 'icon': Assets.booth},
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
          borderRadius: BorderRadius.circular(13),
          color: AppColors.orangeLight),
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
                  return BoothItemWidget(
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
                      label: 'Add New Booth',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return addNewBoothPopUp(context);
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
