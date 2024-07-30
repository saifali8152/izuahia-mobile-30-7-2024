import 'package:get/get.dart';

class BoothController extends GetxController {
  var boothNumber = 1.obs;
  void nextBooth() {
    boothNumber.value += 1;
  }

  void previousBooth() {
    if (boothNumber.value > 1) {
      boothNumber.value -= 1;
    }
  }
}
