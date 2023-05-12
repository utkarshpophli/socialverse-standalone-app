import 'dart:developer';
import 'package:socialverse/feature/auth/views/signup_email_screen.dart';
import 'package:socialverse/feature/auth/views/signup_social_screen.dart';

import '../../../export.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customHeight(40),
                            Center(
                                child: const CommonWidget().socialVerseLogo()),
                            Center(
                              child: Text(
                                "Sign up",
                                style: textTheme.titleMedium!.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            height20,
                            height20,
                            PrimaryTextButton(
                              title: 'Sign up with email',
                              onPressed: () {
                                Get.to(() => SignUpEmailScreen());
                              },
                            ),
                            height15,
                            PrimaryTextButton(
                              title: 'Sign up with social',
                              onPressed: () {
                                Get.to(() => SignUpSocialScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                isKeyboardShowing
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40,
                          left: 20,
                          right: 20,
                          // top: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account?",
                                      style: textTheme.titleMedium),
                                  Text(
                                    " Sign In",
                                    style: textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
