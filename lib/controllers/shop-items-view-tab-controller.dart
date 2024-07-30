import 'package:get/get.dart';

class ShopItemTabController extends GetxController {
  RxInt currentIndex = RxInt(0);

  set setCurrentIndex(int val) {
    currentIndex.value = val;
    update();
  }
}
