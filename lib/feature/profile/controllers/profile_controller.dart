import 'dart:developer';

import 'package:socialverse/export.dart';

class ProfileController extends GetxController {
  final scrollController = ScrollController();
  final mainController = Get.put(MainHomeScreenController());
  NetworkRepository networkRepository = NetworkRepository();

  Map profileDataList = {};
  Map tempProfileList = {};
  List videoList = [];
  List tempVideoList = [];
  List likedVideoList = [];
  List bookmarkedVideoList = [];
  int tabIndex = 0;
  int sensitivity = 2;
  bool isSwipe = true;
  bool isLoading = false;
  RxInt onlyOneTime = 0.obs;
  int page = 1;
  int temppage = 1;
  String? username;
  bool? fromUser;
  // List<VideoPlayerController> myPostList = [];
  static Circle processIndicator = Circle();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  Future<dynamic> _scrollListener([context]) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      temppage++;
      getVideos(context, fromUser: fromUser, profileusername: username);
    } else {}
  }

  // getProfileDetails(context,
  //     {required fromUser, required profileusername, bool? mainUser}) async {
  //   if (!fromUser && tempProfileList.isEmpty) {
  //     tempProfileList = profileDataList;
  //   }
  //   // log("=====> ${fromUser}");
  //   profileDataList = {};
  //   dynamic response = await networkRepository.getProfileData(
  //       context: context, username: profileusername);
  //   if (response["status"] != "404") {
  //     profileDataList = response;
  //     if (fromUser && tempProfileList.isEmpty) {
  //       tempProfileList = profileDataList;
  //     }
  //     getVideos(context, fromUser: fromUser, profileusername: profileusername);
  //     update();
  //   } else {}
  // }

  // getVideos(context, {fromUser, profileusername}) async {
  //   if (!fromUser && tempVideoList.isEmpty) {
  //     tempVideoList = videoList;
  //   }
  //   isLoading = true;
  //   List temp = [];
  //   temp.clear();
  //   dynamic response = await networkRepository.getUserVideo(
  //     context: context,
  //     username: profileusername,
  //     page: page,
  //   );
  //   if (response != null) {
  //     List videoListresponse = response['posts'].reversed.toList();
  //     for (var feed in videoListresponse) {
  //       Map data = feed;
  //       temp.add(data);
  //     }
  //     videoList = temp;
  //     if (fromUser && tempVideoList.isEmpty) {
  //       tempVideoList.addAll(videoList);
  //     }
  //     isLoading = false;
  //   }
  //   update();
  // }

  getProfileDetails(
    context, {
    required fromUser,
    required profileusername,
    bool? mainUser,
  }) async {
    if (fromUser == true) {
      dynamic response = await networkRepository.getProfileData(
        context: context,
        username: profileusername,
      );
      log('my profile');
      profileDataList = response;
      videoList.isEmpty
          ? getVideos(
              context,
              profileusername: profileusername,
              fromUser: fromUser,
            )
          : null;
      update();
    } else {
      dynamic response = await networkRepository.getProfileData(
        context: context,
        username: profileusername,
      );
      log('profile');
      profileDataList = response;
      tempVideoList.isEmpty
          ? getVideos(
              context,
              profileusername: profileusername,
              fromUser: fromUser,
            )
          : null;
      update();
    }
  }

  getVideos(context, {fromUser, profileusername}) async {
    isLoading = true;
    List temp = [];
    temp.clear();
    if (fromUser == true) {
      dynamic response = await networkRepository.getUserVideo(
        context: context,
        username: profileusername,
        page: page,
      );
      List videoListresponse = response['posts'];
      for (var feed in videoListresponse) {
        Map data = feed;
        temp.add(data);
      }
      videoList.addAll(temp.reversed.toList());
    } else {
      dynamic response = await networkRepository.getUserVideo(
        context: context,
        username: profileusername,
        page: temppage,
      );
      log(response.toString());
      List videoListresponse = response['posts'];
      for (var feed in videoListresponse) {
        Map data = feed;
        temp.add(data);
      }
      tempVideoList.addAll(temp.reversed.toList());
    }
    update();
  }

  getLikeVideos(context, fromUser, profileusername) async {
    List temp = [];
    temp.clear();
    dynamic response = await networkRepository.getUserLikeVideo(
        context: context, username: profileusername);
    if (response != null) {
      List videoListresponse = response;
      for (var feed in videoListresponse) {
        Map data = feed;
        data['following'] = false;
        temp.add(data);
      }
      likedVideoList = temp.reversed.toList();
    }

    update();
  }

  getBookmarkedVideos(context, fromUser, profileusername) async {
    List temp = [];
    likedVideoList.clear();
    temp.clear();
    dynamic response = await networkRepository.getBookmarkedVideo(
        context: context, username: profileusername);
    if (response != null) {
      List videoListresponse = response;
      bookmarkedVideoList = videoListresponse;
    }

    update();
  }

  userFollow(context, fromUser, profileuser) async {
    dynamic response = await networkRepository.userFollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      profileDataList = response;
      getProfileDetails(context,
          fromUser: fromUser, profileusername: profileuser);
      // update();
    } else {
      ErrorDialog.showErrorDialog(response['message'], context);
    }
  }

  userUnfollow(context, fromUser, profileuser) async {
    dynamic response = await networkRepository.userUnfollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      profileDataList = response;
      getProfileDetails(
        context,
        fromUser: fromUser,
        profileusername: profileuser,
      );
    } else {
      ErrorDialog.showErrorDialog(response['message'], context);
    }
  }

  onChangeIndex(
    int index,
  ) {
    tabIndex = index;
    update();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    if (isSwipe) {
      isSwipe = false;
      if (details.delta.dx < 0 && tabIndex != 2) {
        tabIndex = tabIndex == 1 ? 2 : 1;
      }
      if (details.delta.dx > 0 && tabIndex != 0) {
        tabIndex = tabIndex == 1 ? 0 : 1;
      }
    }
    Timer(const Duration(milliseconds: 200), () {
      isSwipe = true;
      update();
    });
    update();
  }

  goToEditProfile(context, fromUser, profileusername) {
    Get.to(
      () => EditProfileScreen(
        name: profileDataList["first_name"],
        profile: profileDataList["profile_picture_url"],
        lastname: profileDataList["last_name"],
        username: profileDataList["username"],
        bio: profileDataList["bio"],
        tiktok: profileDataList["tiktok_url"],
        youtube: profileDataList["youtube_url"],
        instagram: profileDataList["instagram_url"],
        website: profileDataList["website"],
      ),
    )?.then((value) {
      if (value == true) {
        getProfileDetails(context,
            fromUser: fromUser, profileusername: profileusername);
      }

      update();
    });
  }

  followUser(context, fromUser, profileUsername) {
    if (dataStorage.read('isLogging') != true) {
      mainController.showAuthBottomSheet(context: context);
    } else {
      if (profileDataList["is_following"] != true) {
        userFollow(context, fromUser, profileUsername);
      } else {
        userUnfollow(context, fromUser, profileUsername);
      }
    }
  }
}
