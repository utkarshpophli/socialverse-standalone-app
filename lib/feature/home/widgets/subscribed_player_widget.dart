// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:socialverse/export.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:socialverse/feature/home/controllers/subscribed_player_controller.dart';
// import 'home_comment_widget.dart';

// Rx<VideoPlayerController>? subsribedVideoPlayerController =
//     Rx<VideoPlayerController>(VideoPlayerController.network(
//         "https://vs.watchflic.com/Nisar75_56fcf28c10a93a18e66cd2218b2410e610441d4b787/hls/Nisar75_56fcf28c10a93a18e66cd2218b2410e610441d4b787.m3u8"));

// // ignore: must_be_immutable
// class SubscribedVideoWidget extends StatefulWidget {
//   RxList videosList = [].obs;
//   final bool fromHomePage;
//   final int videoIndex;
//   final Rx<PageController> pageController;

//   SubscribedVideoWidget(
//       {Key? key,
//       required this.videoIndex,
//       required this.videosList,
//       required this.fromHomePage,
//       required this.pageController})
//       : super(key: key);

//   @override
//   _SubscribedVideoWidgetState createState() => _SubscribedVideoWidgetState();
// }

// class _SubscribedVideoWidgetState extends State<SubscribedVideoWidget> {
//   final SubscribedCommonVideoPlayerController _controller =
//       Get.put(SubscribedCommonVideoPlayerController());
//   final HomeController homeController = Get.put(HomeController());

//   bool downloading = false;
//   bool downloadingCompleted = false;
//   var progressString = "";

//   Future<void> downloadFile(
//       {required String videoUrl, required String title}) async {
//     Dio dio = Dio();
//     try {
//       var dir;
//       if (Platform.isAndroid) {
//         dir = Directory('/storage/emulated/0/Download');
//         if (!await dir.exists()) dir = await getExternalStorageDirectory();
//       } else {
//         dir = await getApplicationDocumentsDirectory();
//       }
//       print("path ${dir.path}");
//       await dio.download(videoUrl, '${dir.path}/$title.mp4',
//           onReceiveProgress: (rec, total) {
//         print("Rec: $rec , Total: $total");
//         setState(() {
//           downloading = true;
//           progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//     setState(() {
//       downloading = false;
//       downloadingCompleted = true;
//       progressString = "Completed";
//     });
//     Future.delayed(Duration(seconds: 2)).then(
//       (value) {
//         setState(() {
//           downloadingCompleted = false;
//         });
//         var dir;
//         if (Platform.isAndroid) {
//           dir = Directory('/storage/emulated/0/Download');
//         } else {
//           dir = getApplicationDocumentsDirectory();
//         }
//         File file = File('${dir.path}/$title.mp4');
//         Share.shareFiles([
//           file.path,
//         ], text: 'Share Video');
//         print(
//           "File Saved to App Documentary",
//         );
//       },
//     );
//     print("Download completed");
//   }

//   RxInt currentIndex = 0.obs;
//   onPageChanged(index) async {
//     subsribedVideoPlayerController!.value.dispose();
//     subsribedVideoPlayerController!.value =
//         VideoPlayerController.network(widget.videosList[index]["video_link"]);
//     subsribedVideoPlayerController!.value.addListener(
//       () {
//         _controller.update();
//       },
//     );

