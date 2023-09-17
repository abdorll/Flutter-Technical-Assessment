import 'package:flutter/foundation.dart';

class AppFunction {
  static void prints({required Object message}) {
    if (kDebugMode) {
      print(message);
    }
  }
}
