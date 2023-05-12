// ignore_for_file: must_be_immutable, invalid_use_of_protected_member, unrelated_type_equality_checks
import 'dart:io';
import 'package:socialverse/export.dart';
import 'package:socialverse/feature/home/extension/custom_physics.dart';

class VideoPlayerWidget extends StatefulWidget {
  RxList videosList = [].obs;
  final bool fromHomePage;
  final bool? fromCategoryPage;
  final bool? fromSearchPage;
  final int videoIndex;
  final String? sphereName;
  final Rx<PageController> pageController;

  VideoPlayerWidget(
      {Key? key,
      required this.videoIndex,
      required this.videosList,
      this.fromCategoryPage,
      this.fromSearchPage,
      this.sphereName,
      required this.fromHomePage,
      required this.pageController})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  final CommentController commentController = Get.put(CommentController());
  final CommonVideoPlayerController _commonController = Get.put(
    CommonVideoPlayerController(),
  );
  final MainHomeScreenController _mainHomeScreenController = Get.put(
    MainHomeScreenController(),
  );
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _commonController.initController(widget.videoIndex,
        List<String>.from(widget.videosList.value.map((e) => e["video_link"])));
  }

  @override
  void dispose() async {
    _commonController.videoControllers.forEach((key, value) async {
      await value.pause();
      await value.dispose();
    });
    _commonController.videoListeners.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBlack,
      body: Stack(
        children: [
          Stack(
            children: [
              GetBuilder<CommonVideoPlayerController>(
                initState: (state) async {
                  _commonController.isAutoplay.value = true;
                  _commonController.currentIndex.value = widget.videoIndex;
                },
                dispose: (state) {
                  _commonController.isAutoplay.value = false;
                  _commonController.isPlaying.value = false;
                  _commonController
                      .videoController(_commonController.currentIndex.value)
                      ?.pause();
                },
                builder: (_) {
                  bool theme = dataStorage.read("isDarkMode");
                  return AnimatedContainer(
                    height: _commonController.isSize.value
                        ? Get.height * 0.3
                        : Get.height,
                    padding: _commonController.isSize.value
                        ? EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top)
                        : const EdgeInsets.all(0),
                    width: Get.width,
                    transformAlignment: Alignment.topCenter,
                    duration: const Duration(milliseconds: 300),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: _commonController.isViewMode == false
                                ? Platform.isIOS
                                    ? Get.height * 0.1
                                    : Get.height * 0.08
                                : Platform.isIOS
                                    ? Get.height * 0.12
                                    : Get.height * 0.1,
                          ),
                          child: AnimatedContainer(
                            transformAlignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 300),
                            height: Get.height,
                            width: Get.width,
                            child: PageView.builder(
                              controller: widget.pageController.value,
                              onPageChanged: (index) {
                                if (index >
                                    _commonController.currentIndex.value) {
                                  _commonController.nextVideo();
                                }
                                if (index <
                                    _commonController.currentIndex.value) {
                                  _commonController.previousVideo();
                                }
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: widget.videosList.length,
                              physics: CustomPageViewScrollPhysics(),
                              itemBuilder: (context, i) {
                                return
                                    // _commonController
                                    //         .pipFlutterPlayerController
                                    //         .value
                                    //         .isFullScreen
                                    //     ? Stack(
                                    //         children: [
                                    //           Container(
                                    //             height: 1,
                                    //             width: 1,
                                    //             color: purpleColor,
                                    //             // child: PipFlutterPlayer(
                                    //             //   controller: _commonController
                                    //             //       .pipFlutterPlayerController
                                    //             //       .value,
                                    //             //   key: _commonController
                                    //             //       .pipFlutterPlayerKey,
                                    //             // ),
                                    //           ),
                                    //           _commonController
                                    //                       .videoController(i) ==
                                    //                   null
                                    //               ? const CustomProgressIndicator()
                                    //               : VideoPlayer(
                                    //                   _commonController
                                    //                       .videoController(i)!,
                                    //                 )
                                    //         ],
                                    //       )
                                    //     :
                                    InkWell(
                                  onTap: isKeyboardShowing
                                      ? () {
                                          FocusScope.of(context).unfocus();
                                        }
                                      : () {
                                          if (_commonController.isSize.value) {
                                            _commonController.isSize.value =
                                                false;
                                          } else {
                                            if (_commonController
                                                .videoController(i)!
                                                .value
                                                .isPlaying) {
                                              _commonController
                                                  .isPlaying.value = false;
                                              _commonController
                                                  .videoController(i)!
                                                  .pause();
                                            } else {
                                              _commonController
                                                  .isPlaying.value = true;
                                              _commonController
                                                  .videoController(i)!
                                                  .play();
                                            }
                                          }
                                          // videoPlayerGetXController.update();
                                        },
                                  onLongPress: isKeyboardShowing
                                      ? () => FocusScope.of(context).unfocus()
                                      : () {
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
                                                //         .videosList[i]
                                                //             ["category"]
                                                //         .isNotEmpty)
                                                //       widget.videosList[i]["category"]
                                                //                       [
                                                //                       "name"] !=
                                                //                   "Uncategorized" &&
                                                //               widget.videosList[i]["category"]
                                                //                       [
                                                //                       "name"] !=
                                                //                   ""
                                                //           ? Column(
                                                //               children: [
                                                //                 InkWell(
                                                //                   onTap:
                                                //                       () {
                                                //                     log("tap");
                                                //                     HapticFeedback
                                                //                         .mediumImpact();
                                                //                     Navigator.pop(
                                                //                         context);
                                                //                     // if (widget.fromCategoryPage ==
                                                //                     //     true) {
                                                //                     //   _commonController.floatingScaffold(
                                                //                     //     context,
                                                //                     //     message: 'You\'re watching videos from the ' + widget.videosList[i]["category"]["name"] + ' subverse',
                                                //                     //     duration: const Duration(
                                                //                     //       seconds: 2,
                                                //                     //     ),
                                                //                     //   );
                                                //                     // } else {
                                                //                     //   _commonController.spheresOnTap(context,
                                                //                     //       name: widget.videosList[i]["category"]["name"],
                                                //                     //       desc: widget.videosList[i]["category"]["description"] ?? " ",
                                                //                     //       id: widget.videosList[i]["category"]["id"],
                                                //                     //       count: widget.videosList[i]["category"]["count"],
                                                //                     //       photourl: widget.videosList[i]["category"]["image_url"] ?? " ", callBack: () {
                                                //                     //     _commonController.isAutoplay.value = true;
                                                //                     //     _commonController.currentIndex.value = i;
                                                //                     //     _commonController.initController(i, List<String>.from(widget.videosList.value.map((e) => e["video_link"])));
                                                //                     //   });
                                                //                     //   if (_commonController.videoController(_commonController.currentIndex.value)!.value.isPlaying == true ||
                                                //                     //       _commonController.videoController(_commonController.currentIndex.value)!.value.isPlaying == false) {
                                                //                     //     _commonController.isPlaying.value = false;
                                                //                     //     _commonController.isPlaying.value = false;
                                                //                     //     _commonController.videoController(_commonController.currentIndex.value)?.pause();
                                                //                     //   } else {}
                                                //                     //   Navigator.pop(context);
                                                //                     // }
                                                //                   },
                                                //                   child:
                                                //                       Row(
                                                //                     mainAxisAlignment:
                                                //                         MainAxisAlignment.start,
                                                //                     crossAxisAlignment:
                                                //                         CrossAxisAlignment.center,
                                                //                     children: [
                                                //                       SvgPicture.asset(
                                                //                         AppAsset.sphereLogo,
                                                //                         height: 18,
                                                //                         width: 18,
                                                //                         color: Theme.of(context).errorColor,
                                                //                       ),
                                                //                       width05,
                                                //                       Text(
                                                //                         'Browse Subverse',
                                                //                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                //                               fontSize: 18,
                                                //                             ),
                                                //                       ),
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 height5,
                                                //                 const Divider(
                                                //                     color:
                                                //                         grey,
                                                //                     thickness:
                                                //                         0.1),
                                                //                 height5,
                                                //               ],
                                                //             )
                                                //           : const SizedBox()
                                                //   ],
                                                // ),
                                                isFromVideoPlayer: true,
                                                videoLink: widget.videosList[
                                                    _commonController
                                                        .currentIndex
                                                        .value]["video_link"],
                                                onSaveVideoTap: () async {
                                                  Get.back();
                                                  _commonController
                                                      .downloadFile(
                                                    title: widget.videosList[
                                                            _commonController
                                                                .currentIndex
                                                                .value]
                                                        ["identifier"],
                                                    videoUrl: widget.videosList[
                                                            _commonController
                                                                .currentIndex
                                                                .value]
                                                        ["video_link"],
                                                  );
                                                },
                                                identifier: widget.videosList[
                                                        _commonController
                                                            .currentIndex.value]
                                                        ["identifier"]
                                                    .toString(),
                                                slug: widget.videosList[
                                                        _commonController
                                                            .currentIndex
                                                            .value]["slug"]
                                                    .toString(),
                                                theme: theme,
                                                isOwner: (widget.videosList[
                                                            _commonController
                                                                .currentIndex
                                                                .value]
                                                            ["username"]
                                                        .toString() !=
                                                    dataStorage
                                                        .read('username')
                                                        .toString()),
                                                pageController:
                                                    widget.pageController,
                                                currentIndex: _commonController
                                                    .currentIndex,
                                              );
                                            },
                                          );
                                          HapticFeedback.mediumImpact();
                                        },
                                  onDoubleTap: () {
                                    HapticFeedback.mediumImpact();
                                    if (dataStorage.read('isLogging') == true) {
                                      _commonController.isLiked.value = true;
                                      if (widget.videosList[i]["upvoted"]) {
                                        widget.videosList[i]["upvoted"] =
                                            !widget.videosList[i]["upvoted"];
                                        widget.videosList[i]['upvote_count']--;
                                        _commonController.postLikeRemove(
                                          postID: widget.videosList[i]["id"],
                                        );
                                        _commonController.update();
                                      } else {
                                        widget.videosList[i]["upvoted"] =
                                            !widget.videosList[i]["upvoted"];
                                        widget.videosList[i]['upvote_count']++;
                                        _commonController.postLikeAdd(
                                          postID: widget.videosList[i]["id"],
                                        );
                                        _commonController.update();
                                      }
                                      Timer(const Duration(milliseconds: 500),
                                          () {
                                        _commonController.isLiked.value = false;
                                      });
                                      _commonController.update();
                                    } else {
                                      _mainHomeScreenController
                                          .showAuthBottomSheet(
                                        context: context,
                                      );
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // decoration: BoxDecoration(
                                        //   color: primaryBlack,
                                        //   image: DecorationImage(
                                        //     image: widget.videosList[i][
                                        //                 "thumbnail_url"] !=
                                        //             'null'
                                        //         ? NetworkImage(
                                        //             widget.videosList[i]
                                        //                 ["thumbnail_url"],
                                        //           )
                                        //         : const AssetImage(
                                        //             AppAsset
                                        //                 .socialverselogo,
                                        //           ) as ImageProvider,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        color: primaryBlack,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // if (videoPlayerController!
                                            //     .value.value.isInitialized)
                                            //   SizedBox(
                                            //     height: 0,
                                            //     width: 0,
                                            //     child: PipFlutterPlayer(
                                            //       controller: _commonController
                                            //           .pipFlutterPlayerController
                                            //           .value,
                                            //       key: _commonController
                                            //           .pipFlutterPlayerKey,
                                            //     ),
                                            //   ),
                                            _commonController
                                                    .videoController(
                                                        _commonController
                                                            .currentIndex
                                                            .value)!
                                                    .value
                                                    .isInitialized
                                                ? const SizedBox.shrink()
                                                : SizedBox(
                                                    height: 120,
                                                    width: 120,
                                                    child: Image.asset(
                                                      AppAsset.socialverselogo,
                                                      fit: BoxFit.contain,
                                                      color: Colors.grey.shade50
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                            _commonController
                                                    .videoController(
                                                        _commonController
                                                            .currentIndex
                                                            .value)!
                                                    .value
                                                    .isInitialized
                                                ? const SizedBox.shrink()
                                                : const CustomProgressIndicator(),
                                            _commonController
                                                        .videoController(i) ==
                                                    null
                                                ? const Center(
                                                    child:
                                                        CustomProgressIndicator(),
                                                  )
                                                : _commonController
                                                        .videoController(
                                                            _commonController
                                                                .currentIndex
                                                                .value)!
                                                        .value
                                                        .isInitialized
                                                    ? InteractiveViewer(
                                                        panEnabled: false,
                                                        maxScale: 1.0,
                                                        minScale: 1.0,
                                                        onInteractionStart:
                                                            (_) {
                                                          _commonController
                                                                  .isPinch
                                                                  .value =
                                                              !_commonController
                                                                  .isPinch
                                                                  .value;
                                                          _commonController
                                                              .update();
                                                        },
                                                        child:
                                                            // _controller.isPinch.value ==
                                                            //         false
                                                            //     ?
                                                            SizedBox.expand(
                                                          child: FittedBox(
                                                            fit: BoxFit.cover,
                                                            child: SizedBox(
                                                              width: _commonController
                                                                  .videoController(
                                                                      _commonController
                                                                          .currentIndex
                                                                          .value)!
                                                                  .value
                                                                  .size
                                                                  .width,
                                                              height: _commonController
                                                                  .videoController(
                                                                      _commonController
                                                                          .currentIndex
                                                                          .value)!
                                                                  .value
                                                                  .size
                                                                  .height,
                                                              child: VideoPlayer(
                                                                  _commonController
                                                                      .videoController(
                                                                          i)!),
                                                            ),
                                                          ),
                                                        ))
                                                    : Container(),
                                            Positioned(
                                              bottom: 0,
                                              child: SizedBox(
                                                height: 9,
                                                width: Get.width,
                                                child: _commonController
                                                            .videoController(
                                                                _commonController
                                                                    .currentIndex
                                                                    .value) ==
                                                        null
                                                    ? const Center(
                                                        child:
                                                            CustomProgressIndicator(),
                                                      )
                                                    : VideoProgressIndicator(
                                                        _commonController
                                                            .videoController(
                                                                _commonController
                                                                    .currentIndex
                                                                    .value)!,
                                                        allowScrubbing: true,
                                                        colors:
                                                            const VideoProgressColors(
                                                          bufferedColor:
                                                              primaryWhite,
                                                          backgroundColor:
                                                              primaryWhite,
                                                          playedColor:
                                                              purpleColor,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            if (_commonController.downloading ==
                                                true) // true
                                              Positioned(
                                                bottom: Get.height * 0.003,
                                                child: Container(
                                                  height: 25,
                                                  width: Get.width,
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16,
                                                      vertical: 3,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Downloading Video: ${_commonController.progressString}',
                                                          style: AppTextStyle
                                                              .normalBold12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (_commonController
                                                    .downloadingCompleted ==
                                                true) //true
                                              Positioned(
                                                bottom: Get.height * 0.003,
                                                child: Container(
                                                  height: 25,
                                                  width: Get.width,
                                                  color: Colors.green,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16,
                                                      vertical: 3,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          'Downloading Completed',
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
                                        bottom: _commonController.downloading ||
                                                _commonController
                                                        .downloadingCompleted ==
                                                    true // true
                                            ? Get.height * 0.04
                                            : Get.height * 0.02,
                                        left: 15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            _commonController
                                                        .isViewMode.value ==
                                                    false
                                                ? SizedBox(
                                                    width: Get.width - 80,
                                                    child: Row(
                                                      children: [
                                                        //     Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .center,
                                                        //       crossAxisAlignment:
                                                        //           CrossAxisAlignment
                                                        //               .center,
                                                        //       children: [
                                                        //         InkWell(
                                                        //           onTap: () {
                                                        //             _commonController
                                                        //                 .isAutoplay
                                                        //                 .value = false;
                                                        //             _commonController
                                                        //                     .isPlaying
                                                        //                     .value =
                                                        //                 false;
                                                        //             _commonController
                                                        //                 .videoController(
                                                        //                     _commonController
                                                        //                         .currentIndex
                                                        //                         .value)
                                                        //                 ?.pause();

                                                        //             if (dataStorage
                                                        //                     .read(
                                                        //                         'isLogging') ==
                                                        //                 true) {
                                                        //               Get.to(
                                                        //                 () =>
                                                        //                     ProfileScreen(
                                                        //                   fromMainUser:
                                                        //                       false,
                                                        //                   updateUserStatus:
                                                        //                       (bool
                                                        //                           isFollow) {
                                                        //                     widget.videosList[_commonController
                                                        //                         .currentIndex
                                                        //                         .value]["following"] = isFollow;
                                                        //                     _commonController
                                                        //                         .update();
                                                        //                   },
                                                        //                   profileUsername: widget
                                                        //                       .videosList[
                                                        //                           i]
                                                        //                           [
                                                        //                           "username"]
                                                        //                       .toString(),
                                                        //                 ),
                                                        //               )!
                                                        //                   .then(
                                                        //                       (value) {
                                                        //                 _commonController
                                                        //                     .isPlaying
                                                        //                     .value = true;
                                                        //                 _commonController
                                                        //                     .isAutoplay
                                                        //                     .value = true;
                                                        //                 _commonController
                                                        //                     .videoController(_commonController
                                                        //                         .currentIndex
                                                        //                         .value)
                                                        //                     ?.play();
                                                        //               });
                                                        //             } else {
                                                        //               _mainHomeScreenController
                                                        //                   .showAuthBottomSheet(
                                                        //                 context:
                                                        //                     context,
                                                        //               );
                                                        //             }
                                                        //             setState(() {});
                                                        //           },
                                                        //           child: Text(
                                                        //             "@" +
                                                        //                 widget.videosList[
                                                        //                         i][
                                                        //                     "username"],
                                                        //             overflow:
                                                        //                 TextOverflow
                                                        //                     .ellipsis,
                                                        //             style: AppTextStyle
                                                        //                 .normalSemiBold18,
                                                        //           ),
                                                        //         ),
                                                        //         width10,
                                                        //         widget.videosList[
                                                        //                         _commonController.currentIndex.value]
                                                        //                         [
                                                        //                         "username"]
                                                        //                     .toString() !=
                                                        //                 dataStorage
                                                        //                     .read(
                                                        //                         'username')
                                                        //                     .toString()
                                                        //             ? InkWell(
                                                        //                 onTap: () {
                                                        //                   if (dataStorage
                                                        //                           .read('isLogging') ==
                                                        //                       true) {
                                                        //                     _commonController
                                                        //                         .followUser(
                                                        //                       context,
                                                        //                       widget.videosList[_commonController
                                                        //                           .currentIndex
                                                        //                           .value]["username"],
                                                        //                       widget.videosList[_commonController
                                                        //                           .currentIndex
                                                        //                           .value]["following"],
                                                        //                     );
                                                        //                     widget.videosList[_commonController
                                                        //                         .currentIndex
                                                        //                         .value]["following"] = widget.videosList[_commonController.currentIndex.value]["following"] ==
                                                        //                             true
                                                        //                         ? false
                                                        //                         : true;
                                                        //                     _commonController
                                                        //                         .update();
                                                        //                   } else {
                                                        //                     _mainHomeScreenController
                                                        //                         .showAuthBottomSheet(
                                                        //                       context:
                                                        //                           context,
                                                        //                     );
                                                        //                   }
                                                        //                 },
                                                        //                 child:
                                                        //                     Container(
                                                        //                   height:
                                                        //                       32,
                                                        //                   decoration:
                                                        //                       BoxDecoration(
                                                        //                     borderRadius:
                                                        //                         BorderRadius.circular(
                                                        //                       5,
                                                        //                     ),
                                                        //                     border:
                                                        //                         Border.all(
                                                        //                       color: Colors
                                                        //                           .white
                                                        //                           .withOpacity(0.2),
                                                        //                       width:
                                                        //                           1,
                                                        //                     ),
                                                        //                   ),
                                                        //                   padding:
                                                        //                       const EdgeInsets.all(
                                                        //                           4),
                                                        //                   child:
                                                        //                       Center(
                                                        //                     child:
                                                        //                         Text(
                                                        //                       widget.videosList[_commonController.currentIndex.value]["following"] == true
                                                        //                           ? 'unsub'
                                                        //                           : 'subscribe',
                                                        //                       overflow:
                                                        //                           TextOverflow.ellipsis,
                                                        //                       style:
                                                        //                           AppTextStyle.normalRegular14,
                                                        //                     ),
                                                        //                   ),
                                                        //                 ),
                                                        //               )
                                                        //             : const SizedBox()
                                                        //       ],
                                                        //     ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            _commonController
                                                        .isViewMode.value ==
                                                    false
                                                ? customHeight(5)
                                                : const SizedBox(),
                                            _commonController
                                                        .isViewMode.value ==
                                                    false
                                                ? SizedBox(
                                                    width: Get.width - 20,
                                                    child:
                                                        // ExpandableText(
                                                        //   widget.videosList[i]
                                                        //       ["title"],
                                                        //   expandText: 'show more',
                                                        //   collapseText: 'show less',
                                                        //   maxLines: 1,
                                                        //   linkColor: primaryWhite,
                                                        //   collapseOnTextTap: true,
                                                        //   style: AppTextStyle
                                                        //       .normalRegular14,
                                                        // )
                                                        Text(
                                                      widget.videosList[i]
                                                              ["title"]
                                                          .toString(),
                                                      // overflow:
                                                      //     TextOverflow.ellipsis,
                                                      style: AppTextStyle
                                                          .normalRegular14,
                                                    ),
                                                  )
                                                : SizedBox.shrink()
                                          ],
                                        ),
                                      ),
                                      _commonController
                                              .videoController(_commonController
                                                  .currentIndex.value)!
                                              .value
                                              .isInitialized
                                          ? Obx(
                                              () => _commonController
                                                          .videoController(
                                                              _commonController
                                                                  .currentIndex
                                                                  .value) ==
                                                      null
                                                  ? const Center(
                                                      child:
                                                          CustomProgressIndicator(),
                                                    )
                                                  : !_commonController
                                                              .videoController(
                                                                  _commonController
                                                                      .currentIndex
                                                                      .value)!
                                                              .value
                                                              .isPlaying ==
                                                          true
                                                      ? Center(
                                                          child: Icon(
                                                            Icons
                                                                .play_arrow_rounded,
                                                            color: primaryWhite
                                                                .withOpacity(
                                                              0.4,
                                                            ),
                                                            size: 65,
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                            )
                                          : const SizedBox.shrink(),
                                      Obx(
                                        () => _commonController.isLiked.value
                                            ? Center(
                                                child: Image.asset(
                                                  AppAsset.like,
                                                  color: primaryWhite,
                                                  height: 150,
                                                ),
                                              )
                                            : const Offstage(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        _commonController.isViewMode.value == false
                            ? Container(
                                height: Get.height,
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    homeSideBar(theme),
                                    SizedBox(
                                      height: Get.height * 0.18,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          _commonController.isViewMode.value == false
              ? Positioned(
                  top: Platform.isIOS ? 55 : 45,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      _focusNode.unfocus();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: whiteColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 16,
                        color: primaryWhite,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: _commonController.isViewMode.value == false
                  ? Container(
                      width: Get.width,
                      height: Platform.isIOS // isIOS
                          ? isKeyboardShowing
                              ? Get.height * 0.08
                              : Get.height * 0.1
                          : Get.height * 0.08,
                      color: Colors.grey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 10,
                          top: 10,
                          right: 15,
                        ),
                        child: TextFormField(
                          controller: commentController.commentController,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: "Add comment...",
                            hintStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey,
                                    ),
                            suffixIcon: IconButton(
                              onPressed: commentController
                                      .commentController.text.isEmpty
                                  ? () {
                                      commentController.isFromCommentWidget =
                                          false;
                                      commentController.floatingScaffold(
                                        context,
                                        message: 'Enter a comment',
                                        height: commentController
                                                    .isFromCommentWidget ==
                                                false
                                            ? Platform.isIOS
                                                ? isKeyboardShowing
                                                    ? Get.height * 0.8
                                                    : Get.height * 0.105
                                                : isKeyboardShowing
                                                    ? Get.height * 0.85
                                                    : Get.height * 0.105
                                            : Platform.isIOS
                                                ? Get.height * 0.8
                                                : Get.height * 0.85,
                                      );
                                    }
                                  : () {
                                      commentController.addComment(
                                        postID: widget.videosList[
                                                _commonController
                                                    .currentIndex.value]["id"]
                                            .toString(),
                                        data: commentController
                                            .commentController.text
                                            .toString(),
                                        context: context,
                                        dataList: widget.videosList[
                                            _commonController
                                                .currentIndex.value],
                                      );
                                      commentController.isFromCommentWidget =
                                          false;
                                      commentController.commentController
                                          .clear();
                                      _focusNode.unfocus();
                                    },
                              icon: SvgPicture.asset(
                                AppAsset.icsend,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  : Container(
                      width: Get.width,
                      height: Platform.isIOS // isIOS
                          ? isKeyboardShowing
                              ? Get.height * 0.08
                              : Get.height * 0.12
                          : Get.height * 0.1,
                      color: Colors.grey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 13,
                          bottom: 10,
                          top: 10,
                          right: 13,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 50,
                                  child: profileImageWidget(
                                    index: _commonController.currentIndex.value,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (dataStorage.read('isLogging') == true) {
                                      if (widget.videosList[_commonController
                                          .currentIndex.value]["upvoted"]) {
                                        widget.videosList[_commonController
                                            .currentIndex
                                            .value]["upvoted"] = false;
                                        widget.videosList[_commonController
                                            .currentIndex
                                            .value]['upvote_count']--;
                                        _commonController.postLikeRemove(
                                          postID: widget.videosList[
                                              _commonController
                                                  .currentIndex.value]["id"],
                                        );
                                        _commonController.update();
                                      } else {
                                        widget.videosList[_commonController
                                            .currentIndex
                                            .value]["upvoted"] = true;
                                        widget.videosList[_commonController
                                            .currentIndex
                                            .value]['upvote_count']++;
                                        _commonController.postLikeAdd(
                                          postID: widget.videosList[
                                              _commonController
                                                  .currentIndex.value]["id"],
                                        );
                                        _commonController.update();
                                      }
                                    } else {
                                      _mainHomeScreenController
                                          .showAuthBottomSheet(
                                        context: context,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor.withOpacity(0.10),
                                    ),
                                    padding: const EdgeInsets.all(13),
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return widget.videosList[
                                                            _commonController
                                                                .currentIndex
                                                                .value]
                                                        ["upvoted"] !=
                                                    null &&
                                                widget.videosList[
                                                    _commonController
                                                        .currentIndex
                                                        .value]["upvoted"]
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
                                        color: widget.videosList[
                                                            _commonController
                                                                .currentIndex
                                                                .value]
                                                        ["upvoted"] !=
                                                    null &&
                                                widget.videosList[
                                                    _commonController
                                                        .currentIndex
                                                        .value]["upvoted"]
                                            ? whiteColor
                                            : whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (dataStorage.read('isLogging') == true) {
                                      showModalBottomSheet(
                                        constraints: BoxConstraints(
                                            maxHeight: Get.height / 1.35),
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                topLeft: Radius.circular(30))),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return FractionallySizedBox(
                                            heightFactor: 1,
                                            child: CommentWidget(
                                              postID: widget.videosList[
                                                      _commonController
                                                          .currentIndex
                                                          .value]["id"]
                                                  .toString(),
                                              commentCount: widget.videosList[
                                                  _commonController.currentIndex
                                                      .value]['comment_count'],
                                              index: _commonController
                                                  .currentIndex.value,
                                              dataList: widget.videosList[
                                                  _commonController
                                                      .currentIndex.value],
                                            ),
                                          );
                                        },
                                      ).then((value) {});
                                    } else {
                                      _mainHomeScreenController
                                          .showAuthBottomSheet(
                                        context: context,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor.withOpacity(0.10),
                                    ),
                                    padding: const EdgeInsets.all(13),
                                    child: SvgPicture.asset(
                                      AppAsset.iccomment,
                                      // color: color,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
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
                                          isFromVideoPlayer: true,
                                          videoLink: widget.videosList[
                                              _commonController.currentIndex
                                                  .value]["video_link"],
                                          onSaveVideoTap: () async {
                                            Get.back();
                                            _commonController.downloadFile(
                                              title: widget.videosList[
                                                  _commonController.currentIndex
                                                      .value]["identifier"],
                                              videoUrl: widget.videosList[
                                                  _commonController.currentIndex
                                                      .value]["video_link"],
                                            );
                                          },
                                          identifier: widget.videosList[
                                                  _commonController.currentIndex
                                                      .value]["identifier"]
                                              .toString(),
                                          slug: widget.videosList[
                                                  _commonController.currentIndex
                                                      .value]["slug"]
                                              .toString(),
                                          theme: dataStorage.read("isDarkMode"),
                                          isOwner: (widget.videosList[
                                                      _commonController
                                                          .currentIndex
                                                          .value]["username"]
                                                  .toString() !=
                                              dataStorage
                                                  .read('username')
                                                  .toString()),
                                          pageController: widget.pageController,
                                          currentIndex:
                                              _commonController.currentIndex,
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor.withOpacity(0.10),
                                    ),
                                    padding: const EdgeInsets.all(13),
                                    child: SvgPicture.asset(
                                      AppAsset.icshare2,
                                      // color: color,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    if (_commonController.isViewMode.value ==
                                        true) {
                                      setState(() {
                                        _commonController.isViewMode.value =
                                            false;
                                      });
                                    } else {
                                      setState(() {
                                        _commonController.isViewMode.value =
                                            true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor.withOpacity(0.10),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Icon(
                                      _commonController.isViewMode.value ==
                                              false
                                          ? Icons.fullscreen_rounded
                                          : Icons.fullscreen_exit_rounded,
                                      color: whiteColor,
                                      size: 32,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _mainHomeScreenController
                                        .showExitBottomSheet(
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
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
                        if (widget.videosList[
                            _commonController.currentIndex.value]["upvoted"]) {
                          widget.videosList[_commonController
                              .currentIndex.value]["upvoted"] = false;
                          widget.videosList[_commonController
                              .currentIndex.value]['upvote_count']--;
                          _commonController.postLikeRemove(
                            postID: widget.videosList[
                                _commonController.currentIndex.value]["id"],
                          );
                          _commonController.update();
                        } else {
                          widget.videosList[_commonController
                              .currentIndex.value]["upvoted"] = true;
                          widget.videosList[_commonController
                              .currentIndex.value]['upvote_count']++;
                          _commonController.postLikeAdd(
                            postID: widget.videosList[
                                _commonController.currentIndex.value]["id"],
                          );
                          _commonController.update();
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
                              return widget.videosList[_commonController
                                              .currentIndex.value]["upvoted"] !=
                                          null &&
                                      widget.videosList[_commonController
                                          .currentIndex.value]["upvoted"]
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
                              color: widget.videosList[_commonController
                                              .currentIndex.value]["upvoted"] !=
                                          null &&
                                      widget.videosList[_commonController
                                          .currentIndex.value]["upvoted"]
                                  ? whiteColor
                                  : whiteColor,
                            ),
                          ),
                        ),
                        customHeight(3),
                        Text(
                          widget
                              .videosList[_commonController.currentIndex.value]
                                  ['upvote_count']
                              .toString(),
                          style: AppTextStyle.normalSemiBold13,
                        ),
                      ],
                    ),
                  ),
                  height5,
                  homeSideBarItem(
                    icon: AppAsset.iccomment,
                    label: widget.videosList[_commonController
                                .currentIndex.value]['comment_count'] !=
                            null
                        ? widget
                            .videosList[_commonController.currentIndex.value]
                                ['comment_count']
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
                                  topLeft: Radius.circular(30))),
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                              heightFactor: 1,
                              child: CommentWidget(
                                postID: widget.videosList[_commonController
                                        .currentIndex.value]["id"]
                                    .toString(),
                                commentCount: widget.videosList[
                                        _commonController.currentIndex.value]
                                    ['comment_count'],
                                index: _commonController.currentIndex.value,
                                dataList: widget.videosList[
                                    _commonController.currentIndex.value],
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
                    // widget
                    //     .videosList[_commonController.currentIndex.value]
                    //         ['share_count']
                    //     .toString(),
                    ontap: () async {
                      if (dataStorage.read('isLogging') == true) {
                        widget.videosList[_commonController.currentIndex.value]
                            ['share_count']++;
                        _commonController.update();
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
                            isFromVideoPlayer: true,
                            videoLink: widget.videosList[_commonController
                                .currentIndex.value]["video_link"],
                            onSaveVideoTap: () async {
                              Get.back();
                              _commonController.downloadFile(
                                title: widget.videosList[_commonController
                                    .currentIndex.value]["identifier"],
                                videoUrl: widget.videosList[_commonController
                                    .currentIndex.value]["video_link"],
                              );
                            },
                            identifier: widget.videosList[_commonController
                                    .currentIndex.value]["identifier"]
                                .toString(),
                            slug: widget.videosList[_commonController
                                    .currentIndex.value]["slug"]
                                .toString(),
                            theme: theme,
                            isOwner: (widget.videosList[_commonController
                                        .currentIndex.value]["username"]
                                    .toString() !=
                                dataStorage.read('username').toString()),
                            pageController: widget.pageController,
                            currentIndex: _commonController.currentIndex,
                          );
                        },
                      );
                    },
                  ),
                  height5,
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      if (_commonController.isViewMode.value == true) {
                        setState(() {
                          _commonController.isViewMode.value = false;
                        });
                      } else {
                        setState(() {
                          _commonController.isViewMode.value = true;
                        });
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
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.fullscreen_rounded,
                            color: whiteColor,
                            size: 25,
                          ),
                        ),
                        customHeight(3),
                        const Text(
                          'View',
                          style: AppTextStyle.normalSemiBold13,
                        ),
                      ],
                    ),
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
                  //     //   await _commonController.pipFlutterPlayerController.value
                  //     //       .enablePictureInPicture(
                  //     //           _commonController.pipFlutterPlayerKey);
                  //     //   _commonController.isPlaying.value = false;
                  //     //   videoPlayerController?.value.pause();
                  //     //   if (Platform.isIOS) {
                  //     //     Timer(const Duration(seconds: 1), () {
                  //     //       MoveToBackground.moveTaskToBack();
                  //     //     });
                  //     //   }
                  //     // } else {
                  //     await _commonController.permisiionhandler();
                  //     // }
                  //   },
                  // ),
                  // height5,
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
              shape: BoxShape.circle,
              color: whiteColor.withOpacity(0.10),
            ),
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              icon,
              color: color,
            ),
          ),
          // height5,
          customHeight(3),
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
          _commonController.isAutoplay.value = false;
          _commonController.isPlaying.value = false;
          _commonController
              .videoController(_commonController.currentIndex.value)
              ?.pause();
          Get.to(
            () => ProfileScreen(
              fromMainUser: false,
              updateUserStatus: (bool isFollow) {
                widget.videosList[_commonController.currentIndex.value]
                    ["following"] = isFollow;
                _commonController.update();
              },
              profileUsername: widget.videosList[index]["username"],
            ),
          )!
              .then((value) {
            _commonController.isAutoplay.value = true;
            _commonController.isPlaying.value = true;
            _commonController
                .videoController(_commonController.currentIndex.value)
                ?.play();
            setState(() {});
          });
        } else {
          _mainHomeScreenController.showAuthBottomSheet(
            context: context,
          );
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
