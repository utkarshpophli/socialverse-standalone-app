import 'package:socialverse/export.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  RxBool isBottomSheetOpen = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: UIInterface.backgroundAppTheme(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customHeight(65),
                  Image.asset(
                    AppAsset.white_logo,
                    width: Get.width / 2.2,
                    color: Colors.white,
                  ),
                  customHeight(65),
                  // Text(
                  //   'Welcome!',
                  //   style: textTheme.bodyLarge!.copyWith(
                  //     fontSize: 36,
                  //     fontWeight: FontWeight.bold,
                  //     color: primaryWhite,
                  //   ),
                  // ),
                  Text(
                    'Exiting the dark age\nof the toxic internet\nengagement algorithm',
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primaryWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  height10,
                  Text(
                    'The first app with the goal\nto inspire you to get off of it via a\ncollective search for the most\ninspiring and empowering videos',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall!.copyWith(color: primaryWhite),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: PrimaryTextButton(
                  title: 'Get Whitepilled',
                  onPressed: () {
                    dataStorage.write("isWelcome", true);
                    Get.offAll(() => MainHomeScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
