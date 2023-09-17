import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kooha/model/wallet_model.dart';
import 'package:kooha/providers/transactions_provider.dart';
import 'package:kooha/providers/wallet_provider.dart';
import 'package:kooha/utils/application_state.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';

final WalletProvider walletProvider = Get.put(WalletProvider());

class WalletScreen extends StatefulWidget {
  static const String walletScreen = "walletScreen";
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final WalletProvider walletProvider = Get.put(WalletProvider());
  final TransactionListProvider transactionListProvider =
      Get.put(TransactionListProvider());
  @override
  void initState() {
    if (walletProvider.userwallet.value == null) {
      walletProvider.getwallet();
    } else if (transactionListProvider.transactionList.isEmpty) {
      transactionListProvider.getTransactionsData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextOf(
                            "Wallet",
                            24,
                            AppColors.white,
                            FontWeight.w700,
                          ),
                        ],
                      ),
                      const YMargin(20),
                      TextOf(
                          "Balance", 14, AppColors.deepGrey, FontWeight.w700),
                      const YMargin(10),
                      walletProvider.userwallet.value == null
                          ? TextOf(
                              "₦****.00", 32, AppColors.white, FontWeight.w700)
                          : TextOf(
                              "₦ ${walletProvider.userwallet.value!.balance!.toDouble().toString()}",
                              32,
                              AppColors.white,
                              FontWeight.w700),
                      const YMargin(25),
                      ElevatedButton(
                          onPressed: () {},
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  fixedSize: MaterialStatePropertyAll<Size>(
                                      Size(
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                          60))),
                          child: TextOf(
                              "Withraw", 16, AppColors.white, FontWeight.w700)),
                      const YMargin(20),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.deepGrey,
                ),
                YMargin(20),
                // Expanded(
                //     child: ListView.builder(
                //         itemCount:
                //             transactionListProvider.transactionList.length,
                //         itemBuilder: (context, index) {}))
              ],
            ),
          );
        }),
      ),
    );
  }
}
