import 'package:socialverse/export.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  const NetworkImageWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.imageUrl,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      color: color,
      imageUrl: imageUrl!,
      progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset(
        AppAsset.load,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset('assets/images/SocialVerse.png'),
      ),
    );
  }
}
