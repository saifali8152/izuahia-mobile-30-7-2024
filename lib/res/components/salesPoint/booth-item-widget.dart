import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izuahia/res/colors.dart';

class BoothItemWidget extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final String asset;
  const BoothItemWidget(
      {super.key,
      required this.label,
      required this.onTap,
      required this.asset});

  @override
  State<BoothItemWidget> createState() => _BoothItemWidgetState();
}

class _BoothItemWidgetState extends State<BoothItemWidget> {
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
