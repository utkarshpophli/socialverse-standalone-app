import 'package:socialverse/export.dart';

class ManageAccountAcontroller extends GetxController {
  Map profileDataList = {};

  NetworkRepository networkRepository = NetworkRepository();

  getPofileDetails(context, fromUser, profileusername) async {
    profileDataList = {};
    dynamic response = await networkRepository.getProfileData(
        context: context, username: profileusername);
    if (response["status"] != "404") {
      profileDataList = response;
      update();
    } else {}
  }

  goToEditProfile(context, fromUser, profileusername) {
    Get.to(
      () => EditProfileScreen(
        name: profileDataList["first_name"],
        profile: profileDataList["profile_picture_url"],
        lastname: profileDataList["last_name"],
        username: profileDataList["username"],
        bio: profileDataList["bio"],
        instagram: profileDataList["instagram_url"],
        tiktok: profileDataList["tiktok_url"],
        youtube: profileDataList["youtube_url"],
        website: profileDataList["website"],
      ),
    )?.then((value) {
      if (value == true) {
        getPofileDetails(context, fromUser, profileusername);
      }
      update();
    });
  }
}
