import 'package:get/get.dart';

class OffStageController extends GetxController {
  RxBool isMenuOpen = true.obs;

  void isOpenMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }
}
