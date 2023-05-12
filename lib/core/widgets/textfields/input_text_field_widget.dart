import 'package:socialverse/export.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
    this.fieldKey,
    this.hintText,
    this.style,
    this.controller,
    this.textInputAction,
    this.keyboardType,
    this.enabled,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);
  final Key? fieldKey;
  final String? hintText;
  final TextStyle? style;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final TextInputType? keyboardType;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return textFormField(
        fieldKey: fieldKey,
        hintText: hintText,
        enabled: enabled,
        focusNode: focusNode,
        controller: controller,
        textInputAction: textInputAction,
        filledColor: primaryWhite,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14,
              color: primaryBlack,
            ),
        hintStyle:
            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            AppAsset.icemail,
          ),
        ),
        suffixIcon: const SizedBox(
          height: 25,
          width: 25,
        )
        // validator: (value) => Validators.validateEmail(value!.trim()),
        );
  }
}

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    Key? key,
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.validator,
    this.controller,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  final Key? fieldKey;
  final int? maxLength;
  final String? hintText;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      fieldKey: widget.fieldKey,
      hintText: widget.hintText,
      focusNode: widget.focusNode,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      filledColor: primaryWhite,
      obscureText: _obscureText,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontSize: 14, color: primaryBlack),
      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
      maxLines: 1,
      // validator: widget.validator ??
      //     (value) => Validators.validatePassword(value!.trim()),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(14),
        child: SvgPicture.asset(
          AppAsset.icprivacy,
          color: primaryBlack,
        ),
      ),
      suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: _obscureText
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    AppAsset.eyeOpen,
                    height: 17,
                    width: 17,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    AppAsset.eyeoff,
                    height: 24,
                    width: 24,
                  ),
                )

          // Icon(
          //   _obscureText ? Icons.visibility : Icons.visibility_off,
          //   color: primaryBlack,
          // ),
          ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    Key? key,
    this.fieldKey,
    this.hintText,
    this.validator,
    this.controller,
    this.maxLength,
    this.focusNode,
    this.autofocus,
    this.style,
    this.textInputAction,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.keyboardType,
    this.prefixIcon,
    this.fillColor,
  }) : super(key: key);

  final Key? fieldKey;
  final String? hintText;
  final List<TextInputFormatter?>? inputFormatters;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      keyboardType: keyboardType,
      fieldKey: fieldKey,
      hintText: hintText,
      focusNode: focusNode,
      controller: controller,
      style: style,
      filledColor: fillColor,
      validator: validator,
      textAlign: textAlign,
      maxLength: maxLength,
      prefixIcon: prefixIcon,
      textInputAction: textInputAction,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]'))],
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.initialValue,
    this.fieldKey,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.enabled,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.hintStyle,
    this.filledColor,
    this.style,
    this.theme,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  final String? initialValue;
  final Key? fieldKey;
  final String? hintText;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? filledColor;
  final bool? enabled;
  final bool? theme;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      initialValue: initialValue,
      fieldKey: fieldKey,
      focusNode: focusNode,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.text,
      validator: validator,
      suffixIcon: suffixIcon,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled,
      textInputAction: textInputAction,
      textAlign: textAlign,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      filledColor: filledColor ?? const Color(0xffF8F8F8),
      theme: theme,
      style: style ??
          Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontSize: 14, color: primaryBlack),
      hintStyle: hintStyle ??
          Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
      prefixIcon: prefixIcon,
    );
  }
}

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({
    Key? key,
    this.fieldKey,
    this.hintText,
    this.validator,
    this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.filledColor,
    this.theme,
  }) : super(key: key);

  final Key? fieldKey;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final Color? filledColor;
  final FormFieldValidator<String?>? validator;
  final bool? theme;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      fieldKey: fieldKey,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      hintText: hintText,
      decoration: InputDecoration(
        enabled: true,
        hintStyle: AppTextStyle.normalRegular14.copyWith(
          color: theme == true ? primaryWhite : primaryBlack,
        ),
        filled: true,
        fillColor: theme == true ? fillGrey : const Color(0xffF8F8F8),
        enabledBorder:
            theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
        focusedBorder:
            theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
        disabledBorder:
            theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
        border:
            theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final bool otherScreen;
  final bool darkTheme;
  final String? hintText;
  final int? maxLines;
  final bool? readOnly;
  final void Function()? onTap;
  final bool? autofocus;

  const SearchBar({
    Key? key,
    this.onChanged,
    this.controller,
    required this.darkTheme,
    this.otherScreen = false,
    this.hintText,
    this.maxLines,
    this.readOnly,
    this.onTap,
    this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      controller: controller,
      cursorColor: hintGrey,
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      style: Theme.of(context).textTheme.bodySmall,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        hintText: hintText ?? 'Search',
        // hintStyle: AppTextStyle.normalRegular14.copyWith(color: grey),
        fillColor: darkTheme ? fillGrey : primaryWhite,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 18, 0, 15),
        border: darkTheme ? darkThemeOutlineInputBorder : outlineInputBorder,
        enabledBorder:
            darkTheme ? darkThemeOutlineInputBorder : outlineInputBorder,
        disabledBorder:
            darkTheme ? darkThemeOutlineInputBorder : outlineInputBorder,
        focusedBorder:
            darkTheme ? darkThemeOutlineInputBorder : outlineInputBorder,
        errorBorder: errorBorderColor,
        suffixIcon: otherScreen == true
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                  AppAsset.icsearch,
                  color: grey,
                ),
              ),
      ),
    );
  }
}

