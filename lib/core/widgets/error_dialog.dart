import 'package:socialverse/export.dart';

class ErrorDialog {
  static void showErrorDialog(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message.toString(),
      ),
    ));
  }
}

class ErrorAlertDialog extends StatelessWidget {
  final dynamic theme;
  final String title;
  final String action;
  final String content;
  final Function() tap;
  final Function()? cancelTap;

  const ErrorAlertDialog(
      {Key? key,
      required this.theme,
      required this.title,
      required this.action,
      required this.content,
      required this.tap,
      this.cancelTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _showAndroidDialog(
      context: context,
      tap: tap,
      content: content,
      title: title,
      action: action,
      cancelTap: cancelTap,
    );
  }

  AlertDialog _showAndroidDialog({
    required BuildContext context,
    required String content,
    required String title,
    required String action,
    required Function()? tap,
    Function()? cancelTap,
  }) {
    return AlertDialog(
      backgroundColor: theme == true ? fillGrey : primaryWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 15, color: grey),
      ),
      actions: [
        SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                color: grey,
              ),
              height10,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: cancelTap ??
                          () {
                            Get.back();
                          },
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15, color: grey),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 15,
                    color: grey,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: tap,
                      child: Center(
                        child: Text(
                          action,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 15,
                                    color: purpleColor,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              height10,
            ],
          ),
        )
      ],
    );
  }
}
