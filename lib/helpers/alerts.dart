import 'package:bot_toast/bot_toast.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/widget/texts.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum AlertType { FAILED, SUCCESS, INFO }

class Alerts {
  static showAlert(
      {required String text,
      IconData? icon,
      Widget? anotherWidget,
      required AlertType alertType}) {
    return BotToast.showNotification(
        backgroundColor: alertType == AlertType.FAILED
            ? AppColors.red
            : alertType == AlertType.INFO
                ? Colors.blue.shade300
                :AppColors.green,
        title: (_) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextOf(
                  text,
                  11,
                  Colors.white,
                  FontWeight.w500,
                  align: TextAlign.left,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              anotherWidget ?? const SizedBox.shrink()
            ],
          );
        },
        duration: const Duration(seconds: 2),
        trailing: (_) {
          return const SizedBox.shrink();
        });
  }

  static loading() {
    BotToast.showLoading();
    // BotToast.showCustomLoading(toastBuilder: (action) {
    //   return Center(
    //     child: SizedBox.square(
    //       dimension: 90,
    //       child: Container(
    //         decoration: BoxDecoration(
    //             border: Border.all(color: white),
    //             borderRadius: BorderRadius.circular(30),
    //             color: grey.withOpacity(0.6)),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const YMargin(5),
    //             CircularProgressIndicator(
    //               backgroundColor: white,
    //               color: primaryColor,
    //             ),
    //             const YMargin(10),
    //             TextOf('Redirecting...', 9, white, FontWeight.w400),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }

  static close() {
    BotToast.closeAllLoading();
  }
}
