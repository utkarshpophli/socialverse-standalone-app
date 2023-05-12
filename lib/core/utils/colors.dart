// 11184E

import 'package:get_storage/get_storage.dart' as ge;
import 'package:socialverse/export.dart';

ge.GetStorage dataStorage1 = ge.GetStorage();

const String isdarkMode = "isDarkMode";

ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      bodySmall: AppTextStyle.normalRegular14,
      bodyLarge: AppTextStyle.normalRegularGrey14,
      bodyMedium:
          AppTextStyle.normalRegularGrey14.copyWith(color: primaryWhite),
      labelSmall: AppTextStyle.normalRegular14,
      labelMedium:
          AppTextStyle.normalRegular14Black.copyWith(color: primaryWhite),
      labelLarge: AppTextStyle.normalRegular14.copyWith(
        color: primaryBlack,
      ),
      titleSmall: AppTextStyle.normalRegular14,
      titleMedium: AppTextStyle.normalRegular14,
    ),
    brightness: Brightness.dark,
    primaryColor: primaryBlack,
    cardColor: primaryWhite,
    errorColor: primaryWhite,
    hoverColor: fillGrey,
    canvasColor: appColor,
    backgroundColor: fillGrey,
    bottomAppBarColor: tikTokGrey,
    fontFamily: "sofia"
    // backgroundColor: fillGrey
    // buttonTheme: const ButtonThemeData(
    //   buttonColor: Colors.amber,
    //   disabledColor: Colors.grey,
    // ),
    );
ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      labelSmall: AppTextStyle.normalRegular14.copyWith(color: appColor),
      labelMedium: AppTextStyle.normalRegular14Black,
      labelLarge: AppTextStyle.normalRegular14,
      bodySmall: AppTextStyle.normalRegular14.copyWith(color: primaryBlack),
      bodyLarge: AppTextStyle.normalRegularGrey14.copyWith(color: primaryBlack),
      bodyMedium: AppTextStyle.normalRegularGrey14.copyWith(
        color: greyText.withOpacity(0.7),
      ),
      titleSmall: AppTextStyle.normalRegular14.copyWith(color: commonText),
      titleMedium: AppTextStyle.normalRegular14,
    ),
    brightness: Brightness.light,
    primaryColor: primaryWhite,
    cardColor: appColor,
    errorColor: primaryBlack,
    hoverColor: primaryWhite,
    bottomAppBarColor: primaryWhite,
    canvasColor: primaryBlack,
    backgroundColor: grey.withOpacity(0.1),
    fontFamily: "sofia"
    // backgroundColor: grey.withOpacity(0.2),

    // buttonTheme: const ButtonThemeData(
    //   buttonColor: Colors.blue,
    //   disabledColor: Colors.grey,
    // ),
    );

// Map<String, Color> colorStyles = {
//   'primary': Colors.blue,
//   'ligth_font': Colors.black54,
//   'gray': Colors.black45,
//   'white': Colors.white
// };

const Color appColor = Color.fromRGBO(43, 75, 147, 1); //F1334E
const Color purpleColor = Color.fromRGBO(43, 75, 147, 1);
const Color blueColor = Colors.white; //F1334E
const Color offWhite = Color(0xffF8F8F8);
const Color whiteColor = Color(0xffFFFFFF);
const Color blackColor = Color(0xff000000);
const Color backgroundColor = Color(0xffF5F6F8);
const Color simpleGrey = Color(0xffDFDFDF);
const Color secondaryGrey = Color(0xFFBDBDBD);
const Color dividerGrey = Color(0xffDADADA);
const Color boxwhite = Color(0xffE3E3E4);

const Color bottomaGrey = Color(0xff373737);
const Color commonText = Color(0xff161722);
const Color greyText = Color(0xff7C7D83);
const Color grey = Color(0xff86878B);
Color lightGrey = Colors.grey.withOpacity(0.2);

const Color countText = Color(0xff3C3C3C);
const Color selectColor = Color(0xffF2F2F2);

const Color backgroundGrey = Color(0xffECEFF3);
// const Color lightGrey = Color(0xffF4F4F5);
// const Color lightGrey = Color(0xffD0D1D3);
const Color tikTokGrey = Color(0xff2C2D2E);
const Color hintGrey = Color(0xffA0A0A0);
const Color contentGrey = Color(0xff969498);
const Color regularGrey = Color(0xff7F7D89);
const Color darkGreyBlue = Color(0xff2B2C36); //505050
const Color titleBlack = Color(0xff333333);
const Color commonParrot = Color(0xff00B517);
const Color caribbeanGreen = Color(0xff67DDA0);
// const Color logocolor = Color(0xffE8001B);
// const Color redcolor = Color(0xffFF002A);

const Color lightappColor = Color(0xffFFE7E7);
const Color red = Color(0xffE22A2A);
const Color success = Color(0xff90B06E);
const Color infoDialog = Color(0xff79B3E4);
const Color blue = Color(0xff068AEC);
const Color yellow = Color(0xffFFCC00);
const Color borderGrey = Color.fromARGB(255, 7, 2, 2);
const Color fillGrey = Color(0xff2B2B2B);

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const MaterialColor primaryWhite = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
const int _whitePrimaryValue = 0xFFFFFFFF;

const int _scaffoldValue = 0xFFFAFAFA;
const MaterialColor scaffoldColor = MaterialColor(
  _scaffoldValue,
  <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFFAFAFA),
    200: Color(0xFFFAFAFA),
    300: Color(0xFFFAFAFA),
    400: Color(0xFFFAFAFA),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFAFAFA),
    700: Color(0xFFFAFAFA),
    800: Color(0xFFFAFAFA),
    900: Color(0xFFFAFAFA),
  },
);
