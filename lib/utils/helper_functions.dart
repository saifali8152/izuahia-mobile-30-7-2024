import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';

class HelperFunctions {
  static bool get isLoggedIn => SharedPrefs().getBool('isLoggedIn') ?? false;

  static Future<void> toggleIsLoggedIn() async {
    await SharedPrefs().setBool('isLoggedIn', !isLoggedIn);
    final logged = SharedPrefs().getBool('isLoggedIn');
    log('is logged in: $logged and $isLoggedIn');
  }

  static void showSnackBar({required String title, required String msg, int durationInSeconds = 3}) {
    Get.snackbar(
      title,
      msg,
      duration: Duration(seconds: durationInSeconds),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      colorText: Colors.black,
      margin: const EdgeInsets.all(10),
    );
  }

  static void showLoadingDialogue(BuildContext context) {
    Get.closeAllSnackbars();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        onPopInvoked: (didPop) {},
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  static Future<String> showDatePickerDialogue(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate; // Update selected date
    }
    return DateFormat('yyyy-MM-dd').format(selectedDate);
  }
}
