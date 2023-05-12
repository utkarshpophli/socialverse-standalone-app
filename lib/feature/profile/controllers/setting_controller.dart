import 'package:socialverse/export.dart';

class SettingController extends GetxController {
  Map profileDataList = {};

  NetworkRepository networkRepository = NetworkRepository();

  final loginController = LoginController();

  logout(context) async {
    dynamic response = await networkRepository.logout(context: context);
    print('\x1b[97m LogOut : $response');
    if (response["status"] != "404") {
      // Purchases.logOut();
      dataStorage.erase();
      dataStorage.remove('token');
      dataStorage.write("isWelcome", true);
      Get.offAll(() => LoginScreen());
    } else {}
  }

  logOutApple() {
    loginController.signOutApple();
    dataStorage.erase();
    dataStorage.remove('token');
    dataStorage.write("isWelcome", true);
    Get.offAll(() => LoginScreen());
  }

  logOutGoogle() {
    loginController.signOutGoogle();
    dataStorage.erase();
    dataStorage.remove('token');
    dataStorage.write("isWelcome", true);
    Get.offAll(() => LoginScreen());
  }

  getPofileDetails(context, fromUser, profileusername) async {
    profileDataList = {};
    dynamic response = await networkRepository.getProfileData(
        context: context, username: profileusername);
    if (response["status"] != "404") {
      profileDataList = response;
      update();
    } else {}
  }
}
