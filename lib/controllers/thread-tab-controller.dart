import 'package:get/get.dart';

class ThreadTabController extends GetxController {
  var currentIndex = 0.obs;

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
