import 'dart:developer';
import 'package:socialverse/export.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NetworkRepository networkRepository = NetworkRepository();

  bool isLoading = false;

  resetInitiate(context) async {
    isLoading = true;
    update();
    Map data = {
      'mixed': emailController.text.trim(),
    };
    final response = await networkRepository.resetInitiate(data, context);
    if (response != null) {
      Get.snackbar('Reset Password', response['message'],
          backgroundColor: appColor, colorText: primaryWhite);
      isLoading = false;
      log(response.toString());
      update();
    }
  }
}
