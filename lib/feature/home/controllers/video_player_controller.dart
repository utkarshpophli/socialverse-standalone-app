import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialverse/export.dart';
import 'package:path/path.dart';

class CommonVideoPlayerController extends GetxController {
  bool isSwipe = false;
  RxBool isPlaying = true.obs;
  RxBool isSize = false.obs;

  // RxInt updatePogress = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isHeartAnimating = false.obs;
  RxBool isPinch = false.obs;
  RxBool isAutoplay = true.obs;

  RxBool isViewMode = false.obs;
  RxBool isViewOn = true.obs;

  List postByUser = [];
  List<String> videoList = [];

  RxInt currentIndex = 0.obs;

  bool downloading = false;
  bool downloadingCompleted = false;
  var progressString = "";

  Future<void> saveDownloadedVideoToGallery({required String videoPath}) async {
    await ImageGallerySaver.saveFile(videoPath);
    log("Video Saved to Gallery");
  }

  Future<void> removeDownloadedVideo({required String videoPath}) async {
    try {
      Directory(videoPath).deleteSync(recursive: true);
      log("Video Deleted from App Directory");
    } catch (error) {
      debugPrint('$error');
      log(error.toString());
    }
  }

  Future<void> downloadFile({
    required String videoUrl,
    required String title,
  }) async {
    Dio dio = Dio();
    try {
      var dir;
      if (Platform.isAndroid) {
        dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
      log("path ${Platform.isIOS ? dir : dir.path}");

      final String videoPath = join(
        dir.path,
        '$title.mp4',
      );

      await dio.download(
        videoUrl,
        videoPath,
        onReceiveProgress: (rec, total) {
          debugPrint("Rec: $rec , Total: $total");
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          update();
        },
      );

      await saveDownloadedVideoToGallery(videoPath: videoPath);
      await removeDownloadedVideo(videoPath: videoPath);
    } catch (e) {
      debugPrint(e.toString());
    }
    downloading = false;
    downloadingCompleted = true;
    progressString = "Completed";
    update();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        downloadingCompleted = false;
        update();
        // File file = File('${dir}/' + '${title}' + '.mp4');
        // Share.shareFiles([
        //   file.path,
        // ], text: 'Share Video');
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

  Future<void> postLikeAdd({required postID}) async {
    await networkRepository.postLike(postID: '${postID}');
  }

  Future<void> postLikeRemove({required postID}) async {
    await networkRepository.postLikeRemove(postID: '${postID}');
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

    if (response != null) {
      HapticFeedback.mediumImpact();
      floatingScaffold(Get.context, message: 'Added to favorites');
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(Get.context,
          message: 'Error adding to favorites, Please try again');
    }
  }

  Future<void> postBookmarkRemove(context,
      {required identifier, required slug, dynamic like}) async {
    var response = await networkRepository.postBookmarkRemove(
      identifier: identifier,
      slug: slug,
    );

    if (response != null) {
      HapticFeedback.mediumImpact();
      floatingScaffold(Get.context, message: 'Removed from favorites');
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(Get.context,
          message: 'Error removing from favorites, Please try again');
    }
  }

  Future<void> postDelete(context,
      {required identifier, required slug, dynamic like}) async {
    var response = await networkRepository.deletePost(
      identifier: identifier,
      slug: slug,
    );
    if (response != null && response['status'] == 'success') {
      Get.back();
      HapticFeedback.mediumImpact();
      update();
      floatingScaffold(context, message: 'Post deleted');
    } else {
      Get.back();
      HapticFeedback.mediumImpact();
      floatingScaffold(context,
          message: 'Error deleting post, Please try again');
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
  //     //todo manage here
  //     videoController(currentIndex.value)?.pause();
  //     // videoPlayerController?.value.pause();
  //     pipFlutterPlayerController.value.play();
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

  getPostByUser(context, id) async {
    print("Called get post");
    final response =
        await networkRepository.getSpherePosts(context: context, id: id);
    if (response != null && response["posts"].isNotEmpty) {
      postByUser = response["posts"].reversed.toList();
    } else {
      postByUser.clear();
    }
  }

  spheresOnTap(
    BuildContext context, {
    required String name,
    String? desc,
    required int id,
    required int count,
    String? photourl,
    required Function() callBack,
  }) async {
    log("onTap");
    floatingScaffold(context, message: "Browsing posts in $name Subverse");
    await getPostByUser(context, id.toString());
    if (postByUser.isNotEmpty) {
      await Get.to(
        () => CategoryScreen(
          categoryname: name,
          categorydesc: desc == null ? "" : desc,
          categorycount: count,
          fromVideoPlayer: true,
          categoryid: id,
          categoryphoto: photourl == null ? "" : photourl,
        ),
      )?.then((value) {
        print("Call back called");
        callBack();
      });
    }
  }

  floatingScaffold(
    context, {
    required String message,
    Duration? duration,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: duration ?? const Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: Get.height * 0.105,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Map<String, VideoPlayerController> videoControllers = {};
  Map<int, VoidCallback> videoListeners = {};

  initController(int index, List<String> videosList) {
    videoControllers = {};
    videoListeners = {};
    videoList = videosList;
    isPlaying.value = true;
    if (videosList.isNotEmpty) {
      _initController(index).then((_) {
        _playController(index);
      });
    }

    if (index == 0) {
      if (videosList.length > 1) {
        _initController(1);
      }
    } else if (index == (videosList.length - 1)) {
      _initController(index - 1);
    } else {
      _initController(index - 1);
      _initController(index + 1);
    }
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      if (videoController(index)?.value.hasError == true) {
        log(videoController(index)?.value.errorDescription ?? '');
      }
      update();
    };
  }

  VideoPlayerController? videoController(int index) {
    return videoControllers[videoList.elementAt(index)];
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(videoList.elementAt(index));
    videoControllers[videoList.elementAt(index)] = controller;
    await controller.initialize();
    //update();
  }

  void _removeController(int index) {
    videoController(index)?.dispose();
    videoControllers.remove(videoList.elementAt(index));
    videoListeners.remove(index);
  }

  void _stopController(int index) {
    if (videoListeners[index] != null) {
      videoController(index)?.removeListener(videoListeners[index]!);
    }
    videoController(index)?.pause();
    videoController(index)?.seekTo(const Duration(milliseconds: 0));
  }

  void _playController(int index) async {
    if (!videoListeners.keys.contains(index)) {
      videoListeners[index] = _listenerSpawner(index);
    }
    update();
    videoController(index)?.addListener(videoListeners[index]!);
    log("video initiated in video widget");
    if (isPlaying.value) {
      await videoController(index)?.play();
      log("video played in video widget");
      await videoController(index)!.setLooping(true);
    }
    //update();
  }

  void previousVideo() {
    _stopController(currentIndex.value);
    update();

    if (currentIndex.value + 1 < videoList.length) {
      _removeController(currentIndex.value + 1);
    }

    _playController(--currentIndex.value);
    update();

    _initController(currentIndex.value - 1);
    update();
  }

  void nextVideo() async {
    _stopController(currentIndex.value);
    update();

    if (currentIndex.value - 1 >= 0) {
      _removeController(currentIndex.value - 1);
    }

    _playController(++currentIndex.value);
    update();

    _initController(currentIndex.value + 1);
    update();
  }
}
