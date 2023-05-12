import '../../../export.dart';

class CreateSphereController extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  bool isPublic = false;
  final GlobalKey<PopupMenuButtonState<int>> globalKey = GlobalKey();
  NetworkRepository networkRepository = NetworkRepository();
  bool comments = false;
  CroppedFile? pickedImage;
  bool isUploading = false;

  createSphere(context) async {
    isUploading = true;
    update();
    Map data = {
      "category_name": nameController.text,
      // "category_description": descriptionController.text,
    };
    dynamic response = await networkRepository.createSphere(context, data);
    if (response != null) {
      isUploading = false;
      Get.back();
      // floatingScaffold(
      //   Get.context,
      //   message: 'Sphere created',
      //   height: Platform.isIOS ? Get.height * 0.10 : Get.height * 0.12,
      // );
      update();
    } else {
      isUploading = false;
      Get.back();
      // floatingScaffold(
      //   Get.context,
      //   message: 'Sphere already exists',
      //   height: Platform.isIOS ? Get.height * 0.10 : Get.height * 0.12,
      // );
      update();
    }
  }

  floatingScaffold(
    context, {
    required String message,
    double? height,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: height!,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
