import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialverse/export.dart';

class SubscribedVideoPlayerController extends GetxController {
  bool isSwipe = false;
  RxBool isPlaying = true.obs;
  RxInt currentVideoIndex = 0.obs;
  RxBool isSize = false.obs;
  RxBool isViewOn = true.obs;

  //ignore:unused
  double _position = 0;
  double _buffer = 0;
  bool _lock = true;

  // RxInt updatePogress = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isBookmarked = false.obs;
  RxBool isHeartAnimating = false.obs;
  RxBool isPinch = false.obs;
  RxBool isAutoplay = true.obs;
  PageController pageController = PageController(initialPage: 0);

  RxBool isViewMode = false.obs;

  List postByUser = [];

  late final homeController = Get.put(HomeController());
  bool downloading = false;
  bool downloadingCompleted = false;
  var progressString = "";

  Future<void> downloadFile(
      {required String videoUrl, required String title}) async {
    Dio dio = Dio();
    try {
      var dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
      log("path ${Platform.isIOS ? dir : dir.path}");
      await dio.download(
          videoUrl,
          Platform.isIOS
              ? '${dir.path}/' + '${title}' + '.mp4'
              : '${dir.path}/$title.mp4', onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        downloading = true;
        progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        update();
      });
    } catch (e) {
      print(e);
    }
    downloading = false;
    downloadingCompleted = true;
    progressString = "Completed";
    update();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        downloadingCompleted = false;
        update();
        var dir;
        if (Platform.isAndroid) {
          dir = Directory('/storage/emulated/0/Download');
        } else {
          dir = getApplicationDocumentsDirectory();
        }
        File file = File('${dir}/' + '${title}' + '.mp4');
        Share.shareFiles([
          file.path,
        ], text: 'Share Video');
        // print(
        //   "File Saved to App Documentary",
        // );
      },
    );
    log("Download completed");
    update();
  }

  // late Rx<PipFlutterPlayerController> pipFlutterPlayerController =
  //     PipFlutterPlayerController(
  //   const PipFlutterPlayerConfiguration(
  //     aspectRatio: 9 / 16,
  //     fit: BoxFit.contain,
  //     // autoPlay: true,
  //     deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
  //     deviceOrientationsOnFullScreen: [DeviceOrientation.portraitUp],
  //   ),
  // ).obs;
  // final GlobalKey<State<StatefulWidget>> pipFlutterPlayerKey =
  //     GlobalKey<State<StatefulWidget>>();
  NetworkRepository networkRepository = NetworkRepository();

  Future<void> postLikeAdd({
    required identifier,
    required slug,
    dynamic like,
  }) async {
    // await networkRepository.postLike(
    //   identifier: identifier,
    //   slug: slug,
    // );
  }

  Future<void> postLikeRemove({
    required identifier,
    required slug,
    dynamic like,
  }) async {
    // await networkRepository.postLikeRemove(
    //   identifier: identifier,
    //   slug: slug,
    // );
  }

  Future<void> postBookmarkAdd(
    context, {
    required identifier,
    required slug,
    dynamic like,
  }) async {
    var response = await networkRepository.postBookmark(
      identifier: identifier,
      slug: slug,
    );

    if (response != null && response['body']['status'] == 'success') {
      HapticFeedback.mediumImpact();
      floatingScaffold(context, message: 'Added to favorites');
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(context,
          message: 'Error adding to favorites, Please try again');
    }
  }

  Future<void> postBookmarkRemove(context,
      {required identifier, required slug, dynamic like}) async {
    var response = await networkRepository.postBookmarkRemove(
      identifier: identifier,
      slug: slug,
    );

    if (response != null && response['body']['status'] == 'success') {
      HapticFeedback.mediumImpact();
      floatingScaffold(context, message: 'Removed from favorites');
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(context,
          message: 'Error removing from favorites, Please try again');
    }
  }

  // Future<void> permissionHandler() async {
  //   Permission status = await Permission.systemAlertWindow;

  //   if (status.isDenied == true) {
  //     await [
  //       Permission.systemAlertWindow,
  //     ].request().then((value) async {});
  //     update();
  //   } else {
  //     pipFlutterPlayerController.value
  //         .enablePictureInPicture(pipFlutterPlayerKey);
  //     isPlaying.value = false;
  //     videoController(currentVideoIndex.value)?.pause();
  //     // pipFlutterPlayerController.value.play();
  //     if (Platform.isIOS) {
  //       Timer(const Duration(seconds: 1), () {
  //         MoveToBackground.moveTaskToBack();
  //       });
  //     }
  //   }
  // }

  Future<void> userFollow(context, profileuser) async {
    dynamic response = await networkRepository.userFollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      log(response.toString());
    } else {
      floatingScaffold(context, message: response['message']);
    }
  }

  Future<void> userUnfollow(context, profileuser) async {
    dynamic response = await networkRepository.userUnfollow(
        context: context, username: profileuser.toString());
    if (response["status"] != "404") {
      log(response.toString());
    } else {
      floatingScaffold(context, message: response['message']);
    }
  }

  void followUser(context, profileUsername, isFollowing) {
    if (dataStorage.read('isLogging') != true) {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          context: context,
          builder: (context) {
            return const AuthBottomSheet();
          });
    } else {
      if (isFollowing != true) {
        userFollow(context, profileUsername);
        HapticFeedback.mediumImpact();
        floatingScaffold(
          context,
          message: "Subscribed to ${profileUsername}",
        );
      } else {
        userUnfollow(context, profileUsername);
        HapticFeedback.mediumImpact();
        floatingScaffold(
          context,
          message: "Unsubscribed from ${profileUsername}",
        );
      }
    }
  }

  getSpherePosts(context, id) async {
    final response =
        await networkRepository.getSpherePosts(context: context, id: id);
    if (response != null && response["posts"].isNotEmpty) {
      postByUser = response["posts"].reversed.toList();
    } else {
      postByUser.clear();
    }
    update();
  }

  spheresOnTap(
    BuildContext context, {
    required String name,
    String? desc,
    required int id,
    required int count,
    String? photourl,
  }) async {
    await getSpherePosts(context, id.toString());
    if (postByUser.isNotEmpty) {
      Get.to(
        () => VideoPlayerWidget(
          videoIndex: 0,
          videosList: postByUser.obs,
          pageController: pageController.obs,
          fromHomePage: false,
          fromSearchPage: true,
        ),
      );
    }
  }

  browseSpheresOnTap(
    BuildContext context, {
    required String name,
    String? desc,
    required int id,
    required int count,
    String? photourl,
  }) async {
    await getSpherePosts(context, id.toString());
    if (postByUser.isNotEmpty) {
      Get.to(
        () => CategoryScreen(
          categoryname: name,
          categorydesc: desc == null ? "" : desc,
          categorycount: count,
          fromVideoPlayer: true,
          categoryid: id,
          categoryphoto: photourl == null ? "" : photourl,
        ),
      );
    }
  }

  floatingScaffold(context, {required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: Platform.isIOS ? Get.height * 0.085 : Get.height * 0.125,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  final Map<String, VideoPlayerController> _controllers = {};
  final Map<int, VoidCallback> _listeners = {};

  initializedVideoPlayer(String videoURL) async {
    if (homeController.feedPostList.isNotEmpty) {
      currentVideoIndex.value = 0;
      isPlaying.value = true;
      _initController(0).then((_) {
        _playController(0);
      });
    }

    if (homeController.feedPostList.length > 1) {
      _initController(1).whenComplete(() => _lock = false);
    }
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(
      homeController.feedPostList.elementAt(index)["video_link"],
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );
    _controllers[homeController.feedPostList.elementAt(index)["video_link"]] =
        controller;
    await controller.initialize();
  }

  void _playController(int index) async {
    if (!_listeners.keys.contains(index)) {
      _listeners[index] = _listenerSpawner(index);
    }
    videoController(index)?.addListener(_listeners[index]!);
    log("video initiated ;-; ");
    if (isPlaying.value) {
      await videoController(index)?.play();
      log("video played ;-; ");
      await videoController(index)!.setLooping(true);
    }
    isPlaying = true.obs;
    update();
  }

  VideoPlayerController? videoController(int index) {
    return _controllers[
        homeController.feedPostList.elementAt(index)["video_link"]];
  }

  void disposed(index) {
    videoController(index)?.dispose();
    _controllers.remove(homeController.feedPostList.elementAt(index));
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      if (videoController(index)?.value.hasError == true) {
        // Fluttertoast.showToast(msg: "Video has Error");
        print(videoController(index)?.value.errorDescription);
      }
      update();
    };
  }

  Future<void> _nextVideo() async {
    if (currentVideoIndex.value == homeController.feedPostList.length - 1) {
      print("locked 1");
      return;
    }
    _lock = true;

    _stopController(currentVideoIndex.value);

    if (currentVideoIndex.value - 1 >= 0) {
      _removeController(currentVideoIndex.value - 1);
    }

    _playController(++currentVideoIndex.value);

    if (currentVideoIndex.value == homeController.feedPostList.length - 1) {
      _lock = false;
    } else {
      _initController(currentVideoIndex.value + 1)
          .whenComplete(() => _lock = false);
    }
  }

  Future<void> _previousVideo() async {
    if (currentVideoIndex.value == 0) {
      print("locked 2");

      _controllers.forEach((key, value) {
        log("$key : $value");
      });
      log("total controllers ${_controllers.length}");
      log("current video index ${currentVideoIndex.value}");
      return;
    }
    _lock = true;

    _stopController(currentVideoIndex.value);

    if (currentVideoIndex.value + 1 < homeController.feedPostList.length) {
      _removeController(currentVideoIndex.value + 1);
    }

    _playController(--currentVideoIndex.value);

    if (currentVideoIndex.value == 0) {
      _lock = false;
    } else {
      _initController(currentVideoIndex.value - 1)
          .whenComplete(() => _lock = false);
    }
  }

  void _stopController(int index) {
    if (_listeners[index] != null) {
      videoController(index)?.removeListener(_listeners[index]!);
    }
    videoController(index)?.pause();
    videoController(index)?.seekTo(const Duration(milliseconds: 0));
  }

  void _removeController(int index) {
    videoController(index)?.dispose();
    _controllers.remove(homeController.feedPostList.elementAt(index));
    _listeners.remove(index);
  }

  onPageChanged(int index) async {
    isPlaying.value = true;
    update();

    if (currentVideoIndex.value > index) {
      log("previous video called");
      await _previousVideo();
      currentVideoIndex.value = index;
      update();
    } else {
      log("next video called");
      await _nextVideo();
      currentVideoIndex.value = index;
      update();
    }
    update();
    log("lllllll--;");
    log("${(homeController.feedPostList.length) - 3}--${currentVideoIndex.value};");
    if (((homeController.feedPostList.length) - 3) == currentVideoIndex.value) {
      homeController.page++;
      homeController.update();
      await homeController.getFeedList(null);
    }
  }
}
