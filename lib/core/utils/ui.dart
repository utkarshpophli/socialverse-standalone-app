import 'dart:io';

import 'package:socialverse/export.dart';

class UIInterface {
  static BoxDecoration backgroundTheme() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppAsset.apptheme),
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
          Colors.black38,
          BlendMode.darken,
        ),
      ),
    );
  }

  static BoxDecoration profileBackgroundTheme() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppAsset.apptheme),
        fit: BoxFit.fitHeight,
        colorFilter: ColorFilter.mode(
          Colors.black38,
          BlendMode.darken,
        ),
      ),
    );
  }

  static BoxDecoration backgroundAppTheme() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppAsset.darkThemeBackground),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black38,
          BlendMode.darken,
        ),
      ),
    );
  }

  static Widget profileImageWidget({
    required String imgUrl,
    double? height,
    double? width,
    double? radius,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: primaryWhite,
          width: 3,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 25),
        child: NetworkImageWidget(
          imageUrl: imgUrl.toString() != 'null'
              ? imgUrl
              : "https://pp.watchflic.com/profile/flic-avatar-a7725401e1215910aede0b33fddaa537.png",
          height: height ?? 50,
          width: width ?? 50,
        ),
      ),
    );
  }

  static Widget fileProfileImageWidget({
    required File imgUrl,
    double? height,
    double? width,
    double? radius,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: primaryWhite,
          width: 3,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 25),
        child: Image.file(
          imgUrl,
          height: height ?? 50,
          width: width ?? 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget iconButtonWidget(String image, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: whiteColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          image,
          height: 18,
          width: 18,
          color: primaryWhite,
        ),
      ),
    );
  }

  static verticalDivider() {
    return const VerticalDivider(
      color: dividerGrey,
      width: 2,
      thickness: 1,
    );
  }
}
