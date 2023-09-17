// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kooha/helpers/alerts.dart';
import 'package:kooha/model/transaction_data.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/utils/constants.dart';
import 'package:kooha/utils/functions.dart';
import 'package:kooha/utils/images.dart';
import 'package:kooha/widget/back_button.dart';
import 'package:kooha/widget/iconss.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';

class TransactionSummaryScreen extends StatelessWidget {
  static const String transactionSummaryScreen = "transactionSummaryScreen";
  TransactionSummaryScreen({this.transactionData, super.key});
  TransactionsData? transactionData;
  @override
  Widget build(BuildContext context) {
    bool isDeposit() {
      return transactionData!.type!.toLowerCase() == "deposit";
    }

    bool isPending() {
      return transactionData!.status!.toLowerCase() == "pending";
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                    child: TextOf("Transaction  Summary", 14, AppColors.white,
                        FontWeight.w500),
                  ),
                  const Expanded(flex: 2, child: SizedBox.shrink())
                ],
              ),
            ),
            const YMargin(15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundColor: isDeposit()
                              ? const Color(0xff553902)
                              : AppColors.grey,
                          child: isDeposit()
                              ? IconOf(Icons.north_east_rounded, 30,
                                  AppColors.secondaryColor)
                              : IconOf(Icons.south_west_rounded, 30,
                                  AppColors.deepGrey)),
                      const YMargin(5),
                      TextOf(
                          "${Constants.CURRENCY}${transactionData!.amount!.toString()}",
                          30,
                          AppColors.white,
                          FontWeight.w700),
                      const YMargin(10),
                      TextOf(
                          AppFunction.dateFormatter(
                              dateString: transactionData!.createdAt!),
                          12,
                          AppColors.deepGrey,
                          FontWeight.w700),
                      const YMargin(20),
                      Divider(
                        color: AppColors.grey,
                      ),
                      const YMargin(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextOf(!isDeposit() ? "Recipient" : "Source", 14,
                              AppColors.deepGrey, FontWeight.w500),
                          !isDeposit()
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextOf("Access Bank Plc", 16,
                                        AppColors.white, FontWeight.w700),
                                    TextOf(
                                        transactionData!.user!.fullName!
                                            .toUpperCase(),
                                        12,
                                        AppColors.deepGrey,
                                        FontWeight.w500)
                                  ],
                                )
                              : TextOf(transactionData!.source!.toUpperCase(),
                                  16, AppColors.white, FontWeight.w700)
                        ],
                      ),
                      const YMargin(20),
                      Divider(
                        color: AppColors.grey,
                      ),
                      const YMargin(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextOf("Status", 14, AppColors.deepGrey,
                              FontWeight.w500),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: !isPending()
                                    ? AppColors.green
                                    : AppColors.grey,
                                borderRadius: BorderRadius.circular(50)),
                            child: TextOf(
                                isPending() ? "Processing" : "Processed",
                                12,
                                !isPending()
                                    ? AppColors.white
                                    : AppColors.secondaryColor,
                                FontWeight.w500),
                          )
                        ],
                      ),
                      isDeposit()
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const YMargin(20),
                                Divider(
                                  color: AppColors.grey,
                                ),
                                const YMargin(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextOf("Fee", 14, AppColors.deepGrey,
                                        FontWeight.w500),
                                    TextOf(
                                        "${Constants.CURRENCY} ${transactionData!.amount!.toString()}",
                                        14,
                                        AppColors.white,
                                        FontWeight.w700),
                                  ],
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                      const YMargin(20),
                      Divider(
                        color: AppColors.grey,
                      ),
                      const YMargin(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextOf("Transaction ID", 14, AppColors.deepGrey,
                                  FontWeight.w500),
                              const XMargin(5),
                              IconOf(Icons.info_outline, 10, AppColors.deepGrey)
                            ],
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                      text: transactionData!.uuid!))
                                  .then((value) => Alerts.showAlert(
                                      text: "Copied to clipboard",
                                      alertType: AlertType.SUCCESS));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageOf.copy,
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextOf(
                                    transactionData!.uuid!,
                                    14,
                                    AppColors.white,
                                    FontWeight.w500,
                                    align: TextAlign.right,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      YMargin(MediaQuery.of(context).size.height * 0.15),
                      isPending() == false
                          ? ElevatedButton(
                              onPressed: () {},
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                      shape: MaterialStatePropertyAll<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: AppColors.primaryColor),
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      )),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.transparent),
                                      fixedSize: MaterialStatePropertyAll<Size>(
                                          Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              60))),
                              child: TextOf("Report this transaction", 18,
                                  AppColors.primaryColor, FontWeight.w700),
                            )
                          : const SizedBox.shrink(),
                      const YMargin(30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget loadBottomSheet() {
  return Container();
}
