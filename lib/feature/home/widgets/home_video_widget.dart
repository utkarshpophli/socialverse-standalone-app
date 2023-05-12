// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:expandable_text/expandable_text.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/feature/home/extension/custom_physics.dart';
import 'home_comment_widget.dart';

class HomeVideoWidget extends StatefulWidget {
  RxList videosList = [].obs;
  final bool fromHomePage;
  final int videoIndex;
  final Rx<PageController> pageController;

  HomeVideoWidget(
      {Key? key,
      required this.videoIndex,
      required this.videosList,
      required this.fromHomePage,
      required this.pageController})
      : super(key: key);

  @override
  _HomeVideoWidgetState createState() => _HomeVideoWidgetState();
}

class _HomeVideoWidgetState extends State<HomeVideoWidget> {
  final HomeController homeController = Get.put(HomeController());
  final HomeCommonVideoPlayerController _controller = Get.put(
    HomeCommonVideoPlayerController(),
  );
  final MainHomeScreenController _mainHomeScreenController = Get.put(
    MainHomeScreenController(),
  );

  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GetBuilder<HomeCommonVideoPlayerController>(
            initState: (state) async {
              _controller.isAutoplay.value = true;
              currentIndex.value = widget.videoIndex;
              await _controller.initializedVideoPlayer(
                widget.videosList[widget.videoIndex]["video_link"],
              );
            },
            dispose: (state) {
              _controller.isAutoplay.value = false;
              _controller.isPlaying.value = false;
            },
            builder: (_) {
              bool theme = dataStorage.read("isDarkMode");
              return AnimatedContainer(
                height:
                    _controller.isSize.value ? Get.height * 0.3 : Get.height,
                padding: _controller.isSize.value
                    ? EdgeInsets.only(
                        top: MediaQuery.of(context).viewPadding.top)
                    : const EdgeInsets.all(0),
                width: Get.width,
                transformAlignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 300),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        transformAlignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 300),
                        height: Get.height,
                        width: Get.width,
                        child: PageView.builder(
                          controller: widget.pageController.value,
                          onPageChanged: (index) {
                            // homeController.page++;
                            // homeController.getFeedList(context);
                            _controller.onPageChanged(index, context);
                            currentIndex.value = index;
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: widget.videosList.length,
                          physics: CustomPageViewScrollPhysics(),
                          itemBuilder: (context, i) {
                            return
                                // _controller.pipFlutterPlayerController.value
                                //         .isFullScreen
                                //     ? Stack(
                                //         children: [
                                //           Container(
                                //             height: 1,
                                //             width: 1,
                                //             color: purpleColor,
                                //             child: PipFlutterPlayer(
                                //               controller: _controller
                                //                   .pipFlutterPlayerController.value,
                                //               key: _controller.pipFlutterPlayerKey,
                                //             ),
                                //           ),
                                //           VideoPlayer(
                                //             _controller.videoController(i)!,
                                //           )
                                //         ],
                                //       )
                                //     :
                                InkWell(
                              onTap: () {
                                if (_controller.isSize.value) {
                                  _controller.isSize.value = false;
                                } else {
                                  if (_controller
                                      .videoController(i)!
                                      .value
                                      .isPlaying) {
                                    _controller.isPlaying.value = false;
                                    _controller.videoController(i)!.pause();
                                  } else {
                                    _controller.isPlaying.value = true;
                                    _controller.videoController(i)!.play();
                                  }
                                }
                                // videoPlayerGetXController.update();
                              },
                              onLongPress: () {
                                showModalBottomSheet(
                                  backgroundColor: primaryBlack,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return MoreBottomSheet(
                                      // sphere: Column(
                                      //   children: [
                                      //     if (widget
                                      //         .videosList[i]["category"]
                                      //         .isNotEmpty)
                                      //       widget.videosList[i][
                                      //                           "category"]
                                      //                       ["name"] !=
                                      //                   "Uncategorized" &&
                                      //               widget.videosList[i][
                                      //                           "category"]
                                      //                       ["name"] !=
                                      //                   ""
                                      //           ? Column(
                                      //               children: [
                                      //                 InkWell(
                                      //                   onTap: () {
                                      //                     log("tap");
                                      //                     HapticFeedback
                                      //                         .mediumImpact();
                                      //                     _controller
                                      //                         .browseSpheresOnTap(
                                      //                       context,
                                      //                       name: widget.videosList[
                                      //                                   i]
                                      //                               [
                                      //                               "category"]
                                      //                           ["name"],
                                      //                       desc: widget.videosList[
                                      //                                   i]
                                      //                               [
                                      //                               "category"]
                                      //                           [
                                      //                           "description"],
                                      //                       id: widget.videosList[
                                      //                                   i]
                                      //                               [
                                      //                               "category"]
                                      //                           ["id"],
                                      //                       count: widget.videosList[
                                      //                                   i]
                                      //                               [
                                      //                               "category"]
                                      //                           ["count"],
                                      //                       photourl: widget
                                      //                                   .videosList[i]
                                      //                               [
                                      //                               "category"]
                                      //                           [
                                      //                           "image_url"],
                                      //                     );
                                      //                     if (_controller
                                      //                                 .videoController(
                                      //                                     i)!
                                      //                                 .value
                                      //                                 .isPlaying ==
                                      //                             true ||
                                      //                         _controller
                                      //                                 .videoController(i)!
                                      //                                 .value
                                      //                                 .isPlaying ==
                                      //                             false) {
                                      //                       _controller
                                      //                           .isPlaying
                                      //                           .value = false;
                                      //                       _controller
                                      //                           .isPlaying
                                      //                           .value = false;
                                      //                       _controller
                                      //                           .videoController(
                                      //                               i)!
                                      //                           .pause();
                                      //                     } else {
                                      //                       //
                                      //                     }
                                      //                     Navigator.pop(
                                      //                         context);
                                      //                   },
                                      //                   child: Row(
                                      //                     mainAxisAlignment:
                                      //                         MainAxisAlignment
                                      //                             .start,
                                      //                     crossAxisAlignment:
                                      //                         CrossAxisAlignment
                                      //                             .center,
                                      //                     children: [
                                      //                       SvgPicture
                                      //                           .asset(
                                      //                         AppAsset
                                      //                             .sphereLogo,
                                      //                         height: 18,
                                      //                         width: 18,
                                      //                         color: Theme.of(
                                      //                                 context)
                                      //                             .errorColor,
                                      //                       ),
                                      //                       width05,
                                      //                       Text(
                                      //                         'Browse Subverse',
                                      //                         style: Theme.of(
                                      //                                 context)
                                      //                             .textTheme
                                      //                             .bodySmall!
                                      //                             .copyWith(
                                      //                               fontSize:
                                      //                                   18,
                                      //                             ),
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //                 height5,
                                      //                 const Divider(
                                      //                     color: grey,
                                      //                     thickness: 0.1),
                                      //                 height5,
                                      //               ],
                                      //             )
                                      //           : const SizedBox()
                                      //   ],
                                      // ),
                                      videoLink:
                                          widget.videosList[currentIndex.value]
                                              ["video_link"],
                                      onSaveVideoTap: () async {
                                        Get.back();
                                        _controller.downloadFile(
                                          title: widget.videosList[
                                              currentIndex.value]["identifier"],
                                          videoUrl: widget.videosList[
                                              currentIndex.value]["video_link"],
                                        );
                                      },
                                      identifier: widget
                                          .videosList[currentIndex.value]
                                              ["identifier"]
                                          .toString(),
                                      slug: widget
                                          .videosList[currentIndex.value]
                                              ["slug"]
                                          .toString(),
                                      theme: theme,
                                      isOwner: widget
                                              .videosList[currentIndex.value]
                                                  ["username"]
                                              .toString() !=
                                          dataStorage
                                              .read('username')
                                              .toString(),
                                      pageController: widget.pageController,
                                      currentIndex: currentIndex,
                                    );
                                  },
                                );
                                HapticFeedback.mediumImpact();
                              },
                              onDoubleTap: () {
                                HapticFeedback.mediumImpact();
                                if (dataStorage.read('isLogging') == true) {
                                  _controller.isLiked.value = true;
                                  if (widget.videosList[i]["upvoted"]) {
                                    widget.videosList[i]["upvoted"] =
                                        !widget.videosList[i]["upvoted"];
                                    widget.videosList[i]['upvote_count']--;
                                    _controller.postLikeRemove(
                                      postID: widget.videosList[i]["id"],
                                    );
                                    _controller.update();
                                  } else {
                                    widget.videosList[i]["upvoted"] =
                                        !widget.videosList[i]["upvoted"];
                                    widget.videosList[i]['upvote_count']++;
                                    _controller.postLikeAdd(
                                      postID: widget.videosList[i]["id"],
                                    );
                                    _controller.update();
                                  }
                                  Timer(const Duration(seconds: 1), () {
                                    _controller.isLiked.value = false;
                                  });
                                  _controller.update();
                                } else {
                                  _mainHomeScreenController.showAuthBottomSheet(
                                    context: context,
                                  );
                                }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: primaryBlack,
                                      image: DecorationImage(
                                        image: widget.videosList[i]
                                                    ["thumbnail_url"] !=
                                                'null'
                                            ? NetworkImage(
                                                widget.videosList[i]
                                                    ["thumbnail_url"],
                                              )
                                            : const AssetImage(
                                                AppAsset.white_logo,
                                              ) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // if (homevideoPlayerController!
                                        //     .value.value.isInitialized)
                                        //   SizedBox(
                                        //     height: 0,
                                        //     width: 0,
                                        //     child: PipFlutterPlayer(
                                        //       controller: _controller
                                        //           .pipFlutterPlayerController
                                        //           .value,
                                        //       key: _controller
                                        //           .pipFlutterPlayerKey,
                                        //     ),
                                        //   ),
                                        _controller
                                                .videoController(i)!
                                                .value
                                                .isInitialized
                                            ? const SizedBox.shrink()
                                            : SizedBox(
                                                height: 120,
                                                width: 120,
                                                child: Image.asset(
                                                  AppAsset.white_logo,
                                                  fit: BoxFit.contain,
                                                  color: Colors.grey.shade50
                                                      .withOpacity(0.2),
                                                ),
                                              ),

                                        _controller
                                                .videoController(i)!
                                                .value
                                                .isInitialized
                                            ? InteractiveViewer(
                                                panEnabled: false,
                                                maxScale: 1.0,
                                                minScale: 1.0,
                                                onInteractionStart: (_) {
                                                  _controller.isPinch.value =
                                                      !_controller
                                                          .isPinch.value;
                                                  _controller.update();
                                                },
                                                child: SizedBox.expand(
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: SizedBox(
                                                      width: _controller
                                                          .videoController(i)!
                                                          .value
                                                          .size
                                                          .width,
                                                      height: _controller
                                                          .videoController(i)!
                                                          .value
                                                          .size
                                                          .height,
                                                      child: VideoPlayer(
                                                          _controller
                                                              .videoController(
                                                                  i)!),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Positioned(
                                          bottom: widget.fromHomePage == true
                                              ? Get.height * 0.1
                                              : 20,
                                          child: SizedBox(
                                              height: 8,
                                              width: Get.width,
                                              child: VideoProgressIndicator(
                                                _controller.videoController(i)!,
                                                allowScrubbing: true,
                                                colors:
                                                    const VideoProgressColors(
                                                  bufferedColor: primaryWhite,
                                                  backgroundColor: primaryWhite,
                                                  playedColor: purpleColor,
                                                ),
                                              )),
                                        ),
                                        if (_controller.downloading == true)
                                          Positioned(
                                            bottom: widget.fromHomePage == true
                                                ? Get.height * 0.1
                                                : 20,
                                            child: Container(
                                              height: 25,
                                              width: Get.width,
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 3,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Downloading Video: ${_controller.progressString}',
                                                      style: AppTextStyle
                                                          .normalBold12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (_controller.downloadingCompleted ==
                                            true)
                                          Positioned(
                                            bottom: widget.fromHomePage == true
                                                ? Get.height * 0.1
                                                : 20,
                                            child: Container(
                                              height: 25,
                                              width: Get.width,
                                              color: Colors.green,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 3,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      'Download Completed',
                                                      style: AppTextStyle
                                                          .normalBold12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: widget.fromHomePage == true
                                        ? _controller.downloading ||
                                                _controller
                                                        .downloadingCompleted ==
                                                    true
                                            ? Get.height * 0.14
                                            : Get.height * 0.12
                                        : 30,
                                    left: 15,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _controller.isViewMode.value == false
                                            ? SizedBox(
                                                width: Get.width - 80,
                                                child: Row(
                                                  children: [],
                                                ),
                                              )
                                            : const SizedBox(),
                                        _controller.isViewMode.value == false
                                            ? customHeight(5)
                                            : const SizedBox(),
                                        SizedBox(
                                          width: Get.width - 20,
                                          child: ExpandableText(
                                            widget.videosList[i]["title"],
                                            style: AppTextStyle.normalRegular14,
                                            expandText: 'show more',
                                            collapseText: 'show less',
                                            maxLines: 2,
                                            linkColor: Colors.white,
                                          ),
                                          // Text(
                                          //   widget.videosList[i]["title"]
                                          //       .toString(),
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: AppTextStyle.normalRegular14,
                                          // ),
                                        )
                                      ],
                                    ),
                                  ),
                                  _controller
                                          .videoController(i)!
                                          .value
                                          .isInitialized
                                      ? Obx(
                                          () => !_controller
                                                  .videoController(i)!
                                                  .value
                                                  .isPlaying
                                              ? Center(
                                                  child: Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: primaryWhite
                                                        .withOpacity(
                                                      0.4,
                                                    ),
                                                    size: 65,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        )
                                      : const SizedBox(),
                                  Obx(() => _controller.isLiked.value
                                      ? Center(
                                          child: Image.asset(
                                            AppAsset.like,
                                            color: primaryWhite,
                                            height: 150,
                                          ),
                                        )
                                      : const Offstage()),
                                  homeController.feedPostList.isNotEmpty
                                      ? Container(
                                          height: Get.height,
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              homeSideBar(theme),
                                              SizedBox(
                                                height: Get.height * 0.18,
                                              ),
                                            ],
                                          ),
                                        )
                                      : const Offstage()
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget homeSideBar(theme) {
    return Obx(
      () => widget.videosList.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      if (dataStorage.read('isLogging') == true) {
                        if (widget.videosList[currentIndex.value]["upvoted"]) {
                          widget.videosList[currentIndex.value]["upvoted"] =
                              false;
                          widget.videosList[currentIndex.value]
                              ['upvote_count']--;
                          _controller.postLikeRemove(
                            postID: widget.videosList[currentIndex.value]["id"],
                          );
                          _controller.update();
                        } else {
                          widget.videosList[currentIndex.value]["upvoted"] =
                              true;
                          widget.videosList[currentIndex.value]
                              ['upvote_count']++;
                          _controller.postLikeAdd(
                            postID: widget.videosList[currentIndex.value]["id"],
                          );
                          _controller.update();
                        }
                      } else {
                        _mainHomeScreenController.showAuthBottomSheet(
                          context: context,
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: whiteColor.withOpacity(0.10)),
                          padding: const EdgeInsets.all(14),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return widget.videosList[currentIndex.value]
                                              ["upvoted"] !=
                                          null &&
                                      widget.videosList[currentIndex.value]
                                          ["upvoted"]
                                  ? const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        purpleColor,
                                        Colors.pink,
                                        appColor
                                      ],
                                      tileMode: TileMode.repeated,
                                    ).createShader(bounds)
                                  : const LinearGradient(
                                      colors: <Color>[
                                        Colors.white,
                                        Colors.white
                                      ],
                                    ).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              AppAsset.iclike,
                              color: widget.videosList[currentIndex.value]
                                              ["upvoted"] !=
                                          null &&
                                      widget.videosList[currentIndex.value]
                                          ["upvoted"]
                                  ? whiteColor
                                  : whiteColor,
                            ),
                          ),
                        ),
                        customHeight(2),
                        Text(
                          widget.videosList[currentIndex.value]['upvote_count']
                              .toString(),
                          style: AppTextStyle.normalSemiBold13,
                        ),
                      ],
                    ),
                  ),
                  height5,
                  homeSideBarItem(
                    icon: AppAsset.iccomment,
                    label: widget.videosList[currentIndex.value]
                                ['comment_count'] !=
                            null
                        ? widget.videosList[currentIndex.value]['comment_count']
                            .toString()
                        : "...",
                    ontap: () {
                      if (dataStorage.read('isLogging') == true) {
                        showModalBottomSheet(
                          constraints:
                              BoxConstraints(maxHeight: Get.height / 1.35),
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                              heightFactor: 1,
                              child: HomeCommentWidget(
                                postID: widget.videosList[currentIndex.value]
                                        ["id"]
                                    .toString(),
                                commentCount:
                                    widget.videosList[currentIndex.value]
                                        ['comment_count'],
                                index: currentIndex.value,
                                dataList: widget.videosList[currentIndex.value],
                              ),
                            );
                          },
                        ).then((value) {});
                      } else {
                        _mainHomeScreenController.showAuthBottomSheet(
                          context: context,
                        );
                      }
                    },
                  ),
                  height5,
                  homeSideBarItem(
                    icon: AppAsset.icshare2,
                    label: 'Share',
                    // widget.videosList[currentIndex.value]['share_count']
                    //     .toString(),
                    ontap: () async {
                      if (dataStorage.read('isLogging') == true) {
                        widget.videosList[currentIndex.value]['share_count']++;
                        _controller.update();
                      }
                      showModalBottomSheet(
                        backgroundColor: primaryBlack,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return MoreBottomSheet(
                            // sphere: Column(
                            //   children: [
                            //     if (widget
                            //         .videosList[currentIndex.value]["category"]
                            //         .isNotEmpty)
                            //       widget.videosList[currentIndex.value]
                            //                       ["category"]["name"] !=
                            //                   "Uncategorized" &&
                            //               widget.videosList[currentIndex.value]
                            //                       ["category"]["name"] !=
                            //                   ""
                            //           ? Column(
                            //               children: [
                            //                 InkWell(
                            //                   onTap: () {
                            //                     log("tap");
                            //                     HapticFeedback.mediumImpact();
                            //                     _controller.browseSpheresOnTap(
                            //                       context,
                            //                       name: widget.videosList[
                            //                               currentIndex.value]
                            //                           ["category"]["name"],
                            //                       desc: widget.videosList[
                            //                                   currentIndex
                            //                                       .value]
                            //                               ["category"]
                            //                           ["description"],
                            //                       id: widget.videosList[
                            //                               currentIndex.value]
                            //                           ["category"]["id"],
                            //                       count: widget.videosList[
                            //                               currentIndex.value]
                            //                           ["category"]["count"],
                            //                       photourl: widget.videosList[
                            //                               currentIndex.value]
                            //                           ["category"]["image_url"],
                            //                     );
                            //                     if (_controller
                            //                                 .videoController(
                            //                                     currentIndex
                            //                                         .value)!
                            //                                 .value
                            //                                 .isPlaying ==
                            //                             true ||
                            //                         _controller
                            //                                 .videoController(
                            //                                     currentIndex
                            //                                         .value)!
                            //                                 .value
                            //                                 .isPlaying ==
                            //                             false) {
                            //                       _controller.isPlaying.value =
                            //                           false;
                            //                       _controller.isPlaying.value =
                            //                           false;
                            //                       _controller
                            //                           .videoController(
                            //                               currentIndex.value)!
                            //                           .pause();
                            //                     } else {
                            //                       // _controller.isPlaying.value =
                            //                       //     true;
                            //                       // homevideoPlayerController!.value
                            //                       //     .play();
                            //                     }
                            //                     Navigator.pop(context);
                            //                   },
                            //                   child: Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment.start,
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.center,
                            //                     children: [
                            //                       SvgPicture.asset(
                            //                         AppAsset.sphereLogo,
                            //                         height: 18,
                            //                         width: 18,
                            //                         color: Theme.of(context)
                            //                             .errorColor,
                            //                       ),
                            //                       width05,
                            //                       Text(
                            //                         'Browse Subverse',
                            //                         style: Theme.of(context)
                            //                             .textTheme
                            //                             .bodySmall!
                            //                             .copyWith(
                            //                               fontSize: 18,
                            //                             ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 height5,
                            //                 const Divider(
                            //                     color: grey, thickness: 0.1),
                            //                 height5,
                            //               ],
                            //             )
                            //           : const SizedBox()
                            //   ],
                            // ),
                            videoLink: widget.videosList[currentIndex.value]
                                ["video_link"],
                            onSaveVideoTap: () async {
                              Get.back();
                              _controller.downloadFile(
                                title: widget.videosList[currentIndex.value]
                                    ["identifier"],
                                videoUrl: widget.videosList[currentIndex.value]
                                    ["video_link"],
                              );
                            },
                            identifier: widget.videosList[currentIndex.value]
                                    ["identifier"]
                                .toString(),
                            slug: widget.videosList[currentIndex.value]["slug"]
                                .toString(),
                            theme: theme,
                            isOwner: (widget.videosList[currentIndex.value]
                                        ["username"]
                                    .toString() !=
                                dataStorage.read('username').toString()),
                            pageController: widget.pageController,
                            currentIndex: currentIndex,
                          );
                        },
                      );
                    },
                  ),
                  height5,
                  GestureDetector(
                    onTap: () {
                      _mainHomeScreenController.showExitBottomSheet(
                        context: context,
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor.withOpacity(0.10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        AppAsset.white_logo,
                      ),
                    ),
                  ),
                  // homeSideBarItem(
                  //   icon: AppAsset.icAspectRatio,
                  //   color: whiteColor,
                  //   label: "Pip",
                  //   ontap: () async {
                  //     // if (Platform.isIOS) {
                  //     //   await _controller.pipFlutterPlayerController.value
                  //     //       .enablePictureInPicture(
                  //     //           _controller.pipFlutterPlayerKey);
                  //     //   _controller.isPlaying.value = false;
                  //     //   videoPlayerController?.value.pause();
                  //     //   if (Platform.isIOS) {
                  //     //     Timer(const Duration(seconds: 1), () {
                  //     //       MoveToBackground.moveTaskToBack();
                  //     //     });
                  //     //   }
                  //     // } else {
                  //     await _controller.permisiionhandler();
                  //     // }
                  //   },
                  // ),
                ],
              ),
            ),
    );
  }

  Widget homeSideBarItem({ontap, icon, label, color}) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Container(
              height: 45,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: whiteColor.withOpacity(0.10)),
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                icon,
                color: color,
              )),
          // height5,
          customHeight(2),
          Text(
            label,
            style: AppTextStyle.normalSemiBold13,
          ),
        ],
      ),
    );
  }

  Widget followArrowWidget({required IconData icon, required int index}) {
    return Container(
      height: 53,
      width: 55,
      alignment: widget.videosList[index]["following"] != false
          ? Alignment.bottomCenter
          : Alignment.topCenter,
      decoration: BoxDecoration(
        border: Border.all(color: primaryWhite, width: 2),
        shape: BoxShape.circle,
        color: purpleColor,
      ),
      child: Icon(
        icon,
        color: primaryWhite,
        size: 30,
      ),
    );
  }

  Widget profileImageWidget({index, onDrag}) {
    return GestureDetector(
      onVerticalDragStart: onDrag,
      onTap: () {
        if (dataStorage.read('isLogging') == true) {
          _controller.isAutoplay.value = false;
          _controller.isPlaying.value = false;
          _controller.videoController(index)!.pause();
          Get.to(
            () => ProfileScreen(
              fromMainUser: false,
              updateUserStatus: (bool isFollow) {
                widget.videosList[currentIndex.value]["following"] = isFollow;
                _controller.update();
              },
              profileUsername: widget.videosList[index]["username"],
            ),
          )!
              .then((value) {
            _controller.isAutoplay.value = true;
            _controller.isPlaying.value = true;
            _controller.videoController(index)!.play();
            setState(() {});
          });
        } else {
          _mainHomeScreenController.showAuthBottomSheet(context: context);
        }
      },
      child: UIInterface.profileImageWidget(
        imgUrl: widget.videosList[index]["picture_url"],
        height: 52,
        width: 52,
      ),
    );
  }
}
