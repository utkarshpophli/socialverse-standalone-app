import 'package:socialverse/export.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: UIInterface.backgroundAppTheme(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: whiteColor.withOpacity(.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                      color: primaryWhite,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              CommonWidget().socialVerseLogo(),
              customHeight(20),
              Image.asset(
                AppAsset.home,
                height: Get.height * 0.3,
              ),
              customHeight(20),
              Text(
                "This Feature is",
                style:
                    AppTextStyle.normalRegular20.copyWith(color: primaryWhite),
              ),
              Text(
                "Under Construction",
                style: AppTextStyle.normalBold24.copyWith(color: primaryWhite),
              ),
              customHeight(20),
              PrimaryTextButton(
                title: 'Remind me when available',
                onPressed: () {},
                buttonColor: Theme.of(context).primaryColor,
                radius: 25,
                textColor: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
