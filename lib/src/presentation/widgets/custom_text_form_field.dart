import 'package:flutter/material.dart';

import '../../util/resources/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.borderColor,
      this.isPasswordField = false,
      this.suffixIcon,
      this.isDatePickerField = false,
      required this.iconColor,
      this.controller,
      this.onTap,
      this.onSuffixIconTap,
      this.isNumericKeyboardType = false,
      this.enableInteractiveSelection = true,
      this.height,
      this.width});

  final String hintText;
  final Color iconColor;
  final Color borderColor;
  final bool isPasswordField;
  final bool isDatePickerField;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool isNumericKeyboardType;
  final bool enableInteractiveSelection;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        keyboardType: isNumericKeyboardType ? TextInputType.number : null,
        onTap: onTap,
        controller: controller,
        readOnly: isDatePickerField,
        obscureText: isPasswordField,
        enableInteractiveSelection: enableInteractiveSelection,
        style: TextStyle(color: ColorManager.blackColor),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            color: ColorManager.greyColor,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onSuffixIconTap, icon: suffixIcon!)
              : null,
          suffixIconColor: iconColor,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
