import 'package:get/get.dart';

class SliderController extends GetxController {
  var currentPage = 0.obs;

  void changePage(int page) {
    currentPage.value = page;
  }
}
