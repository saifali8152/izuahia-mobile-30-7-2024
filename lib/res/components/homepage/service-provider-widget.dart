import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/home_page_controller.dart';
import 'package:izuahia/models/service_model.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/service-card.dart';
import 'package:izuahia/res/components/services/services_search_screen.dart';


class ServiceProviderWidget extends StatefulWidget {
  final List<HomeServiceModel> serviceList;
  const ServiceProviderWidget({
    super.key,
    required this.serviceList,
  });

  @override
  State<ServiceProviderWidget> createState() => _ServiceProviderWidgetState();
}

class _ServiceProviderWidgetState extends State<ServiceProviderWidget> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
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
    var itemWidth = MediaQuery.of(context).size.width;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service Providers Near You',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black01),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const ServicesSearchScreen());
                },
                child: const Text(
                  'See More',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Montserrat', color: AppColors.yellow),
                ),
              ),
            ],
          ),
        ),
        8.verticalSpace,
        widget.serviceList.isEmpty
            ? SizedBox(
                height: Get.height * 0.17,
                child: const Center(
                  child: Text('No Data Found'),
                ),
              )
            : SizedBox(
                height: Get.height * 0.37,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  itemCount: widget.serviceList.length,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      serviceModel: widget.serviceList[index],
                    );
                  },
                ),
              ),
        15.verticalSpace,
      ],
    );
  }

  // Widget _buildIndicatorRow() {
  //   List<Widget> indicators = [];
  //   int start = _currentPage - 1;
  //   int end = _currentPage + 1;

  //   if (_currentPage == 0) {
  //     start = _currentPage;
  //     end = _currentPage + 2;
  //   } else if (_currentPage == list.length - 1) {
  //     start = _currentPage - 2;
  //     end = _currentPage;
  //   }

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
