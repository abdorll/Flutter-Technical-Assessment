import 'package:flutter/material.dart';
import 'package:kooha/model/transaction_data.dart';
import 'package:kooha/screens/login_screen/login_screen.dart';
import 'package:kooha/screens/nav_screens/nav_screens.dart';
import 'package:kooha/screens/wallet_screen/report_transaction.dart';
import 'package:kooha/screens/wallet_screen/transaction_summary.dart';
import 'package:kooha/screens/wallet_screen/wallet_screen.dart';
import 'package:kooha/screens/wallet_screen/wallet_transactions.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    var argument = settings.arguments;
    return switch (settings.name) {
      LoginScreen.loginScreen => screenOf(screenName: const LoginScreen()),
      NavScreens.navScreens => screenOf(screenName: const NavScreens()),
      WalletScreen.walletScreen => screenOf(screenName: const WalletScreen()),
      WalletTransactionsPage.walletTransactionsPage =>
        screenOf(screenName: WalletTransactionsPage()),
      TransactionSummaryScreen.transactionSummaryScreen => screenOf(
            screenName: TransactionSummaryScreen(
          transactionData: argument as TransactionsData,
        )),
      TransactionReported.transactionReported =>
        screenOf(screenName: const TransactionReported()),
      _ => screenOf(screenName: Container())
    };
  }
}

MaterialPageRoute screenOf({required Widget screenName}) {
  return MaterialPageRoute(builder: (context) => screenName);
}
