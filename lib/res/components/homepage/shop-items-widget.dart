import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/shop-items-caard.dart';
import 'package:izuahia/screens/salesPointScreens/inventory/sales-point-inventory-search-screen.dart';

class ShopItemsWidget extends StatefulWidget {
  const ShopItemsWidget({super.key, required this.inventoriesList});
  final List<HomeInventoryModel> inventoriesList;

  @override
  State<ShopItemsWidget> createState() => _ShopItemsWidgetState();
}

class _ShopItemsWidgetState extends State<ShopItemsWidget> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    var itemWidth = MediaQuery.of(context).size.width; // Assuming item width equals screen width
    var scrollPosition = _scrollController.position.pixels;
    var newPage = (scrollPosition / itemWidth).round();

    if (newPage != _currentPage) {
      setState(() {
        _currentPage = newPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shop items of your choice',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black01),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const InventorySearchScreen());
                  },
                  child: const Text(
                    'See More',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Montserrat', color: AppColors.yellow),
                  ),
                ),
              ],
            ),
          ),
          // const Text(
          //   'Shop items of your choice',
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.w700,
          //       color: AppColors.black01),
          // ),
          10.verticalSpace,
          // Row(
          //   children: [
          //     searchFieldWidget(
          //         hintText: 'Search',
          //         preffixIcon: const Icon(
          //           Icons.search,
          //           color: AppColors.yellow,
          //         )),
          //     8.horizontalSpace,
          //     GestureDetector(
          //       onTap: () {},
          //       child: Container(
          //         height: 32,
          //         width: 32,
          //         decoration: const BoxDecoration(
          //             shape: BoxShape.circle, color: AppColors.blackColor),
          //         child: Center(
          //             child: SvgPicture.asset(
          //           Assets.filterIcon,
          //           height: 20,
          //         )),
          //       ),
          //     )
          //   ],
          // ),
          widget.inventoriesList.isEmpty
              ? SizedBox(
                  height: Get.height * 0.17,
                  child: const Center(
                    child: Text('No Data Found'),
                  ),
                )
              : SizedBox(
                  height: Get.height * 0.36,
                  child: ListView.builder(
                    itemCount: widget.inventoriesList.length,
                    padding: const EdgeInsets.only(left: 20),
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ShopItemsCard(
                        inventoryModel:  widget.inventoriesList[index],
                      );
                    },
                  ),
                ),
          // 15.verticalSpace,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     const Text(
          //       'Add Your Own Service to Listing',
          //       style: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.w600,
          //           fontFamily: 'Montserrat',
          //           color: AppColors.blackColor),
          //     ),
          //     12.horizontalSpace,
          //     addButton(
          //       onTap: () {},
          //     )
          //   ],
          // ),
          // 20.verticalSpace,
          // _buildIndicatorRow()
        ],
      );
    });
  }

  // Widget _buildIndicatorRow() {
  //   List<Widget> indicators = [];
  //   int start = _currentPage - 1;
  //   int end = _currentPage + 1;

  //   // Adjust start and end if the current page is at the start or end of the list
  //   if (_currentPage == 0) {
  //     start = _currentPage;
  //     end = _currentPage + 2;
  //   } else if (_currentPage == list.length - 1) {
  //     start = _currentPage - 2;
  //     end = _currentPage;
  //   }

  //   // Ensure start and end are within the bounds of the list
  //   start = start.clamp(0, list.length - 1);
  //   end = end.clamp(0, list.length - 1);

  //   for (int i = start; i <= end; i++) {
  //     indicators.add(_buildPageIndicator(i == _currentPage));
  //   }

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: indicators,
  //   );
  // }
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
