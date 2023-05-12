import 'dart:developer';
import 'package:socialverse/export.dart';

class HomeController extends GetxController {
  NetworkRepository networkRepository = NetworkRepository();

  int page = 1;
  int sub = 1;

  RxList feedPostList = [].obs;
  RxList subscribedList = [].obs;
  PageController pageController = PageController();
  TextEditingController commentController = TextEditingController();

  final HomeCommonVideoPlayerController homeVideoController = Get.put(
    HomeCommonVideoPlayerController(),
  );

  // final SubscribedCommonVideoPlayerController subsribedVideoController =
  //     Get.put(
  //   SubscribedCommonVideoPlayerController(),
  // );

  int videoIndex = 0;
  // bool paginating = false;
  bool isSubscribed = false;

  @override
  void onInit() {
    // pageController = PageController()..addListener(_scrollListener);
    feedPostList.clear();
    // subscribedList.clear();
    super.onInit();
  }

  getFeedList([context]) async {
    feedPostList.clear();
    try {
      final response = await networkRepository.getSpherePosts(
        context: context,
        id: "123",
        page: '1',
      );
      if (response != null) {
        // log('API RESPONSE: ${response}');
        feedPostList.addAll(
          response['posts'].reversed.toList(),
        );
        update();
      } else {}
    } on Exception {}
  }

  onSubscribed(int value) async {
    isSubscribed = true;

    if (homeVideoController
            .videoController(homeVideoController.currentVideoIndex.value)
            ?.value
            .isPlaying ==
        true) {
      homeVideoController.isPlaying.value = false;
      homeVideoController
          .videoController(homeVideoController.currentVideoIndex.value)
          ?.pause();
    } else {}

    update();
  }

  onRefresh(int feedValue) async {
    page = feedValue;
    // sub = subvalue;
    pageController = PageController()..addListener(_scrollListener);
    homeVideoController.disposed(homeVideoController.currentVideoIndex.value);
    feedPostList.clear();
    // subscribedtList.clear();

    await getFeedList();
    // await getSubscribedList();

    await homeVideoController
        .initializedVideoPlayer(feedPostList[0]["video_link"]);
    // await subsribedVideoController
    //     .initializePlayer(subscribedtList[0]["video_link"]);
  }

  Future<dynamic> _scrollListener([context]) async {
    try {
      if (pageController.offset >= pageController.position.maxScrollExtent &&
          !pageController.position.outOfRange) {
        page++;
        var response =
            await networkRepository.getFeedpost(index: page, context: context);
        if (response != null) {
          feedPostList.addAll(response['posts']);
          update();
        } else {}
        final RxList updatedFeedPostList = response;
        feedPostList = updatedFeedPostList;
      } else {}
    } on Exception {}
    return feedPostList;
  }
}
