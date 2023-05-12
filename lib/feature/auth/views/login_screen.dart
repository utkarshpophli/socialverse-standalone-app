import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:socialverse/export.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Scaffold(
      backgroundColor: purpleColor,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAsset.darkThemeBackground),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black38,
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
                              const CommonWidget().socialVerseLogo(),
                              Center(
                                child: Text(
                                  "Log in",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 32,
                                        color: primaryWhite,
                                      ),
                                ),
                              ),
                              height10,
                              Text(
                                "Please Log in to continue using our app",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: primaryWhite,
                                      fontSize: 14,
                                    ),
                              ),
                              height25,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email/Username",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: primaryWhite,
                                      ),
                                ),
                              ),
                              height5,
                              EmailWidget(
                                controller: controller.emailController,
                                hintText: 'Enter Your Email',
                                onChanged: (val) {
                                  setState(() {});
                                },
                              ),
                              height10,
                              if (controller
                                  .emailController.text.isNotEmpty) ...[
                                height10,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Password",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: primaryWhite,
                                        ),
                                  ),
                                ),
                                height5,
                                PasswordWidget(
                                  controller: controller.passwordController,
                                  hintText: "Enter Your Password",
                                ),
                              ],
                              InkWell(
                                onTap: () =>
                                    Get.to(() => ForgotPasswordScreen()),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryWhite,
                                        ),
                                  ),
                                ),
                              ),
                              height10,
                              if (controller.isLoading == false) ...[
                                InkWell(
                                  onTap: () {
                                    controller.login();
                                  },
                                  child: PrimaryTextButton(
                                    title: "Login",
                                    onPressed: () {
                                      controller.login(context: context);
                                    },
                                  ),
                                ),
                              ],
                              if (controller.isLoading) ...[
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CustomProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                              if (controller.isLoading == false) ...[
                                Column(
                                  children: [
                                    height10,
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Text(
                                      "Sign in with ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: primaryWhite,
                                          ),
                                    ),
                                    height10,
                                    Row(
                                      children: [
                                        if (Platform.isAndroid) ...[
                                          Expanded(
                                            child: SocialButton(
                                              icon: EvaIcons.google,
                                              onPressed: () {
                                                controller.signInWithGoogle(
                                                  context: context,
                                                );
                                              },
                                            ),
                                          ),
                                          // width05,
                                        ],
                                        if (Platform.isIOS) ...[
                                          Expanded(
                                            child: SocialButton(
                                              icon: Icons.apple,
                                              onPressed: () {
                                                controller.signInWithApple();
                                              },
                                            ),
                                          ),
                                          // width05,
                                        ],
                                        // Expanded(
                                        //   child: SocialButton(
                                        //     icon: EvaIcons.twitter,
                                        //     onPressed: () {
                                        //       controller.signInWithGoogle();
                                        //     },
                                        //   ),
                                        // ),
                                        // width05,
                                        // Expanded(
                                        //   child: SocialButton(
                                        //     icon: EvaIcons.facebook,
                                        //     onPressed: () {
                                        //       controller.signInWithFacebook();
                                        //     },
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                              // if (controller.isLoading) ...[
                              //   height20,
                              //   height20,
                              //   SizedBox(
                              //     height: 40,
                              //     width: 40,
                              //     child: CustomProgressIndicator(
                              //       color: Colors.white,
                              //     ),
                              //   )
                              // ]
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
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const SignUpScreen(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: primaryWhite),
                                    ),
                                    Text(
                                      " Sign up",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: primaryWhite,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
