import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppFunction {
  static void prints({required Object message}) {
    if (kDebugMode) {
      print(message);
    }
  }

  static String dateTimeFunction({required String dateString}) {
    DateTime dateTime = DateTime.parse(dateString);
    final DateTime dtToday = DateTime.now();
    final DateTime dtYesterday =
        DateTime.now().subtract(const Duration(days: 1));
    final DateFormat formatter = DateFormat("dd-MM-yyyy");

    return formatter.format(dateTime) == formatter.format(dtToday)
        ? "Today"
        : formatter.format(dateTime) == formatter.format(dtYesterday)
            ? "Yesterday"
            : DateFormat.yMMMMd().format(DateTime.parse(dateString)).toString();
  }
}
