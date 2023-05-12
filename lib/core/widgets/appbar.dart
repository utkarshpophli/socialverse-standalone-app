import '../../export.dart';

Widget commonAppbar({
  Widget? suffix,
  Widget? child,
  bool? darkTheme,
  EdgeInsets? padding = const EdgeInsets.fromLTRB(10, 2, 10, 0),
  required String title,
  required BuildContext context,
  String? icon,
  String? actionicon,
  Alignment? alignment,
  Function()? onBackTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      children: [
        SizedBox(
          height: Get.height / 8,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                suffix ??
                    IconsIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      borderRadius: 12.0,
                      ontap: onBackTap ??
                          () {
                            Get.back();
                          },
                    ),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.normalBold18,
                    textAlign: TextAlign.center,
                  ),
                ),
                icon != null
                    ? Row(
                        children: [
                          if (actionicon != null)
                            SVGIconButton(
                              icon: actionicon,
                              borderRadius: 12.0,
                              ontap: () {
                                // Get.back();
                              },
                            ),
                          width10,
                          SVGIconButton(
                            icon: icon,
                            borderRadius: 12.0,
                            ontap: () {
                              // Get.back();
                            },
                          ),
                        ],
                      )
                    : SizedBox(width: Get.width * 0.1)
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: alignment ?? Alignment.topCenter,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: child,
          ),
        ),
      ],
    ),
  );
}
