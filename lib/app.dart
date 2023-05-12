import 'dart:developer';
import 'package:socialverse/core/config/dynamic_link_service.dart';
import 'package:socialverse/core/utils/screen_sizes.dart';
import 'export.dart';
import "dart:io";

final dataStorage = GetStorage();
bool a = dataStorage.read("isDarkMode") ?? true;

RxBool isDarkMode = a.obs;

class SocialVerse extends StatefulWidget {
  const SocialVerse({Key? key}) : super(key: key);
  @override
  _SocialVerseState createState() => _SocialVerseState();
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "navigator");

class _SocialVerseState extends State<SocialVerse> {
  DynamicRepository dynamicRepository = DynamicRepository();
  @override
  void initState() {
    super.initState();
    initializeDynamicLink(context);
    log(isDarkMode.toString());
    dataStorage.write("isDarkMode", isDarkMode.value);
    // gettheme();
  }

  initializeDynamicLink(context) async {
    await dynamicRepository.initDynamicLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        ScreenSize.screenWidth,
        ScreenSize.screenHeight,
      ),
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Platform.isIOS ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Platform.isIOS ? Brightness.dark : Brightness.light,
            systemNavigationBarIconBrightness:
                Platform.isIOS ? Brightness.dark : Brightness.light,
          ),
          child: GetMaterialApp(
            navigatorKey: navigatorKey,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            title: 'SocialVerse',
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
