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
    return Scaffold(
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
                                MediaQuery.of(context).size.width * 0.1, 20))),
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
