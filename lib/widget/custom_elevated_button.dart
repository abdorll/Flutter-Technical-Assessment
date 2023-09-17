import 'package:flutter/material.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/widget/texts.dart';

@immutable
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.borderColor,
      this.textColor,
      this.radius,
      this.size,
      this.enabled,
      this.backgroundColor,
      this.elevation,
      required this.text,
      required this.onTap});

  final String text;
  final VoidCallback onTap;
  final double? radius, elevation;
  final Color? borderColor, textColor, backgroundColor;
  final Size? size;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStatePropertyAll<Color>(enabled == true
                ? AppColors.primaryColor
                : AppColors.disabledprimaryColor)),
        onPressed: enabled == true
            ? () {
                onTap();
              }
            : null,
        child: TextOf(
            text,
            16,
            enabled == true
                ? AppColors.white
                : AppColors.disabledSecondaryColor,
            FontWeight.w700));
  }
}
