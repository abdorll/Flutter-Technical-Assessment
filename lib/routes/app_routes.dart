import 'package:flutter/material.dart';
import 'package:kooha/screens/login_screen/login_screen.dart';
import 'package:kooha/screens/nav_screens/nav_screens.dart';
import 'package:kooha/screens/wallet_screen/wallet_screen.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      LoginScreen.loginScreen => screenOf(screenName: const LoginScreen()),
      NavScreens.navScreens => screenOf(screenName: const NavScreens()),
      WalletScreen.walletScreen => screenOf(screenName: WalletScreen()),
      _ => screenOf(screenName: Container())
    };
  }
}

MaterialPageRoute screenOf({required Widget screenName}) {
  return MaterialPageRoute(builder: (context) => screenName);
}
