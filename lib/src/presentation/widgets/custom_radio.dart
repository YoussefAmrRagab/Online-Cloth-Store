import '../../util/resources/colors.dart';

import '../../util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final String text;
  final ValueChanged<String> onChanged;

  const CustomRadio(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: (context.screenWidth / 2) - (context.screenWidth / 16 + 5),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: value == groupValue
              ? Border.all(color: ColorManager.brownColor)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: value == groupValue
                    ? ColorManager.brownColor
                    : ColorManager.blackColor),
          ),
        ),
      ),
    );
  }
}
