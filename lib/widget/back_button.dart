import 'package:flutter/material.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/utils/images.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    this.shoulExit = false,
    this.iconName,
    super.key,
  });
  final String? iconName;
  final bool? shoulExit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        shoulExit == true ? Navigator.pop(context) : () {};
      },
      child: CircleAvatar(
        radius: 23,
        backgroundColor: AppColors.grey,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.scaffoldBackgroundColor,
          child: Image.asset(
            iconName ?? ImageOf.arrowLeft,
            height: 20,
          ),
        ),
      ),
    );
  }
}
