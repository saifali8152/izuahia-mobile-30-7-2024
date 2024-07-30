import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt counter = 0.obs;

  void increment() {
    counter.value++;
    update();
  }

  void decrement() {
    counter.value--;
    update();
  }
}
