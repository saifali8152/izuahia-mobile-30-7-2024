import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs; // Observe the selected date

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate; // Update selected date
    }
  }

  void setDateFromString(String dateString) {
    if (dateString.isNotEmpty) {
      selectedDate.value = DateTime.parse(dateString);
    } else {
      selectedDate.value = DateTime.now();
    }
  }
}
