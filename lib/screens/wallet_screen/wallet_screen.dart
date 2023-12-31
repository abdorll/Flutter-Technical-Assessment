import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kooha/model/transaction_data.dart';
import 'package:kooha/providers/transactions_provider.dart';
import 'package:kooha/providers/wallet_provider.dart';
import 'package:kooha/screens/wallet_screen/transaction_summary.dart';
import 'package:kooha/screens/wallet_screen/wallet_transactions.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/utils/constants.dart';
import 'package:kooha/utils/functions.dart';
import 'package:kooha/utils/images.dart';
import 'package:kooha/widget/iconss.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';
  final TransactionListProvider transactionListProvider =
      Get.put(TransactionListProvider());
final WalletProvider walletProvider = Get.put(WalletProvider());

class WalletScreen extends StatefulWidget {
  static const String walletScreen = "walletScreen";
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final WalletProvider walletProvider = Get.put(WalletProvider());


  BouncingScrollPhysics scrollPhysics = const BouncingScrollPhysics();
  @override
  void initState() {
    transactionListProvider.getTransactionsData();
    if (walletProvider.userwallet.value == null) {
      walletProvider.getwallet();
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
            child: RefreshIndicator(
              backgroundColor: AppColors.white,
              color: AppColors.primaryColor,
              onRefresh: () {
                return reloader();
              },
              child: SingleChildScrollView(
                physics: scrollPhysics,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: SingleChildScrollView(
                        physics: scrollPhysics,
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
                            TextOf("Balance", 14, AppColors.deepGrey,
                                FontWeight.w700),
                            const YMargin(10),
                            walletProvider.userwallet.value == null
                                ? TextOf("₦ 0.00", 32, AppColors.white,
                                    FontWeight.w700)
                                : TextOf(
                                    "₦ ${walletProvider.userwallet.value!.balance!.toDouble().toStringAsFixed(2).toString()}",
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
                                        fixedSize:
                                            MaterialStatePropertyAll<Size>(Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                60))),
                                child: TextOf("Withraw", 16, AppColors.white,
                                    FontWeight.w700)),
                            const YMargin(20),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.grey,
                    ),
                    const YMargin(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextOf("Transactions", 14, AppColors.deepGrey,
                                  FontWeight.w500),
                              const XMargin(2),
                              IconOf(Icons.arrow_downward_outlined, 15,
                                  AppColors.deepGrey)
                            ],
                          ),
                          transactionListProvider.transactionList.isEmpty
                              ? const SizedBox.shrink()
                              : InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        WalletTransactionsPage
                                            .walletTransactionsPage);
                                  },
                                  child: TextOf(
                                      "See all",
                                      16,
                                      AppColors.secondaryColor,
                                      FontWeight.w700),
                                ),
                        ],
                      ),
                    ),
                    const YMargin(10),
                    transactionListProvider.transactionList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageOf.emptyTransaction,
                                height: 150,
                              ),
                              const YMargin(20),
                              TextOf("No withdrawal\nhistory recorded yet", 14,
                                  AppColors.deepGrey, FontWeight.w700)
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(
                                      color: AppColors.grey,
                                    ),
                                itemCount: transactionListProvider
                                    .transactionList.length,
                                itemBuilder: (context, index) {
                                  TransactionsData transaction =
                                      transactionListProvider
                                          .transactionList[index];
                                  return transactionInfo(context,
                                      transaction: transaction);
                                }),
                          )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }




  
}

transactionInfo(BuildContext context, {required TransactionsData transaction}) {
  bool isDeposit() {
    return transaction.type!.toLowerCase() == "deposit";
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pushNamed(
                context, TransactionSummaryScreen.transactionSummaryScreen,
                arguments: transaction);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 23,
                      backgroundColor: isDeposit()
                          ? const Color(0xff553902)
                          : AppColors.grey,
                      child: isDeposit()
                          ? IconOf(Icons.north_east_rounded, 20,
                              AppColors.secondaryColor)
                          : IconOf(Icons.south_west_rounded, 20,
                              AppColors.deepGrey)),
                  const XMargin(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextOf(
                          isDeposit() == true
                              ? "Transfer to Bank"
                              : "Received from Escrow",
                          14,
                          AppColors.white,
                          FontWeight.w700),
                      const YMargin(5),
                      TextOf(
                          "Processed", 12, AppColors.deepGrey, FontWeight.w500),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextOf(
                      "${Constants.CURRENCY} ${transaction.amount!.toString()}",
                      14,
                      AppColors.white,
                      FontWeight.w700),
                  const YMargin(5),
                  TextOf(
                      AppFunction.dateFormatter(
                          dateString: transaction.createdAt!),
                      12,
                      AppColors.deepGrey,
                      FontWeight.w500),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}


Future reloader() async {
    transactionListProvider.getTransactionsData();
    walletProvider.getwallet();
  }