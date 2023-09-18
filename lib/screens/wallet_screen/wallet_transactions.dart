// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kooha/model/transaction_data.dart';
import 'package:kooha/providers/transactions_provider.dart';
import 'package:kooha/screens/wallet_screen/wallet_screen.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/widget/back_button.dart';
import 'package:kooha/widget/iconss.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';

class WalletTransactionsPage extends StatefulWidget {
  WalletTransactionsPage({super.key});
  TransactionListProvider transactionListProvider =
      Get.put(TransactionListProvider());

  static const String walletTransactionsPage = "walletTransactionsPage";

  @override
  State<WalletTransactionsPage> createState() => _WalletTransactionsPageState();
}

class _WalletTransactionsPageState extends State<WalletTransactionsPage> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    List<Widget> transactionList = [
      bluePrint(data: widget.transactionListProvider.transactionList),
      bluePrint(
          data: widget.transactionListProvider.transactionList
              .where((v) => v.type.toString().toLowerCase() == "deposit")
              .toList()),
      bluePrint(
          data: widget.transactionListProvider.transactionList
              .where((v) => v.type.toString().toLowerCase() == "withdrawal")
              .toList()),
    ];
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 2,
                child: ExitButton(
                  shoulExit: true,
                ),
              ),
              Expanded(
                flex: 7,
                child: TextOf("Wallet Transactions", 14, AppColors.white,
                    FontWeight.w500),
              ),
              const Expanded(flex: 2, child: SizedBox.shrink())
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tabButton(context, index: 0, width: 0.1, text: "All"),
              tabButton(context,
                  index: 1, width: 0.35, text: "Received", isDeposit: false),
              tabButton(context,
                  index: 2, width: 0.3, text: "Transfer", isDeposit: true),
            ],
          ),
        ),
        const YMargin(20),
        Divider(
          color: AppColors.grey,
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: transactionList,
          ),
        )
      ]),
    ));
  }

  ElevatedButton tabButton(BuildContext context,
      {required int index,
      required double width,
      bool? isDeposit,
      required String text}) {
    return ElevatedButton(
        onPressed: () {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceOut);
        },
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStatePropertyAll<Color>(
                currentIndex == index
                    ? AppColors.secondaryColor
                    : AppColors.deepGrey),
            fixedSize: MaterialStatePropertyAll<Size>(
                Size(MediaQuery.of(context).size.width * width, 40))),
        child: isDeposit == null
            ? TextOf(
                text,
                14,
                currentIndex == index ? AppColors.black : AppColors.grey,
                FontWeight.w500)
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconOf(
                      isDeposit == true
                          ? Icons.north_east_rounded
                          : Icons.south_west_rounded,
                      10,
                      AppColors.grey),
                  const XMargin(3),
                  TextOf(
                      text,
                      14,
                      currentIndex == index ? AppColors.black : AppColors.grey,
                      FontWeight.w500)
                ],
              ));
  }

  static Widget bluePrint({required List<dynamic> data}) {
    // = widget.transactionListProvider.transactionList.where((value) => false).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
                color: AppColors.grey,
              ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            TransactionsData transaction = data[index];
            return transactionInfo(context, transaction: transaction);
          }),
    );
  }
}
