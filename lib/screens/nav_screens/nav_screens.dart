import 'package:flutter/material.dart';
import 'package:kooha/screens/other_nav_screens/other_nav_screens.dart';
import 'package:kooha/screens/wallet_screen/wallet_screen.dart';
import 'package:kooha/widget/iconss.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/utils/images.dart';

class NavScreens extends StatefulWidget {
  static const String navScreens = "navScreens";
  const NavScreens({super.key});

  @override
  State<NavScreens> createState() => _NavScreensState();
}

class _NavScreensState extends State<NavScreens> {
  int currentIndex = 1;
  List<Widget> realNavsScreens = [
    const OtherNavScreens(screenName: "Home"),
    const WalletScreen(),
    const OtherNavScreens(screenName: "Inbox"),
    const OtherNavScreens(screenName: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showExitPopup(context);
      },
      child: Scaffold(
        body: realNavsScreens.elementAt(currentIndex),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              thickness: 1,
              color: AppColors.deepGrey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 57,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navIcons(
                        thisIndex: 0,
                        imageName: ImageOf.homeIcon,
                        labelName: "Home"),
                    navIcons(
                        thisIndex: 1,
                        isWallet: true,
                        imageName: ImageOf.homeIcon,
                        labelName: "Wallet"),
                    ElevatedButton(
                      onPressed: () {},
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                              fixedSize: MaterialStatePropertyAll<Size>(Size(
                                  MediaQuery.of(context).size.width * 0.1,
                                  20))),
                      child: IconOf(Icons.add, 15, AppColors.white),
                    ),
                    navIcons(
                        thisIndex: 2,
                        imageName: ImageOf.messagesIcon,
                        labelName: "Inbox"),
                    navIcons(
                        thisIndex: 3,
                        imageName: ImageOf.profile,
                        labelName: "Profile"),
                  ],
                ),
              ),
            ),
            const YMargin(5)
          ],
        ),
      ),
    );
  }

  Widget navIcons(
      {required int thisIndex,
      required String imageName,
      bool isWallet = false,
      required String labelName}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          currentIndex = thisIndex;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (isWallet == true && currentIndex != 1)
              ? ImageIcon(
                  AssetImage(ImageOf.walletNeutral),
                  size: 20,
                  color: AppColors.deepGrey,
                )
              : (isWallet == true && currentIndex == 1)
                  ? Image.asset(
                      ImageOf.wallet,
                      height: 20,
                    )
                  : ImageIcon(
                      AssetImage(imageName),
                      size: 20,
                      color: currentIndex == thisIndex
                          ? AppColors.white
                          : AppColors.deepGrey,
                    ),
          const YMargin(7),
          TextOf(
              labelName,
              10,
              currentIndex == thisIndex ? AppColors.white : AppColors.deepGrey,
              FontWeight.w500),
        ],
      ),
    );
  }
}

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                shadowColor: AppColors.white,
                elevation: 1,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconOf(Icons.error_outline_rounded, 100, AppColors.red),
                      const YMargin(20),
                      TextOf("Hey!", 35, AppColors.white, FontWeight.w500),
                      const YMargin(20),
                      TextOf("Are you sure you want to exit?", 15,
                          AppColors.white, FontWeight.w500),
                      const YMargin(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ElevatedButton(
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AppColors.primaryColor
                                                    .withOpacity(0.3))),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: TextOf("Yes", 16, AppColors.white,
                                    FontWeight.w700)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ElevatedButton(
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AppColors.primaryColor)),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: TextOf("No", 16, AppColors.white,
                                    FontWeight.w700)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )) ??
      false; //if showDialouge had returned null, then return false
}
