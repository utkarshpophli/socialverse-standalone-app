import 'package:socialverse/export.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: UIInterface.backgroundAppTheme(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        Text(
                          "Welcome to SocialVerse Wallet",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: primaryWhite,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        height15,
                        Text(
                          "SocialVerse Wallet allows you to deposit crypto assets into your wallet, manage all your assets and send send crypto you your friends",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 16,
                                    color: primaryWhite,
                                  ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: Get.height * 0.1),
                          child: SvgPicture.asset(AppAsset.wallet),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: Get.height * 0.15,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrimaryTextButton(
                    title: 'Wallet is coming soon',
                    onPressed: () {
                      // Get.dialog(
                      //     AlertDialog(
                      //       backgroundColor: Colors.transparent,
                      //       contentPadding: EdgeInsets.zero,
                      //       content: dialog(),
                      //     ),
                      //     useSafeArea: false
                      //     // contentPadding: EdgeInsets.zero,
                      //     // content: Center(child: dialog()),
                      //     );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           height: Get.height * 0.05,
        //         ),
        //         Text(
        //           "Welcome to SocialVerse Wallet",
        //           style: Theme.of(context).textTheme.labelLarge!.copyWith(
        //                 fontSize: 26,
        //                 fontWeight: FontWeight.bold,
        //                 color: primaryWhite,
        //               ),
        //           textAlign: TextAlign.center,
        //         ),
        //         height15,
        //         Text(
        //           "SocialVerse Wallet allows you to deposit crypto assets into your wallet, manage all your assets and send send crypto you your friends",
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context).textTheme.labelLarge!.copyWith(
        //                 fontSize: 16,
        //                 color: primaryWhite,
        //               ),
        //         ),
        //         Container(
        //           margin: EdgeInsets.symmetric(vertical: Get.height * 0.1),
        //           child: SvgPicture.asset(AppAsset.wallet),
        //         ),
        //         PrimaryTextButton(
        //           title: 'Wallet is coming soon',
        //           onPressed: () {
        //             // Get.dialog(
        //             //     AlertDialog(
        //             //       backgroundColor: Colors.transparent,
        //             //       contentPadding: EdgeInsets.zero,
        //             //       content: dialog(),
        //             //     ),
        //             //     useSafeArea: false
        //             //     // contentPadding: EdgeInsets.zero,
        //             //     // content: Center(child: dialog()),
        //             //     );
        //           },
        //         ),
        //         SizedBox(
        //           height: Get.height * 0.1,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget dialog() {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              //height: Get.height / 1.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAsset.airdrop),
                  fit: BoxFit.fill,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  customHeight(50),
                  Image.asset(
                    AppAsset.artboard,
                    height: Get.height / 4.5,
                  ),
                  const Text(
                    "Welcome to Social Verse",
                    style: AppTextStyle.normalBold26,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "The social platform you get to own a part of!",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normalRegular14
                        .copyWith(color: primaryBlack),
                  ),
                  height20,
                  GradientTextButton(
                    title: 'Cliam Airdrop',
                    onPressed: () {
                      Get.to(
                        () => const CommingSoonScreen(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryWhite, width: 3),
                color: appColor,
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: primaryWhite,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
