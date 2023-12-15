import 'package:flutter/material.dart';
import 'color_picker.dart';

class CommonTextField {
  Padding commonTextField(controller, labelName,
      {maxLine, onTap, keyboardType, readOnly}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          readOnly: readOnly ?? false,
          maxLines: maxLine,
          keyboardType: keyboardType,
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorPicker.kPrimaryBlue, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorPicker.kPrimaryBlue, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorPicker.kPrimaryBlue, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorPicker.kRed, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorPicker.kPrimaryBlue,
                width: 1,
              ),
            ),
            labelText: "$labelName",
            labelStyle: TextStyle(color: ColorPicker.kGrey),
          ),
        ),
      ),
    );
  }
}
