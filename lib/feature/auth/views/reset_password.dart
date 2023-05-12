import 'package:flutter/cupertino.dart';
import '../../../export.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyText.withOpacity(.1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            customHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CommonWidget().socialVerseLogo(color: appColor),
                customHeight(40),
                const Center(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                height10,
                Text(
                  "Please enter New Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: greyText.withOpacity(.7),
                  ),
                ),
                height25,
                height10,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: greyText.withOpacity(.7),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: textFormField(
                    prefixIcon: const Icon(
                      CupertinoIcons.lock,
                      color: primaryBlack,
                      size: 18,
                    ),
                    suffixIcon: const Icon(
                      Icons.remove_red_eye,
                      color: primaryBlack,
                      size: 18,
                    ),
                  ),
                ),
                height10,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: greyText.withOpacity(.7),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: textFormField(
                    prefixIcon: const Icon(
                      CupertinoIcons.lock,
                      color: primaryBlack,
                      size: 18,
                    ),
                    suffixIcon: const Icon(
                      Icons.remove_red_eye,
                      color: primaryBlack,
                      size: 18,
                    ),
                  ),
                ),
                height10,
                customHeight(50),
                GradientTextButton(
                  title: "Submit",
                  onPressed: () {
                    // Get.to(() => MainHomePage());
                  },
                ),
                height10,
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
