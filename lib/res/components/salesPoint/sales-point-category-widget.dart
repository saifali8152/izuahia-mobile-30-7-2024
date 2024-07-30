import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izuahia/res/colors.dart';

class SalesCategoryWidget extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final String asset;
  const SalesCategoryWidget(
      {super.key,
      required this.label,
      required this.onTap,
      required this.asset});

  @override
  State<SalesCategoryWidget> createState() => _SalesCategoryWidgetState();
}

class _SalesCategoryWidgetState extends State<SalesCategoryWidget> {
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
              height: height * .032,
              width: width * .22,
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
              height: height * .078,
              width: width * .22,
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
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
