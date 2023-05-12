import '/export.dart';

/// SVG using Icon Button
// ignore: must_be_immutable
class SVGIconButton extends StatefulWidget {
  Function? ontap;
  double? padding;
  double? borderRadius;
  Color? buttonColor;
  Color? iconColor;
  String? icon;
  double? iconHeight;

  SVGIconButton(
      {Key? key,
      required this.icon,
      required this.ontap,
      this.borderRadius = 0,
      this.buttonColor,
      this.iconColor,
      this.iconHeight,
      this.padding})
      : super(key: key);

  @override
  State<SVGIconButton> createState() => _SVGIconButtonState();
}

class _SVGIconButtonState extends State<SVGIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.ontap!(),
      child: Container(
        padding: EdgeInsets.all(widget.padding ?? 14),
        decoration: BoxDecoration(
          color: widget.buttonColor ?? whiteColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        child: SvgPicture.asset(
          widget.icon!,
          color: widget.iconColor ?? primaryWhite,
          height: widget.iconHeight ?? 18,
        ),
        // child: Image.asset(
        //   widget.icon!,
        //   color: widget.iconColor ?? primaryWhite,
        //   height: widget.iconHeight ?? 18,
        // )
      ),
    );
  }
}

/// Image using Icon Button
// ignore: must_be_immutable
class ImageIconButton extends StatefulWidget {
  Function? ontap;
  double? padding;
  double? borderRadius;
  Color? buttonColor;
  Color? iconColor;
  String? icon;
  double? iconHeight;
  ImageIconButton(
      {Key? key,
      required this.icon,
      required this.ontap,
      this.borderRadius = 0,
      this.buttonColor,
      this.iconColor,
      this.iconHeight,
      this.padding})
      : super(key: key);

  @override
  State<ImageIconButton> createState() => _ImageIconButtonState();
}

class _ImageIconButtonState extends State<ImageIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.ontap!(),
      child: Container(
          padding: EdgeInsets.all(widget.padding ?? 14),
          decoration: BoxDecoration(
            color: widget.buttonColor ?? whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          // child: SvgPicture.asset(
          //   widget.icon!,
          //   color: widget.iconColor ?? primaryWhite,
          //   height: widget.iconHeight ?? 18,
          // ),
          child: Image.asset(
            widget.icon!,
            color: widget.iconColor ?? primaryWhite,
            height: widget.iconHeight ?? 18,
          )),
    );
  }
}

/// Icon using Icon Button
// ignore: must_be_immutable
class IconsIconButton extends StatefulWidget {
  Function? ontap;
  double? padding;
  double? borderRadius;
  Color? buttonColor;
  Color? iconColor;
  IconData? icon;
  double? iconHeight;
  IconsIconButton(
      {Key? key,
      required this.icon,
      required this.ontap,
      this.borderRadius = 0,
      this.buttonColor,
      this.iconColor,
      this.iconHeight,
      this.padding})
      : super(key: key);

  @override
  State<IconsIconButton> createState() => _IconsIconButtonState();
}

class _IconsIconButtonState extends State<IconsIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.ontap!(),
      child: Container(
        padding: EdgeInsets.all(widget.padding ?? 14),
        decoration: BoxDecoration(
          color: widget.buttonColor ?? whiteColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        child: Icon(
          widget.icon!,
          size: widget.iconHeight ?? 18,
          color: widget.iconColor ?? primaryWhite,
        ),
        // child: Image.asset(
        //   widget.icon!,
        //   color: widget.iconColor ?? primaryWhite,
        //   height: widget.iconHeight ?? 18,
        // )
      ),
    );
  }
}
