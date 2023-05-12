// ignore_for_file: must_be_immutable

import '/export.dart';

class TextWidget extends StatefulWidget {
  String? label;
  String? semeticsLabel;
  TextStyle? textStyle;
  int? maxLine;
  TextOverflow? textOverFlow;
  TextAlign? textAlign;
  TextWidget(
      {Key? key,
      required this.label,
      this.maxLine,
      this.semeticsLabel,
      this.textAlign,
      this.textOverFlow,
      this.textStyle})
      : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label!,
      style: widget.textStyle,
      maxLines: widget.maxLine,
      overflow: widget.textOverFlow,
      textAlign: widget.textAlign,
      semanticsLabel: widget.semeticsLabel,
    );
  }
}
