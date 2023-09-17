import 'package:flutter/material.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/widget/texts.dart';

@immutable
class OtherNavScreens extends StatelessWidget {
  const OtherNavScreens({required this.screenName, super.key});
  final String screenName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextOf(
              "$screenName Screen",
              20,
              AppColors.white,
              FontWeight.w600,
            ),
            TextOf(
              "Not available yet!",
              10,
              AppColors.white,
              FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
