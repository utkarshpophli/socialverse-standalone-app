import 'package:socialverse/export.dart';

// ignore: must_be_immutable
class PrimaryTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final bool autofocus;
  final Color? buttonColor;
  final Color? textColor;
  final double? radius;
  const PrimaryTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.autofocus = true,
    this.buttonColor,
    this.radius,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      autofocus: autofocus,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        primary: primaryBlack,
        backgroundColor: buttonColor ?? primaryWhite,
        fixedSize: Size(width ?? Get.width, height ?? 50),
        alignment: Alignment.center,
      ),
      child: Text(
        title.toString(),
        style: AppTextStyle.normalRegular16.copyWith(
            fontWeight: FontWeight.w400, color: textColor ?? primaryBlack),
      ),
      onPressed: onPressed,
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final bool autofocus;
  final Color? buttonColor;
  final Color? textColor;
  final double? radius;
  final double? fontSize;
  const SocialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.height,
    this.width,
    this.autofocus = true,
    this.buttonColor,
    this.radius,
    this.textColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      autofocus: autofocus,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        primary: primaryBlack,
        backgroundColor: buttonColor ?? primaryWhite,
        fixedSize: Size(width ?? Get.width, height ?? 50),
        alignment: Alignment.center,
      ),
      child: Icon(icon),
      onPressed: onPressed,
    );
  }
}

class GradientTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color? buttonColor;
  const GradientTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          color: buttonColor,
          gradient: LinearGradient(colors: [
            appColor,
            appColor.withOpacity(.85),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          title.toString(),
          style: AppTextStyle.normalRegular16
              .copyWith(fontWeight: FontWeight.w500, color: primaryWhite),
        ),
      ),
    );
  }
}

class ImageTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  const ImageTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? Get.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                AppAsset.apptheme,
              ),
              fit: BoxFit.cover),
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        child: Text(
          title.toString(),
          style: AppTextStyle.normalRegular16
              .copyWith(fontSize: 13, color: primaryWhite),
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  const TransparentButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? Get.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(
            width: 1,
            // assign the color to the border color
            color: secondaryGrey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title.toString(),
          style: AppTextStyle.normalRegular16
              .copyWith(fontSize: 13, color: Theme.of(context).errorColor),
        ),
      ),
    );
  }
}

class CancelTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final bool autofocus;
  final Color? buttonColor;
  final Color? textColor;
  final double? radius;
  const CancelTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.autofocus = true,
    this.buttonColor,
    this.radius,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      autofocus: autofocus,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        primary: primaryBlack,
        backgroundColor: primaryWhite.withOpacity(0.2),
        fixedSize: Size(width ?? Get.width, height ?? 50),
        alignment: Alignment.center,
      ),
      child: Text(
        title.toString(),
        style: AppTextStyle.normalRegular16
            .copyWith(fontWeight: FontWeight.w400, color: primaryWhite),
      ),
      onPressed: onPressed,
    );
  }
}

class ImageButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  const ImageButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          width: Get.width * 0.65,
          height: 50,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(AppAsset.apptheme),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.normalRegular16.copyWith(
                fontSize: 16,
                color: primaryWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class SmallImageButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  const SmallImageButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          width: Get.width * 0.65,
          height: 35,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(AppAsset.apptheme),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.normalRegular16.copyWith(
                fontSize: 12,
                color: primaryWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
