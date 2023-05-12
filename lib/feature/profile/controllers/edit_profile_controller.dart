import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';

class EditProfileController extends GetxController {
  final NetworkRepository networkRepository = NetworkRepository();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController instagramUrlController = TextEditingController();
  TextEditingController youtubeUrlController = TextEditingController();
  TextEditingController tiktokUrlController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  ProfileController profileController = ProfileController();
  // int textCount = 0;

  XFile? profileImage;

  File? image;
  String imagePath = '';
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
      print(imagePath);
      update();
    } else {
      print('No image selected.');
    }
  }

  onTextChanged(String text) {
    // textCount = text.toString().length;
    update();
  }

  updateprofile(context) async {
    Map data = {
      "first_name": firstNameController.text.toString().trim(),
      "last_name": lastNameController.text.toString().trim(),
      "username": userNameController.text.toString().trim(),
      "bio": bioController.text.toString().trim(),
      "youtube_url": youtubeUrlController.text.toString() == ""
          ? ""
          : youtubeUrlController.text.toString().trim(),
      "tiktok_url": tiktokUrlController.text.toString() == ""
          ? ""
          : tiktokUrlController.text.toString().trim(),
      "instagram_url": instagramUrlController.text.toString() == ""
          ? ""
          : instagramUrlController.text.toString().trim(),
      "website": websiteUrlController.text.toString() == ""
          ? ""
          : websiteUrlController.text.toString().trim(),
    };
    dynamic response = await networkRepository.getProfileUpdate(context, data);
    if (response["status"] == "success") {
      floatingScaffold(
        context,
        message: 'Saved',
        height: Platform.isAndroid ? Get.height * 0.13 : Get.height * 0.12,
      );
      Get.back(result: true);
      update();
    } else {
      log(response.toString());
      floatingScaffold(
        context,
        message: response['message'],
        height: Platform.isIOS ? Get.height * 0.13 : Get.height * 0.12,
      );
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
