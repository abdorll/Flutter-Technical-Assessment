import 'package:flutter/material.dart';
import 'package:kooha/screens/nav_screens/nav_screens.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/utils/images.dart';
import 'package:kooha/widget/custom_elevated_button.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';

class TransactionReported extends StatelessWidget {
  static const String transactionReported = "transactionReported";
  const TransactionReported({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          children: [
            //transactionReported
            Expanded(
                flex: 9,
                child: Column(
                  children: [
                    YMargin(MediaQuery.of(context).size.height * 0.05),
                    Image.asset(
                      ImageOf.transactionReported,
                      height: 300,
                    ),
                    TextOf("Transaction\nSuccessfully Reported", 24,
                        AppColors.secondaryColor, FontWeight.w700),
                    YMargin(10),
                    TextOf(
                        " Your report has been received and\nis under careful review.",
                        14,
                        AppColors.deepGrey,
                        FontWeight.w500)
                  ],
                )),

            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                        enabled: true,
                        text: "Back to home",
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, NavScreens.navScreens, (route) => false);
                        }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
