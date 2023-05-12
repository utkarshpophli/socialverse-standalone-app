import 'dart:developer';
import 'dart:io';
import '../../../export.dart';

class CategoryController extends GetxController {
  final int index = 0;
  PageController pageController = PageController();

  @override
  void onInit() {
    pageController = PageController()..addListener(_scrollListener);
    super.onInit();
  }

  Future<dynamic> _scrollListener([context]) async {
    if (pageController.position.pixels ==
        pageController.position.maxScrollExtent) {
      log('MaxExtent');
      floatingScaffold(
        context,
        message: 'There\'re no more videos in this sphere',
      );
    } else {}
  }

  floatingScaffold(
    context, {
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: Platform.isIOS ? Get.height * 0.14 : Get.height * 0.12,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
