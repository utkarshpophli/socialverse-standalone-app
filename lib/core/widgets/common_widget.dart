import 'package:socialverse/export.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({Key? key}) : super(key: key);

  Widget horizontalDivider() {
    return const Divider(
      color: primaryBlack,
    );
  }

  Widget customHorizontalDivider() {
    return Container(
      color: primaryBlack,
      height: 1,
      width: double.infinity,
    );
  }

  Widget socialVerseLogo({double? height, double? width, Color? color}) {
    return Image.asset(
      AppAsset.white_logo,
      height: height ?? 200,
      width: width ?? Get.width / 2.2,
      color: color ?? primaryWhite,
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class CommonListTile extends StatelessWidget {
  CommonListTile(
      {Key? key,
      this.image,
      required this.imagePath,
      this.index,
      required this.text,
      this.trailing,
      this.isChange,
      this.color,
      this.height,
      this.width,
      this.horizontalTitleGap,
      this.theme})
      : super(key: key);
  final String imagePath;
  final String text;
  final String? image;
  final int? index;
  Widget? trailing;
  double? horizontalTitleGap;
  bool? isChange;
  Color? color;
  double? height;
  double? width;
  bool? theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: horizontalTitleGap ?? 15,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      leading: SvgPicture.asset(
        imagePath,
        color: theme == true ? primaryWhite : primaryBlack,
        height: height ?? 20,
        width: width ?? 20,
      ),
      title: Text(
        text,
        style: AppTextStyle.normalRegular14 //15
            .copyWith(
                color: theme == true ? primaryWhite : commonText, fontSize: 15),
        // maxLines: 2,
      ),
      trailing: trailing ??
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
    );
  }
}
