import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';

class FollowingController extends GetxController {
  final MainHomeScreenController _mainHomeScreenController = Get.put(
    MainHomeScreenController(),
  );
  NetworkRepository networkRepository = NetworkRepository();
  TextEditingController searchController = TextEditingController();
  List followingList = [];
  int? index;

  getFollowing(BuildContext context, String? userName) async {
    String profileName = userName ?? dataStorage.read("username");

    final response = await networkRepository.getFollowing(
        context: context, username: profileName);
    if (response != null) {
      followingList = response;
      log(followingList.toString());
    } else {
      log(response.toString());
    }
    update();
  }

  followUser({context, profileUsername, isFollowing, username}) {
    if (dataStorage.read('isLogging') != true) {
      _mainHomeScreenController.showAuthBottomSheet(
        context: context,
      );
    } else {
      if (followingList[index!]["is_following"] != false) {
        userFollow(context, profileUsername, username);
      } else {
        userUnfollow(context, profileUsername, username);
      }
    }
  }

  userFollow(context, profileuser, username) async {
    dynamic response = await networkRepository.userFollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      log(response.toString());
      update();
    } else {
      floatingScaffold(context, message: response['message']);
    }
  }

  userUnfollow(context, profileuser, username) async {
    dynamic response = await networkRepository.userUnfollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      log(response.toString());
      update();
    } else {
      floatingScaffold(context, message: response['message']);
    }
  }

  floatingScaffold(
    context, {
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: Platform.isIOS ? Get.height * 0.06 : Get.height * 0.04,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
