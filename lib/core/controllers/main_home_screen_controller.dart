import 'package:socialverse/export.dart';

RxBool isPipModeOn = false.obs;

class MainHomeScreenController extends GetxController {
  final RxInt pageIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  void onPageChanged(page) {
    pageIndex.value = page;
  }

  void onBottomIconClick(newIndex) {
    pageIndex.value = newIndex;
    pageController.animateToPage(newIndex,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
  }

  Future showAuthBottomSheet({BuildContext? context}) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context!,
      builder: (context) {
        return const AuthBottomSheet();
      },
    );
  }

  Future showExitBottomSheet({BuildContext? context}) {
    return showDialog(
      context: context!,
      builder: (context) {
        return SizedBox(
          child: ExitBottomSheet(),
        );
      },
    );
    // showModalBottomSheet(
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(30.0),
    //       topRight: Radius.circular(30.0),
    //     ),
    //   ),
    //   context: context!,
    //   builder: (context) {
    //     return const ExitBottomSheet();
    //   },
    // );
  }
}
