import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/delivery-components/components.dart';
import 'package:izuahia/res/components/delivery-components/info_container.dart';



class QuoteRequestsItemWidget extends StatefulWidget {
  final String image;
  final VoidCallback onTap;
  final String title;
  final BuildContext context;

  const QuoteRequestsItemWidget({
    super.key,
    required this.image,
    required this.onTap,
    required this.title,
    required this.context,
  });

  @override
  State<StatefulWidget> createState() => _QuoteRequestsItemWidgetState();
}

class _QuoteRequestsItemWidgetState extends State<QuoteRequestsItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.15),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height * .08,
                width: Get.width * .12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(padding: const EdgeInsets.all(5), child: textsWidget(title: widget.title)),
              ),
            ],
          ),
          Center(
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: 
                    const Text(
                      "Quote",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: SvgPicture.asset(Assets.editIcon),
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            const InfoContainer(
              text: 'Estimated Time of Delivery',
              iconPath: Assets.clock,
            ),
            5.verticalSpace,
            const NoteTextField(),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Quotation",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      5.horizontalSpace,
Container(
      height: Get.height * 0.032,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 20, maxWidth: 30),
        child: TextFormField(
          style: const TextStyle(
            fontSize: 10,
            fontFamily: 'Inter',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: '\$450',
          ),
        ),
      ),
    )
                    ],
                  ),
                  Row(
                    children: [
                      customButton(
                        title: 'Cancel',
                        onTap: () {},
                        bgColor: AppColors.yellow,
                        textColor: AppColors.black01,
                      ),
                      5.horizontalSpace,
                      customButton(title: 'Confirm Delivery', onTap: () {}),
                    ],
                  )
                ],
              ),
            ),
            10.verticalSpace,
          ],
        ],
      ),
    );
  }
}

class DeliveringItemWidget extends StatefulWidget {
  final String image;
  final VoidCallback onTap;
  final String title;
  final BuildContext context;

  const DeliveringItemWidget({
    super.key,
    required this.image,
    required this.onTap,
    required this.title,
    required this.context,
  });

  @override
  State<StatefulWidget> createState() => _DeliveringItemWidgetState();
}

class _DeliveringItemWidgetState extends State<DeliveringItemWidget> {
  bool _isExpanded = false;
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.15),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * .08,
                width: Get.width * .12,
                margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(padding: const EdgeInsets.all(5), child: textsWidget(title: widget.title)),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: const Text(
              "Delivering",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                color: AppColors.yellow,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (_isExpanded) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.grey3, // Set your desired button color here
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownvalue,
                  dropdownColor: AppColors.grey3,
                  elevation: 0,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey2,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customButton(
                    title: 'Cancel',
                    onTap: () {},
                    bgColor: AppColors.yellow,
                    textColor: AppColors.black01,
                  ),
                  5.horizontalSpace,
                  customButton(title: 'Confirm Delivery', onTap: () {}),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}
