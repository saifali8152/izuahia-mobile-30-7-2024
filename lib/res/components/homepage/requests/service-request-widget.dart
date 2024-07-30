import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/homepage/requests/services-request-card.dart';
import 'package:izuahia/screens/requestOptions/request-search-screen.dart';

class ServiceRequestWidget extends StatefulWidget {
  final List<HomeRequestModel> requestsList;
  const ServiceRequestWidget({super.key, required this.requestsList});

  @override
  State<ServiceRequestWidget> createState() => _ServiceRequestWidgetState();
}

class _ServiceRequestWidgetState extends State<ServiceRequestWidget> {
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
                'Requests Near You',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black01),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const RequestSearchScreen());
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
                  widget.requestsList.isEmpty
              ? SizedBox(
                  height: Get.height * 0.17,
                  child: const Center(
                    child: Text('No Data Found'),
                  ),
                )
              :
        SizedBox(
          height: Get.height * 0.36,
          child: ListView.builder(
                  itemCount: widget.requestsList.length,
                  padding: const EdgeInsets.only(left: 20),
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return widget.requestsList[index].requestType == 'inventory'
                        ? ServiceRequestCard(
                            asset: widget.requestsList[index].inventoryImages![0],
                            title: widget.requestsList[index].inventoryName!,
                            quantity: widget.requestsList[index].quantity!,
                            description: widget.requestsList[index].description!,
                            requestType: widget.requestsList[index].requestType,
                            irId: widget.requestsList[index].irId!,
                            location: widget.requestsList[index].fullAddress!,
                          )
                        : ServiceRequestCard(
                            asset: widget.requestsList[index].serviceImage!,
                            title: widget.requestsList[index].serviceName!,
                            description: widget.requestsList[index].description!,
                            requestType: widget.requestsList[index].requestType,
                            location: widget.requestsList[index].fullAddress!,
                            srId: widget.requestsList[index].srId,
                          );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildIndicatorRow() {
    List<Widget> indicators = [];
    int start = _currentPage - 1;
    int end = _currentPage + 1;

    // Adjust start and end if the current page is at the start or end of the list
    if (_currentPage == 0) {
      start = _currentPage;
      end = _currentPage + 2;
    } else if (_currentPage == widget.requestsList.length - 1) {
      start = _currentPage - 2;
      end = _currentPage;
    }

    // Ensure start and end are within the bounds of the list
    start = start.clamp(0, widget.requestsList.length - 1);
    end = end.clamp(0, widget.requestsList.length - 1);

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
