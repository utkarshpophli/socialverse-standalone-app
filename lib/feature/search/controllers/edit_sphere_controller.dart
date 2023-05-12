import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as di;
import '../../../export.dart';

class EditSphereController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  TextEditingController sphereController = TextEditingController();
  TextEditingController editSphereController = TextEditingController();
  bool isPublic = false;
  final GlobalKey<PopupMenuButtonState<int>> globalKey = GlobalKey();
  NetworkRepository networkRepository = NetworkRepository();
  bool comments = false;
  bool isUploading = false;
  CroppedFile? selectedImage;

  selectPostImage(BuildContext context) async {
    final pickedFile = await ImageHelper.pickedImageFromGallery(
      context: context,
      cropStyle: CropStyle.rectangle,
    );

    if (pickedFile != null) {
      selectedImage = pickedFile;
    }
    update();
  }

  Future<dynamic> uploadCategoriesImage(context, {required id}) async {
    isUploading = true;
    update();
    String fileName = selectedImage!.path.split('/').last;

    var formData = di.FormData.fromMap({
      "file": await di.MultipartFile.fromFile(
        selectedImage!.path,
        filename: fileName,
      ),
    });
    // Map data = {
    //   "file": await di.MultipartFile.fromFile(
    //     selectedImage!.path,
    //     filename: fileName,
    //   ),
    // };
    dynamic response = await networkRepository.uploadCategoryImage(
      id: id,
      data: formData,
    );

    if (response != null) {
      isUploading = false;
      log('true');
      Get.back();
      // floatingScaffold(context, message: 'Sucessfully uploaded');
      update();
    } else {
      Get.back();
      log('false');
      // floatingScaffold(context, message: 'Something went wrong');
    }
  }

  updateCategoryDescription(context, id) async {
    isUploading = true;
    update();
    Map data = {
      "description": editSphereController.text,
    };
    dynamic response = await networkRepository.updateCategoryDescription(
        id: id, data: data, text: editSphereController.text);
    if (response != null) {
      isUploading = false;
      Get.back();
      floatingScaffold(
        Get.context,
        message: 'Sphere has been updated',
        height: Platform.isIOS ? Get.height * 0.14 : Get.height * 0.12,
      );
      update();
    } else {
      isUploading = false;
      Get.back();
      floatingScaffold(
        Get.context,
        message: 'Something went wrong',
        height: Platform.isIOS ? Get.height * 0.14 : Get.height * 0.12,
      );
      update();
    }
  }

  floatingScaffold(
    context, {
    required String message,
    required double height,
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
          bottom: height,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
