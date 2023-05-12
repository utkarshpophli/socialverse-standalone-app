import 'package:socialverse/export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GetBuilder<ResetPasswordController>(builder: (controller) {
        return Container(
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: UIInterface.backgroundAppTheme(),
          child: Form(
            key: controller.formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        color: primaryWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: primaryWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                // customHeight(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CommonWidget().socialVerseLogo(),
                    // customHeight(40),
                    Center(
                      child: Text(
                        "Forgot password",
                        style: textTheme.titleMedium!.copyWith(fontSize: 32),
                      ),
                    ),
                    height10,
                    Text(
                      "Please enter your registered email/username \nwe'll send further instruction on that.",
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium,
                    ),
                    customHeight(35),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "Email/Username",
                    //     style: textTheme.titleMedium!.copyWith(fontSize: 12),
                    //   ),
                    // ),
                    EmailWidget(
                      controller: controller.emailController,
                      hintText: 'Email/Username',
                    ),
                    customHeight(60),
                    if (controller.isLoading == false) ...[
                      PrimaryTextButton(
                        title: 'Send',
                        onPressed: () {
                          if (controller.emailController.text.isNotEmpty) {
                            HapticFeedback.mediumImpact();
                            controller.resetInitiate(context);
                          }
                        },
                      ),
                    ],
                    if (controller.isLoading) ...[
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CustomProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
