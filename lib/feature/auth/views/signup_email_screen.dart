import 'dart:developer';
import '../../../export.dart';

class SignUpEmailScreen extends StatefulWidget {
  const SignUpEmailScreen({Key? key}) : super(key: key);

  @override
  State<SignUpEmailScreen> createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
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
                            height15,
                            Center(
                              child: Text(
                                "Please fill the form to create an account",
                                textAlign: TextAlign.center,
                                style: textTheme.titleMedium,
                              ),
                            ),
                            height25,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("First name",
                                          style: textTheme.titleMedium),
                                      height5,
                                      TextFormFieldWidget(
                                        controller:
                                            controller.firstNameController,
                                        hintText: 'First name',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(14),
                                          child: SvgPicture.asset(
                                            AppAsset.icuser,
                                            color: primaryBlack,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                customWidth(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Last name",
                                          style: textTheme.titleMedium),
                                      height5,
                                      TextFormFieldWidget(
                                        controller:
                                            controller.lastNameController,
                                        hintText: 'last name',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(14),
                                          child: SvgPicture.asset(
                                            AppAsset.icuser,
                                            color: primaryBlack,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            height15,
                            Text("Username", style: textTheme.titleMedium),
                            height5,
                            TextFormFieldWidget(
                              controller: controller.usernameController,
                              hintText: 'Username',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(14),
                                child: SvgPicture.asset(
                                  AppAsset.icuser,
                                  color: primaryBlack,
                                ),
                              ),
                              suffixIcon: const SizedBox(
                                width: 25,
                                height: 25,
                              ),
                            ),
                            height15,
                            Text("Email", style: textTheme.titleMedium),
                            height5,
                            EmailWidget(
                              controller: controller.emailController,
                              hintText: 'Enter Your Email',
                            ),
                            height15,
                            Text(
                              "Password",
                              style: textTheme.titleMedium,
                            ),
                            height5,
                            PasswordWidget(
                              controller: controller.passwordController,
                              hintText: "Enter Your Password",
                            ),
                            height15,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 5, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Checkbox(
                                      checkColor: purpleColor,
                                      fillColor:
                                          MaterialStateProperty.all(whiteColor),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ), // Rounded Checkbox
                                      value: checkValue,
                                      onChanged: (inputValue) {
                                        setState(() {
                                          checkValue = inputValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  width15,
                                  Text("I agree to the",
                                      style: textTheme.titleMedium),
                                  GestureDetector(
                                    onTap: () {
                                      log('tap');
                                      Get.to(
                                        () => const ReportPage(
                                          link:
                                              'https://www.socialverseapp.com/terms-and-conditions',
                                        ),
                                      );
                                    },
                                    child: Text(
                                      " terms and conditions",
                                      style: textTheme.titleMedium!.copyWith(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height10,
                            PrimaryTextButton(
                              title: "Create an Account",
                              buttonColor:
                                  checkValue == true ? whiteColor : grey,
                              onPressed: checkValue == true
                                  ? () => controller.create(context: context)
                                  : null,
                            ),
                            height10,
                          ],
                        ),
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