//     subsribedVideoPlayerController!.value.setLooping(true);
//     subsribedVideoPlayerController!.value.initialize().then(
//       (_) {
//         if (_controller.isAutoplay.value == true) {
//           subsribedVideoPlayerController!.value.play();
//         }
//         _controller.update();
//       },
//     );
//     currentIndex.value = index;
//     // PipFlutterPlayerDataSource dataSource = PipFlutterPlayerDataSource(
//     //   PipFlutterPlayerDataSourceType.network,
//     //   widget.videosList[index]["video_link"],
//     // );
//     // _controller.pipFlutterPlayerController.value = PipFlutterPlayerController(
//     //   PipFlutterPlayerConfiguration(
//     //     eventListener: (PipFlutterPlayerEvent value) {
//     //       if (PipFlutterPlayerEventType.pipStart ==
//     //           value.pipFlutterPlayerEventType) {
//     //         _controller.pipFlutterPlayerController.value.play();
//     //       }
//     //       if (PipFlutterPlayerEventType.pipStop ==
//     //           value.pipFlutterPlayerEventType) {
//     //         _controller.pipFlutterPlayerController.value.pause();
//     //         _controller.isPlaying.value = true;
//     //       }
//     //     },
//     //     aspectRatio: 9 / 16,
//     //     // fit: BoxFit.cover,
//     //     controlsConfiguration: const PipFlutterPlayerControlsConfiguration(
//     //       enablePlayPause: false,
//     //     ),
//     //     // autoPlay: true,
//     //     deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//     //     deviceOrientationsOnFullScreen: [DeviceOrientation.portraitUp],
//     //   ),
//     // );
//     // _controller.pipFlutterPlayerController.value.setupDataSource(dataSource);
//     // _controller.pipFlutterPlayerController.value
//     //     .setPipFlutterPlayerGlobalKey(_controller.pipFlutterPlayerKey);
//     // // videoController.pipFlutterPlayerController.value.pause();
//     // _controller.isPinch.value = false;
//     _controller.update();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryBlack,
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           GetBuilder<SubscribedCommonVideoPlayerController>(
//             initState: (state) async {
//               _controller.isAutoplay.value = true;
//               currentIndex.value = widget.videoIndex;
//               await _controller.initializePlayer(
//                 widget.videosList[widget.videoIndex]["video_link"],
//               );
//             },
//             dispose: (state) {
//               _controller.isAutoplay.value = false;
//               _controller.isPlaying.value = false;
//               // subsribedVideoPlayerController!.value.pause();
//               // TODO: dispose video player controller
//             },
//             builder: (_) {
//               bool theme = dataStorage.read("isDarkMode");
//               return Stack(
//                 children: [
//                   PageView.builder(
//                     controller: widget.pageController.value,
//                     onPageChanged: (index) async {
//                       onPageChanged(index);
//                     },
//                     scrollDirection: Axis.vertical,
//                     itemCount: widget.videosList.length,
//                     itemBuilder: (context, i) {
//                       // Future.delayed(const Duration(seconds: 1));

//                       return _controller
//                               .pipFlutterPlayerController.value.isFullScreen
//                           ? Stack(
//                               children: [
//                                 Container(
//                                   height: 1,
//                                   width: 1,
//                                   color: purpleColor,
//                                   child: PipFlutterPlayer(
//                                     controller: _controller
//                                         .pipFlutterPlayerController.value,
//                                     key: _controller.pipFlutterPlayerKey,
//                                   ),
//                                 ),
//                                 VideoPlayer(
//                                     subsribedVideoPlayerController!.value)
//                               ],
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 if (subsribedVideoPlayerController!
//                                     .value.value.isPlaying) {
//                                   _controller.isPlaying.value = false;
//                                   subsribedVideoPlayerController!.value.pause();
//                                 } else {
//                                   _controller.isPlaying.value = true;
//                                   subsribedVideoPlayerController!.value.play();
//                                 }
//                                 // videoPlayerGetXController.update();
//                               },
//                               onLongPress: () {
//                                 showModalBottomSheet(
//                                   backgroundColor: primaryBlack,
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(30.0),
//                                       topRight: Radius.circular(30.0),
//                                     ),
//                                   ),
//                                   context: context,
//                                   builder: (context) {
//                                     return MoreBottomSheet(
//                                       // onPostDeleteTap: () {},
//                                       videoLink:
//                                           widget.videosList[currentIndex.value]
//                                               ["video_link"],
//                                       onSaveVideoTap: () async {
//                                         Get.back();
//                                         downloadFile(
//                                           title: widget.videosList[
//                                               currentIndex.value]["identifier"],
//                                           videoUrl: widget.videosList[
//                                               currentIndex.value]["video_link"],
//                                         );
//                                       },
//                                       bookmarkIcon:
//                                           widget.videosList[currentIndex.value]
//                                                           ["bookmarked"] !=
//                                                       null &&
//                                                   widget.videosList[currentIndex
//                                                       .value]["bookmarked"]
//                                               ? Icons.bookmark
//                                               : Icons.bookmark_outline_outlined,
//                                       onBookmarkTap: () {
//                                         Get.back();
//                                         if (dataStorage.read('isLogging') ==
//                                             true) {
//                                           if (widget.videosList[currentIndex
//                                               .value]["bookmarked"]) {
//                                             widget.videosList[currentIndex
//                                                 .value]["bookmarked"] = false;
//                                             _controller.postBookmarkRemove(
//                                               context,
//                                               identifier: widget.videosList[
//                                                       currentIndex.value]
//                                                   ["identifier"],
//                                               slug: widget.videosList[
//                                                   currentIndex.value]["slug"],
//                                             );
//                                             _controller.update();
//                                           } else {
//                                             widget.videosList[currentIndex
//                                                 .value]["bookmarked"] = true;
//                                             _controller.postBookmarkAdd(
//                                               context,
//                                               identifier: widget.videosList[
//                                                       currentIndex.value]
//                                                   ["identifier"],
//                                               slug: widget.videosList[
//                                                   currentIndex.value]["slug"],
//                                             );
//                                             _controller.update();
//                                           }
//                                         } else {
//                                           showModalBottomSheet(
//                                             shape: const RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.only(
//                                                     topLeft:
//                                                         Radius.circular(30.0),
//                                                     topRight:
//                                                         Radius.circular(30.0))),
//                                             context: context,
//                                             builder: (context) {
//                                               return const AuthBottomSheet();
//                                             },
//                                           );
//                                         }
//                                       },
//                                       identifier: widget
//                                           .videosList[currentIndex.value]
//                                               ["identifier"]
//                                           .toString(),
//                                       slug: widget
//                                           .videosList[currentIndex.value]
//                                               ["slug"]
//                                           .toString(),
//                                       theme: theme,
//                                       isowner: widget
//                                               .videosList[currentIndex.value]
//                                                   ["username"]
//                                               .toString() !=
//                                           dataStorage
//                                               .read('username')
//                                               .toString(),
//                                       pageController: widget.pageController,
//                                       currentIndex: currentIndex,
//                                     );
//                                   },
//                                 );
//                                 HapticFeedback.mediumImpact();
//                               },
//                               onDoubleTap: () {
//                                 HapticFeedback.mediumImpact();
//                                 if (dataStorage.read('isLogging') == true) {
//                                   _controller.isLiked.value = true;
//                                   if (widget.videosList[i]["upvoted"]) {
//                                     widget.videosList[i]["upvoted"] =
//                                         !widget.videosList[i]["upvoted"];
//                                     widget.videosList[i]['upvote_count']--;
//                                     _controller.postLikeRemove(
//                                       identifier: widget.videosList[i]
//                                           ["identifier"],
//                                       slug: widget.videosList[i]["slug"],
//                                     );
//                                     _controller.update();
//                                   } else {
//                                     widget.videosList[i]["upvoted"] =
//                                         !widget.videosList[i]["upvoted"];

//                                     widget.videosList[i]['upvote_count']++;
//                                     _controller.postLikeAdd(
//                                       identifier: widget.videosList[i]
//                                           ["identifier"],
//                                       slug: widget.videosList[i]["slug"],
//                                     );
//                                     _controller.update();
//                                   }

//                                   Timer(const Duration(seconds: 1), () {
//                                     _controller.isLiked.value = false;
//                                   });
//                                   _controller.update();
//                                 } else {
//                                   showModalBottomSheet(
//                                     shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(30.0),
//                                             topRight: Radius.circular(30.0))),
//                                     context: context,
//                                     builder: (context) {
//                                       return const AuthBottomSheet();
//                                     },
//                                   );
//                                 }
//                               },
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     height: MediaQuery.of(context).size.height,
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                       color: primaryBlack,
//                                       image: DecorationImage(
//                                         image: widget.videosList[i]
//                                                     ["thumbnail_url"] !=
//                                                 'null'
//                                             ? NetworkImage(
//                                                 widget.videosList[i]
//                                                     ["thumbnail_url"],
//                                               )
//                                             : null as ImageProvider,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         // if (subsribedVideoPlayerController!
//                                         //     .value.value.isInitialized)
//                                         //   SizedBox(
//                                         //     height: 0,
//                                         //     width: 0,
//                                         //     child: PipFlutterPlayer(
//                                         //       controller: _controller
//                                         //           .pipFlutterPlayerController
//                                         //           .value,
//                                         //       key: _controller
//                                         //           .pipFlutterPlayerKey,
//                                         //     ),
//                                         //   ),
//                                         subsribedVideoPlayerController!
//                                                 .value.value.isInitialized
//                                             ?
//                                             // VideoPlayer(
//                                             //     subsribedVideoPlayerController!.value)

//                                             //====================
//                                             InteractiveViewer(
//                                                 panEnabled: false,
//                                                 maxScale: 1.0,
//                                                 minScale: 1.0,
//                                                 onInteractionStart: (_) {
//                                                   _controller.isPinch.value =
//                                                       !_controller
//                                                           .isPinch.value;
//                                                   _controller.update();
//                                                 },
//                                                 child:
//                                                     // _controller.isPinch.value ==
//                                                     //         false
//                                                     //     ?
//                                                     SizedBox.expand(
//                                                   child: FittedBox(
//                                                     fit: BoxFit.cover,
//                                                     child: SizedBox(
//                                                       width:
//                                                           subsribedVideoPlayerController!
//                                                               .value
//                                                               .value
//                                                               .size
//                                                               .width,
//                                                       height:
//                                                           subsribedVideoPlayerController!
//                                                               .value
//                                                               .value
//                                                               .size
//                                                               .height,
//                                                       child: VideoPlayer(
//                                                           subsribedVideoPlayerController!
//                                                               .value),
//                                                     ),
//                                                   ),
//                                                 )
//                                                 //     :
//                                                 //     SizedBox.expand(
//                                                 //   child: FittedBox(
//                                                 //     fit: BoxFit.cover,
//                                                 //     child: Container(
//                                                 //       width:
//                                                 //           subsribedVideoPlayerController!
//                                                 //               .value
//                                                 //               .value
//                                                 //               .size
//                                                 //               .width,
//                                                 //       height:
//                                                 //           subsribedVideoPlayerController!
//                                                 //               .value
//                                                 //               .value
//                                                 //               .size
//                                                 //               .height,
//                                                 //       padding: EdgeInsets.only(
//                                                 //           bottom:
//                                                 //               Get.height * 0.13,
//                                                 //           top: 40),
//                                                 //       child: VideoPlayer(
//                                                 //           subsribedVideoPlayerController!
//                                                 //               .value),
//                                                 //     ),
//                                                 //   ),
//                                                 // ),
//                                                 )
//                                             : Container(),
//                                         Positioned(
//                                           bottom: widget.fromHomePage == true
//                                               ? Get.height * 0.1
//                                               : 20,
//                                           child: SizedBox(
//                                               height: 8,
//                                               width: Get.width,
//                                               child: VideoProgressIndicator(
//                                                 subsribedVideoPlayerController!
//                                                     .value,
//                                                 allowScrubbing: true,
//                                                 colors:
//                                                     const VideoProgressColors(
//                                                   bufferedColor: primaryWhite,
//                                                   backgroundColor: primaryWhite,
//                                                   playedColor: purpleColor,
//                                                 ),
//                                               )),
//                                         ),
//                                         if (downloading == true)
//                                           Positioned(
//                                             bottom: widget.fromHomePage == true
//                                                 ? Get.height * 0.1
//                                                 : 20,
//                                             child: Container(
//                                               height: 25,
//                                               width: Get.width,
//                                               color:
//                                                   Colors.grey.withOpacity(0.4),
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                   horizontal: 16,
//                                                   vertical: 3,
//                                                 ),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       'Downloading Video: $progressString',
//                                                       style: AppTextStyle
//                                                           .normalBold12,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         if (downloadingCompleted == true)
//                                           Positioned(
//                                             bottom: widget.fromHomePage == true
//                                                 ? Get.height * 0.1
//                                                 : 20,
//                                             child: Container(
//                                               height: 25,
//                                               width: Get.width,
//                                               color: Colors.green,
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                   horizontal: 16,
//                                                   vertical: 3,
//                                                 ),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       'Download Completed',
//                                                       style: AppTextStyle
//                                                           .normalBold12,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         if (widget.fromHomePage != true)
//                                           Positioned(
//                                             top: 35,
//                                             left: 15,
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 Get.back();
//                                               },
//                                               child: Container(
//                                                 // margin:
//                                                 //     const EdgeInsets.symmetric(
//                                                 //         horizontal: 20,
//                                                 //         vertical: 20),
//                                                 height: 50,
//                                                 width: 50,
//                                                 decoration: BoxDecoration(
//                                                   color: whiteColor
//                                                       .withOpacity(.2),
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 child: const Icon(
//                                                   Icons
//                                                       .arrow_back_ios_new_outlined,
//                                                   size: 16,
//                                                   color: primaryWhite,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: widget.fromHomePage == true
//                                         ? downloading ||
//                                                 downloadingCompleted == true
//                                             ? Get.height * 0.14
//                                             : Get.height * 0.12
//                                         : 30,
//                                     left: 15,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         if (widget.videosList[i]["category"]
//                                             .isNotEmpty)
//                                           InkWell(
//                                             onTap: () {
//                                               // log("tap");
//                                               HapticFeedback.mediumImpact();
//                                               _controller.spheresOnTap(
//                                                 context,
//                                                 name: widget.videosList[i]
//                                                     ["category"]["name"],
//                                                 desc: widget.videosList[i]
//                                                     ["category"]["description"],
//                                                 id: widget.videosList[i]
//                                                     ["category"]["id"],
//                                                 count: widget.videosList[i]
//                                                     ["category"]["count"],
//                                                 photourl: widget.videosList[i]
//                                                     ["category"]["image_url"],
//                                               );
//                                               if (subsribedVideoPlayerController!
//                                                   .value.value.isPlaying) {
//                                                 _controller.isPlaying.value =
//                                                     false;
//                                                 subsribedVideoPlayerController!
//                                                     .value
//                                                     .pause();
//                                               } else {
//                                                 // _controller.isPlaying.value =
//                                                 //     true;
//                                                 // subsribedVideoPlayerController!.value
//                                                 //     .play();
//                                               }
//                                             },
//                                             child: (widget.videosList[i]
//                                                                 ["category"]
//                                                             ["name"] !=
//                                                         "Uncategorized" &&
//                                                     widget.videosList[i]
//                                                                 ["category"]
//                                                             ["name"] !=
//                                                         "")
//                                                 ? Container(
//                                                     // decoration: BoxDecoration(
//                                                     //     color: primaryBlack
//                                                     //         .withOpacity(0.70),
//                                                     //     borderRadius:
//                                                     //         BorderRadius
//                                                     //             .circular(30)),
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             horizontal: 0,
//                                                             vertical: 3),
//                                                     child: Text(
//                                                         widget.videosList[i]
//                                                                 ["category"]
//                                                             ["name"],
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: AppTextStyle
//                                                             .normalRegular18),
//                                                   )
//                                                 : SizedBox(),
//                                           ),
//                                         SizedBox(
//                                           width: Get.width - 80,
//                                           child: Row(
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   _controller.isAutoplay.value =
//                                                       false;
//                                                   _controller.isPlaying.value =
//                                                       false;
//                                                   subsribedVideoPlayerController!
//                                                       .value
//                                                       .pause();
//                                                   if (dataStorage
//                                                           .read('isLogging') ==
//                                                       true) {
//                                                     Get.to(
//                                                       () => ProfileScreen(
//                                                         fromMainUser: false,
//                                                         updateUserStatus:
//                                                             (bool isFollow) {
//                                                           widget.videosList[
//                                                                       currentIndex
//                                                                           .value]
//                                                                   [
//                                                                   "following"] =
//                                                               isFollow;
//                                                           _controller.update();
//                                                         },
//                                                         profileUsername: widget
//                                                             .videosList[i]
//                                                                 ["username"]
//                                                             .toString(),
//                                                       ),
//                                                     )!
//                                                         .then((value) {
//                                                       _controller.isPlaying
//                                                           .value = true;
//                                                       _controller.isAutoplay
//                                                           .value = true;
//                                                       subsribedVideoPlayerController!
//                                                           .value
//                                                           .play();
//                                                     });
//                                                   } else {
//                                                     showModalBottomSheet(
//                                                       shape:
//                                                           const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   30.0),
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   30.0),
//                                                         ),
//                                                       ),
//                                                       context: context,
//                                                       builder: (context) {
//                                                         return const AuthBottomSheet();
//                                                       },
//                                                     );
//                                                   }

//                                                   setState(() {});
//                                                 },
//                                                 child: Text(
//                                                   "@" +
//                                                       widget.videosList[i]
//                                                           ["username"],
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: AppTextStyle
//                                                       .normalSemiBold18,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         customHeight(5),
//                                         SizedBox(
//                                           width: Get.width - 100,
//                                           child: Text(
//                                             widget.videosList[i]["title"]
//                                                 .toString(),
//                                             // overflow: TextOverflow.ellipsis,
//                                             style: AppTextStyle.normalRegular14,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   // Obx(
//                                   //   () => !_controller.isPlaying.value
//                                   //       ? Center(
//                                   //           child: Icon(
//                                   //             Icons.play_arrow,
//                                   //             color: primaryWhite,
//                                   //             size: 50,
//                                   //           ),
//                                   //         )
//                                   //       : SizedBox(),
//                                   // ),
//                                   Obx(
//                                     () => !subsribedVideoPlayerController!
//                                             .value.value.isPlaying
//                                         ? Center(
//                                             child: Icon(
//                                               Icons.play_arrow_rounded,
//                                               color: primaryWhite.withOpacity(
//                                                 0.4,
//                                               ),
//                                               size: 65,
//                                             ),
//                                           )
//                                         : SizedBox(),
//                                   ),
//                                   Obx(() => _controller.isLiked.value
//                                       ? Center(
//                                           child: Image.asset(
//                                             AppAsset.like,
//                                             color: primaryWhite,
//                                             height: 150,
//                                           ),
//                                         )
//                                       : Offstage()),
//                                 ],
//                               ),
//                             );
//                     },
//                   ),
//                   widget.fromHomePage == true
//                       ? homeController.feedPostList.isNotEmpty
//                           ? Container(
//                               height: Get.height,
//                               alignment: Alignment.bottomRight,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   homeSideBar(theme),
//                                   SizedBox(
//                                     height: widget.fromHomePage == true
//                                         ? Get.height * 0.13
//                                         : 50,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : Offstage()
//                       : Container(
//                           height: Get.height,
//                           alignment: Alignment.bottomRight,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               homeSideBar(theme),
//                               SizedBox(
//                                 height: widget.fromHomePage == true ? 100 : 50,
//                               ),
//                             ],
//                           ),
//                         ),
//                 ],
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }

//   Widget homeSideBar(theme) {
//     return Obx(
//       () => widget.videosList.isEmpty
//           ? SizedBox()
//           : Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Column(
//                 children: [
//                   (widget.videosList[currentIndex.value]["username"]
//                               .toString() !=
//                           dataStorage.read('username').toString())
//                       ? Stack(
//                           children: [
//                             if (widget.videosList[currentIndex.value]
//                                     ["following"] ==
//                                 true)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 25),
//                                 child: followArrowWidget(
//                                   icon: Icons.arrow_downward_outlined,
//                                   index: currentIndex.value,
//                                 ),
//                               ),
//                             (widget.videosList[currentIndex.value]
//                                         ["following"] ==
//                                     false)
//                                 ? followArrowWidget(
//                                     icon: Icons.arrow_upward_rounded,
//                                     index: currentIndex.value,
//                                   )
//                                 : profileImageWidget(
//                                     index: currentIndex.value,
//                                     onDrag: (value) {
//                                       if (dataStorage.read('isLogging') ==
//                                           true) {
//                                         _controller.followUser(
//                                           context,
//                                           widget.videosList[currentIndex.value]
//                                               ["username"],
//                                           widget.videosList[currentIndex.value]
//                                               ["following"],
//                                         );
//                                         widget.videosList[currentIndex.value]
//                                             ["following"] = false;
//                                         _controller.update();
//                                       } else {
//                                         showModalBottomSheet(
//                                           shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(30.0),
//                                               topRight: Radius.circular(30.0),
//                                             ),
//                                           ),
//                                           context: context,
//                                           builder: (context) {
//                                             return const AuthBottomSheet();
//                                           },
//                                         );
//                                       }
//                                     },
//                                   ),
//                             if (widget.videosList[currentIndex.value]
//                                     ["following"] ==
//                                 false)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: profileImageWidget(
//                                     index: currentIndex.value,
//                                     onDrag: (value) {
//                                       if (dataStorage.read('isLogging') ==
//                                           true) {
//                                         _controller.followUser(
//                                           context,
//                                           widget.videosList[currentIndex.value]
//                                               ["username"],
//                                           widget.videosList[currentIndex.value]
//                                               ["following"],
//                                         );
//                                         widget.videosList[currentIndex.value]
//                                             ["following"] = true;
//                                         _controller.update();
//                                       } else {
//                                         showModalBottomSheet(
//                                           shape: const RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft:
//                                                       Radius.circular(30.0),
//                                                   topRight:
//                                                       Radius.circular(30.0))),
//                                           context: context,
//                                           builder: (context) {
//                                             return const AuthBottomSheet();
//                                           },
//                                         );
//                                       }
//                                     }),
//                               ),
//                           ],
//                         )
//                       : profileImageWidget(
//                           index: currentIndex.value,
//                         ),
//                   height5,
//                   InkWell(
//                     onTap: () {
//                       if (dataStorage.read('isLogging') == true) {
//                         if (widget.videosList[currentIndex.value]["upvoted"]) {
//                           widget.videosList[currentIndex.value]["upvoted"] =
//                               false;
//                           widget.videosList[currentIndex.value]
//                               ['upvote_count']--;
//                           _controller.postLikeRemove(
//                             identifier: widget.videosList[currentIndex.value]
//                                 ["identifier"],
//                             slug: widget.videosList[currentIndex.value]["slug"],
//                           );
//                           _controller.update();
//                         } else {
//                           widget.videosList[currentIndex.value]["upvoted"] =
//                               true;
//                           widget.videosList[currentIndex.value]
//                               ['upvote_count']++;
//                           _controller.postLikeAdd(
//                             identifier: widget.videosList[currentIndex.value]
//                                 ["identifier"],
//                             slug: widget.videosList[currentIndex.value]["slug"],
//                           );
//                           _controller.update();
//                         }
//                       } else {
//                         showModalBottomSheet(
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(30.0),
//                                   topRight: Radius.circular(30.0))),
//                           context: context,
//                           builder: (context) {
//                             return const AuthBottomSheet();
//                           },
//                         );
//                       }
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 45,
//                           width: 50,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: whiteColor.withOpacity(0.10)),
//                           padding: const EdgeInsets.all(14),
//                           child: ShaderMask(
//                               shaderCallback: (Rect bounds) {
//                                 return widget.videosList[currentIndex.value]
//                                                 ["upvoted"] !=
//                                             null &&
//                                         widget.videosList[currentIndex.value]
//                                             ["upvoted"]
//                                     ? const LinearGradient(
//                                         begin: Alignment.centerLeft,
//                                         end: Alignment.centerRight,
//                                         colors: <Color>[
//                                           purpleColor,
//                                           Colors.pink,
//                                           appColor
//                                         ],
//                                         tileMode: TileMode.repeated,
//                                       ).createShader(bounds)
//                                     : const LinearGradient(
//                                         colors: <Color>[
//                                           Colors.white,
//                                           Colors.white
//                                         ],
//                                       ).createShader(bounds);
//                               },
//                               child: SvgPicture.asset(
//                                 AppAsset.iclike,
//                                 color: widget.videosList[currentIndex.value]
//                                                 ["upvoted"] !=
//                                             null &&
//                                         widget.videosList[currentIndex.value]
//                                             ["upvoted"]
//                                     ? whiteColor
//                                     : whiteColor,
//                               )),
//                         ),
//                         customHeight(2),
//                         Text(
//                           widget.videosList[currentIndex.value]['upvote_count']
//                               .toString(),
//                           style: AppTextStyle.normalSemiBold13,
//                         ),
//                       ],
//                     ),
//                   ),
//                   height5,
//                   homeSideBarItem(
//                     icon: AppAsset.iccomment,
//                     label: widget.videosList[currentIndex.value]
//                                 ['comment_count'] !=
//                             null
//                         ? widget.videosList[currentIndex.value]['comment_count']
//                             .toString()
//                         : "...",
//                     ontap: () {
//                       if (dataStorage.read('isLogging') == true) {
//                         showModalBottomSheet(
//                           constraints:
//                               BoxConstraints(maxHeight: Get.height / 1.35),
//                           isScrollControlled: true,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(30),
//                               topLeft: Radius.circular(30),
//                             ),
//                           ),
//                           context: context,
//                           builder: (BuildContext context) {
//                             return FractionallySizedBox(
//                               heightFactor: 1,
//                               child: HomeCommentWidget(
//                                 commentCount:
//                                     widget.videosList[currentIndex.value]
//                                         ['comment_count'],
//                                 identifier: widget
//                                     .videosList[currentIndex.value]
//                                         ["identifier"]
//                                     .toString(),
//                                 slug: widget.videosList[currentIndex.value]
//                                         ["slug"]
//                                     .toString(),
//                                 index: currentIndex.value,
//                                 dataList: widget.videosList[currentIndex.value],
//                               ),
//                             );
//                           },
//                         ).then((value) {});
//                       } else {
//                         showModalBottomSheet(
//                           backgroundColor: primaryBlack,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30.0),
//                               topRight: Radius.circular(30.0),
//                             ),
//                           ),
//                           context: context,
//                           builder: (context) {
//                             return const AuthBottomSheet();
//                           },
//                         );
//                       }
//                     },
//                   ),
//                   height5,

//                   InkWell(
//                     onTap: () {
//                       if (dataStorage.read('isLogging') == true) {
//                         if (widget.videosList[currentIndex.value]
//                             ["bookmarked"]) {
//                           widget.videosList[currentIndex.value]["bookmarked"] =
//                               false;
//                           _controller.postBookmarkRemove(
//                             context,
//                             identifier: widget.videosList[currentIndex.value]
//                                 ["identifier"],
//                             slug: widget.videosList[currentIndex.value]["slug"],
//                           );
//                           _controller.update();
//                         } else {
//                           widget.videosList[currentIndex.value]["bookmarked"] =
//                               true;
//                           _controller.postBookmarkAdd(
//                             context,
//                             identifier: widget.videosList[currentIndex.value]
//                                 ["identifier"],
//                             slug: widget.videosList[currentIndex.value]["slug"],
//                           );
//                           _controller.update();
//                         }
//                       } else {
//                         showModalBottomSheet(
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(30.0),
//                                   topRight: Radius.circular(30.0))),
//                           context: context,
//                           builder: (context) {
//                             return const AuthBottomSheet();
//                           },
//                         );
//                       }
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 45,
//                           width: 50,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: whiteColor.withOpacity(0.10)),
//                           padding: const EdgeInsets.all(14),
//                           child: ShaderMask(
//                               shaderCallback: (Rect bounds) {
//                                 return widget.videosList[currentIndex.value]
//                                                 ["bookmarked"] !=
//                                             null &&
//                                         widget.videosList[currentIndex.value]
//                                             ["bookmarked"]
//                                     ? const LinearGradient(
//                                         begin: Alignment.centerLeft,
//                                         end: Alignment.centerRight,
//                                         colors: <Color>[
//                                           purpleColor,
//                                           Colors.pink,
//                                           appColor
//                                         ],
//                                         tileMode: TileMode.repeated,
//                                       ).createShader(bounds)
//                                     : const LinearGradient(
//                                         colors: <Color>[
//                                           Colors.white,
//                                           Colors.white
//                                         ],
//                                       ).createShader(bounds);
//                               },
//                               child: Icon(
//                                 Icons.bookmark,
//                                 color: whiteColor,
//                                 size: 19,
//                               )
//                               // SvgPicture.asset(
//                               //   AppAsset.iclike,
//                               //   color: widget.videosList[currentIndex.value]
//                               //                   ["upvoted"] !=
//                               //               null &&
//                               //           widget.videosList[currentIndex.value]
//                               //               ["upvoted"]
//                               //       ? whiteColor
//                               //       : whiteColor,
//                               // ),
//                               ),
//                         ),
//                         customHeight(2),
//                         Text(
//                           'Save',
//                           style: AppTextStyle.normalSemiBold13,
//                         ),
//                       ],
//                     ),
//                   ),
//                   height5,
//                   homeSideBarItem(
//                     icon: AppAsset.icshare2,
//                     label: 'Share',
//                     // widget.videosList[currentIndex.value]['share_count']
//                     //     .toString(),
//                     ontap: () async {
//                       if (dataStorage.read('isLogging') == true) {
//                         widget.videosList[currentIndex.value]['share_count']++;
//                         _controller.update();
//                       }
//                       showModalBottomSheet(
//                         backgroundColor: primaryBlack,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30.0),
//                             topRight: Radius.circular(30.0),
//                           ),
//                         ),
//                         context: context,
//                         builder: (context) {
//                           return MoreBottomSheet(
//                             // onPostDeleteTap: () {},
//                             videoLink: widget.videosList[currentIndex.value]
//                                 ["video_link"],
//                             onSaveVideoTap: () async {
//                               Get.back();
//                               downloadFile(
//                                 title: widget.videosList[currentIndex.value]
//                                     ["identifier"],
//                                 videoUrl: widget.videosList[currentIndex.value]
//                                     ["video_link"],
//                               );
//                             },
//                             bookmarkIcon: widget.videosList[currentIndex.value]
//                                             ["bookmarked"] !=
//                                         null &&
//                                     widget.videosList[currentIndex.value]
//                                         ["bookmarked"]
//                                 ? Icons.bookmark
//                                 : Icons.bookmark_outline_outlined,
//                             onBookmarkTap: () {
//                               Get.back();
//                               if (dataStorage.read('isLogging') == true) {
//                                 if (widget.videosList[currentIndex.value]
//                                     ["bookmarked"]) {
//                                   widget.videosList[currentIndex.value]
//                                       ["bookmarked"] = false;
//                                   _controller.postBookmarkRemove(
//                                     context,
//                                     identifier:
//                                         widget.videosList[currentIndex.value]
//                                             ["identifier"],
//                                     slug: widget.videosList[currentIndex.value]
//                                         ["slug"],
//                                   );
//                                   _controller.update();
//                                 } else {
//                                   widget.videosList[currentIndex.value]
//                                       ["bookmarked"] = true;
//                                   _controller.postBookmarkAdd(
//                                     context,
//                                     identifier:
//                                         widget.videosList[currentIndex.value]
//                                             ["identifier"],
//                                     slug: widget.videosList[currentIndex.value]
//                                         ["slug"],
//                                   );
//                                   _controller.update();
//                                 }
//                               } else {
//                                 showModalBottomSheet(
//                                   shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(30.0),
//                                           topRight: Radius.circular(30.0))),
//                                   context: context,
//                                   builder: (context) {
//                                     return const AuthBottomSheet();
//                                   },
//                                 );
//                               }
//                             },
//                             identifier: widget.videosList[currentIndex.value]
//                                     ["identifier"]
//                                 .toString(),
//                             slug: widget.videosList[currentIndex.value]["slug"]
//                                 .toString(),
//                             theme: theme,
//                             isowner: (widget.videosList[currentIndex.value]
//                                         ["username"]
//                                     .toString() !=
//                                 dataStorage.read('username').toString()),
//                             pageController: widget.pageController,
//                             currentIndex: currentIndex,
//                           );
//                         },
//                       );
//                       // Share.share(
//                       //     widget.videosList[currentIndex.value]["video_link"]);
//                     },
//                   ),
//                   // homeSideBarItem(
//                   //   icon: AppAsset.icAspectRatio,
//                   //   color: whiteColor,
//                   //   label: "Pip",
//                   //   ontap: () async {
//                   //     // if (Platform.isIOS) {
//                   //     //   await _controller.pipFlutterPlayerController.value
//                   //     //       .enablePictureInPicture(
//                   //     //           _controller.pipFlutterPlayerKey);
//                   //     //   _controller.isPlaying.value = false;
//                   //     //   videoPlayerController?.value.pause();
//                   //     //   if (Platform.isIOS) {
//                   //     //     Timer(const Duration(seconds: 1), () {
//                   //     //       MoveToBackground.moveTaskToBack();
//                   //     //     });
//                   //     //   }
//                   //     // } else {
//                   //     await _controller.permisiionhandler();
//                   //     // }
//                   //   },
//                   // ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget homeSideBarItem({ontap, icon, label, color}) {
//     return InkWell(
//       onTap: ontap,
//       child: Column(
//         children: [
//           Container(
//               height: 45,
//               width: 50,
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle, color: whiteColor.withOpacity(0.10)),
//               padding: const EdgeInsets.all(14),
//               child: SvgPicture.asset(
//                 icon,
//                 color: color,
//               )),
//           // height5,
//           customHeight(2),
//           Text(
//             label,
//             style: AppTextStyle.normalSemiBold13,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget followArrowWidget({required IconData icon, required int index}) {
//     return Container(
//       height: 53,
//       width: 55,
//       alignment: widget.videosList[index]["following"] != false
//           ? Alignment.bottomCenter
//           : Alignment.topCenter,
//       decoration: BoxDecoration(
//         border: Border.all(color: primaryWhite, width: 2),
//         shape: BoxShape.circle,
//         color: purpleColor,
//       ),
//       child: Icon(
//         icon,
//         color: primaryWhite,
//         size: 30,
//       ),
//     );
//   }

