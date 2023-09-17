// ignore_for_file: depend_on_referenced_packages

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:kooha/routes/app_routes.dart';
import 'package:kooha/screens/nav_screens/nav_screens.dart';
import 'package:kooha/screens/wallet_screen/wallet_transactions.dart';
import 'package:kooha/theme/app_theme.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox(Constants.USER_BOX);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      darkTheme: AppTheme.darkTheme,
      builder: (context, child) {
        return botToastBuilder(context, child);
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      themeMode: ThemeMode.dark,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      //initialRoute: LoginScreen.loginScreen,
      // initialRoute: WalletTransactionsPage.walletTransactionsPage,
      initialRoute: NavScreens.navScreens,
    );
  }
}
