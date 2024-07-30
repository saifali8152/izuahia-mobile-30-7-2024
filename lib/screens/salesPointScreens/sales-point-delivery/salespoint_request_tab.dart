import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/date-picker-controller.dart';
import 'package:izuahia/res/assets.dart';

import '../../../res/components/delivery-components/item_widget.dart';

class SalesPointDeliveryRequestsTab extends StatefulWidget {
  const SalesPointDeliveryRequestsTab({super.key});

  @override
  State<SalesPointDeliveryRequestsTab> createState() => _SalesPointDeliveryRequestsTabState();
}

class _SalesPointDeliveryRequestsTabState extends State<SalesPointDeliveryRequestsTab> {
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 100.h),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return index.isOdd
              ? QuoteRequestsItemWidget(
                  onTap: () {},
                  image: Assets.iPhone,
                  context: context,
                  title: "iPhone14 Pro Max Delivery",
                )
              : DeliveringItemWidget(
                  onTap: () {},
                  image: Assets.iPhone,
                  context: context,
                  title: "iPhone14 Pro Max Delivery",
                );
        },
      ),
    );
  }
}
