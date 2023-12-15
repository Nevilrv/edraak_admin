import 'package:edraak_admin/utils/color_picker.dart';
import 'package:flutter/material.dart';

class CommonButton {
  Widget bSquareRoundBorderPrimaryBlueButton(BuildContext context,
      {required Widget title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorPicker.kPrimaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: title,
        ),
      ),
    );
  }
}