TextFormField textFormField(
    {final Key? fieldKey,
    final String? hintText,
    final String? labelText,
    final String? helperText,
    final String? initialValue,
    final int? errorMaxLines,
    final int? maxLines,
    final int? maxLength,
    final bool? enabled,
    final bool autofocus = false,
    final bool obscureText = false,
    final Color? filledColor,
    final Color? cursorColor,
    final Widget? prefixIcon,
    final Widget? suffixIcon,
    final FocusNode? focusNode,
    final TextStyle? style,
    final TextStyle? hintStyle,
    final TextAlign textAlign = TextAlign.left,
    final TextEditingController? controller,
    final List<TextInputFormatter>? inputFormatters,
    final TextInputAction? textInputAction,
    final TextInputType? keyboardType,
    final TextCapitalization textCapitalization = TextCapitalization.none,
    final GestureTapCallback? onTap,
    final FormFieldSetter<String?>? onSaved,
    final FormFieldValidator<String?>? validator,
    final ValueChanged<String?>? onChanged,
    final ValueChanged<String?>? onFieldSubmitted,
    final bool? theme,
    InputDecoration? decoration}) {
  return TextFormField(
    key: fieldKey,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText,
    enabled: enabled,
    textAlignVertical: TextAlignVertical.bottom,
    validator: validator,
    maxLength: maxLength,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    onTap: onTap,
    onSaved: onSaved,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    autocorrect: true,
    autofocus: autofocus,
    textAlign: textAlign,
    cursorColor: primaryBlack,

    // cursorHeight: 5,
    style: style,
    decoration: decoration ??
        InputDecoration(
          prefixIcon: prefixIcon,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 18, 0, 15),
          border:
              theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
          enabledBorder:
              theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
          focusedBorder:
              theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
          errorBorder:
              theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
          disabledBorder:
              theme == true ? darkThemeOutlineInputBorder : outlineInputBorder,
          errorMaxLines: 5,
          fillColor: filledColor ?? const Color(0xffF8F8F8),
          filled: true,
          hintStyle: hintStyle,
          hintText: hintText,
          counterText: "",
          suffixIcon: suffixIcon,
          labelText: labelText,
          helperText: helperText,
        ),
  );
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(color: Color(0xffDADADA)),
);

OutlineInputBorder darkThemeOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(color: fillGrey),
);

OutlineInputBorder errorBorderColor = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(color: Colors.red),
);
