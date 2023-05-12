import 'dart:developer';
import 'package:socialverse/export.dart';

class FollowerController extends GetxController {
  final MainHomeScreenController _mainHomeScreenController = Get.put(
    MainHomeScreenController(),
  );
  NetworkRepository networkRepository = NetworkRepository();
  TextEditingController searchController = TextEditingController();
  List followersList = [];

  getfollowers(context, userName) async {
    String profileName = userName ?? dataStorage.read("username");
    final response = await networkRepository.getFollowers(
        context: context, username: profileName);
    if (response != null) {
      followersList = response;
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
      if (isFollowing == false) {
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
      ErrorDialog.showErrorDialog(response['message'], context);
    }
  }

  userUnfollow(context, profileuser, username) async {
    dynamic response = await networkRepository.userUnfollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      log(response.toString());
      update();
    } else {
      ErrorDialog.showErrorDialog(response['message'], context);
    }
  }
}
