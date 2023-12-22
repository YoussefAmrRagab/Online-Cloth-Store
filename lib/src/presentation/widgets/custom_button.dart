import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.height,
      this.icon,
      required this.text,
      required this.color,
      required this.onPressed,
      required this.borderRadius,
      this.fontColor = Colors.white,
      this.fontSize,
      this.isThirdPartyLoginButton = false,
      required this.isLoading,
      required this.circularProgressIndicatorSize});

  final double height;
  final Widget? icon;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final Color fontColor;
  final double? fontSize;
  final bool isThirdPartyLoginButton;
  final bool isLoading;
  final double circularProgressIndicatorSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: isThirdPartyLoginButton
          ? ElevatedButton.icon(
              icon: icon!,
              label: Text(
                text,
                style: TextStyle(
                  color: fontColor,
                  fontSize: fontSize ?? 16,
                ),
              ),
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: color),
                  ),
                ),
              ),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: color),
                  ),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: circularProgressIndicatorSize,
                      height: circularProgressIndicatorSize,
                      child: CircularProgressIndicator(
                        color: fontColor,
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: fontSize ?? 16,
                      ),
                    ),
            ),
    );
  }
}
