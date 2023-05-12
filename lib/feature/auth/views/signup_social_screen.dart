import 'dart:developer';
import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import '../../../export.dart';

class SignUpSocialScreen extends StatefulWidget {
  const SignUpSocialScreen({Key? key}) : super(key: key);

  @override
  State<SignUpSocialScreen> createState() => _SignUpSocialScreenState();
}

class _SignUpSocialScreenState extends State<SignUpSocialScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: purpleColor,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.darkThemeBackground),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black45,
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customHeight(40),
                          Center(child: const CommonWidget().socialVerseLogo()),
                          Center(
                            child: Text(
                              "Sign up with",
                              style: textTheme.titleMedium!.copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          height15,
                          Center(
                            child: Text(
                              "Please sign up with any provider to continue",
                              textAlign: TextAlign.center,
                              style: textTheme.titleMedium,
                            ),
                          ),
                          height25,
                          if (controller.isLoading == false) ...[
                            if (Platform.isIOS) ...[
                              SocialButton(
                                icon: Icons.apple,
                                onPressed: () {
                                  controller.signInWithApple();
                                },
                              ),
                            ],
                            if (Platform.isAndroid) ...[
                              SocialButton(
                                icon: EvaIcons.google,
                                onPressed: () {
                                  controller.signInWithGoogle();
                                },
                              ),
                            ]
                            // height15,
                            // SocialButton(
                            //   icon: EvaIcons.twitter,
                            //   onPressed: () {},
                            // ),
                            // height15,
                            // SocialButton(
                            //   icon: EvaIcons.facebook,
                            //   onPressed: () {
                            //     controller.signInWithFacebook();
                            //   },
                            // ),
                          ],
                          if (controller.isLoading) ...[
                            height20,
                            height20,
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: CustomProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          ],
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       top: 20, left: 5, right: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       SizedBox(
                          //         height: 15,
                          //         width: 15,
                          //         child: Checkbox(
                          //           checkColor: purpleColor,
                          //           fillColor:
                          //               MaterialStateProperty.all(whiteColor),
                          //           materialTapTargetSize:
                          //               MaterialTapTargetSize.shrinkWrap,
                          //           shape: const RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.all(
                          //               Radius.circular(10),
                          //             ),
                          //           ), // Rounded Checkbox
                          //           value: checkValue,
                          //           onChanged: (inputValue) {
                          //             setState(() {
                          //               checkValue = inputValue!;
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //       width15,
                          //       Text("I agree to the",
                          //           style: textTheme.titleMedium),
                          //       GestureDetector(
                          //         onTap: () {
                          //           log('tap');
                          //           Get.to(
                          //             () => const ReportPage(
                          //               link:
                          //                   'https://www.socialverseapp.com/terms-and-conditions',
                          //             ),
                          //           );
                          //         },
                          //         child: Text(
                          //           " terms and conditions",
                          //           style: textTheme.titleMedium!.copyWith(
                          //             decoration: TextDecoration.underline,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // height10,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