//   Widget profileImageWidget({index, onDrag}) {
//     return GestureDetector(
//       onVerticalDragStart: onDrag,
//       onTap: () {
//         if (dataStorage.read('isLogging') == true) {
//           _controller.isAutoplay.value = false;
//           _controller.isPlaying.value = false;
//           subsribedVideoPlayerController!.value.pause();
//           Get.to(
//             () => ProfileScreen(
//               fromMainUser: false,
//               updateUserStatus: (bool isFollow) {
//                 widget.videosList[currentIndex.value]["following"] = isFollow;
//                 _controller.update();
//               },
//               profileUsername: widget.videosList[index]["username"],
//             ),
//           )!
//               .then((value) {
//             _controller.isAutoplay.value = true;
//             _controller.isPlaying.value = true;
//             subsribedVideoPlayerController!.value.play();
//             setState(() {});
//           });
//         } else {
//           showModalBottomSheet(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 topRight: Radius.circular(30.0),
//               ),
//             ),
//             context: context,
//             builder: (context) {
//               return const AuthBottomSheet();
//             },
//           );
//         }
//       },
//       child: UIInterface.profileImageWidget(
//         imgUrl: widget.videosList[index]["picture_url"],
//         height: 52,
//         width: 52,
//       ),
//     );
//   }
// }
