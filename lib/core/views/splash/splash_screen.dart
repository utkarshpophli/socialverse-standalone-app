import 'dart:developer';

import '/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ThemeController themeController = Get.put(ThemeController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    startTime();
    fetchProfile();
  }

  startTime() async {
    return Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => dataStorage.read("isWelcome") == true
              ? MainHomeScreen()
              : const WelcomeScreen(),
        ),
      );
    });
  }

  fetchProfile() async {
    dataStorage.read("username") == null
        ? null
        : profileController.getProfileDetails(
            context,
            fromUser: true,
            profileusername: dataStorage.read("username"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.darkThemeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(
              AppAsset.white_logo,
              color: Colors.white,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
