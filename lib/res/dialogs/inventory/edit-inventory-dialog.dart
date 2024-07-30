//***** ADD NEW INVENTORY POINT *****/
import 'package:flutter/material.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/dialogs/inventory/edit-inventory-screen.dart';

Widget editInventoryPopUp(BuildContext context) {
  return const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.whiteColor,
      child: EditInventory());
}
