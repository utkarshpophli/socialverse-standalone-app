import 'dart:io';
import 'package:socialverse/export.dart';

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  String? postID;
  int? commentCount;
  int? index;
  dynamic dataList;
  CommentWidget(
      {Key? key, this.postID, this.index, this.commentCount, this.dataList})
      : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final CommentController _commentController = Get.put(CommentController());
  final CommonVideoPlayerController _videoController = Get.put(
    CommonVideoPlayerController(),
  );
  final MainHomeScreenController _mainHomeScreenController = Get.put(
    MainHomeScreenController(),
  );
  final FocusNode _focusNode = FocusNode();
  NetworkRepository networkRepository = NetworkRepository();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      initState: (state) {
        _commentController.isLongPress.value = false;
        _commentController.getComment(
          postID: widget.postID,
          context: context,
        );
      },
      builder: (controller) {
        bool theme = dataStorage.read("isDarkMode");
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            // color: primaryWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              children: [
                _commentController.isLongPress.value == false
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            Text(
                              _commentController.commentList.length.toString() +
                                  " comments",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                final _ct =
                                    Get.find<CommonVideoPlayerController>();
                                _ct.isSize.value = false;
                                _commentController.isLongPress.value = false;
                                _commentController.update();
                                _commentController.isLoading = false;
                                Get.back();
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Theme.of(context).errorColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        height: 40,
                        width: Get.width,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.circular(12)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _commentController.isLongPress.value = false;
                                _commentController.update();
                              },
                              child: Icon(
                                Icons.close,
                                color: primaryWhite,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // _commentController.deleteComment(
                                //   context,
                                //   widget.identifier,
                                //   widget.slug,
                                //   widget.dataList,
                                // );
                              },
                              child: Icon(
                                Icons.delete,
                                color: primaryWhite,
                              ),
                            )
                          ],
                        ),
                      ),
                Divider(
                  thickness: 0.1,
                  color: grey.withOpacity(0.4),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      _commentController.isLoading == true
                          ? Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: CustomProgressIndicator(),
                                  )
                                ],
                              ),
                            )
                          : bottomcommentSheet(theme),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: bottomTextField(theme, context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomcommentSheet(theme) {
    DateTime formatTimestamp(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return date;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView.builder(
        itemCount: _commentController.commentList.length,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 60),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Dismissible(
              key: Key(
                _commentController.commentList[index]["id"].toString(),
              ),
              background: Container(
                color: _commentController.commentList[index]["username"]
                            .toString() ==
                        dataStorage.read('username').toString()
                    ? red
                    : grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        _commentController.commentList[index]["username"]
                                    .toString() ==
                                dataStorage.read('username').toString()
                            ? Icons.delete_outline_rounded
                            : Icons.report_gmailerrorred_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              direction: DismissDirection.endToStart,
              dismissThresholds: {
                DismissDirection.endToStart: 0.35,
              },
              onDismissed: _commentController.commentList[index]["username"]
                          .toString() ==
                      dataStorage.read('username').toString()
                  ? (direction) {
                      _commentController.commentId = _commentController
                          .commentList[index]["id"]
                          .toString();
                      _commentController.deleteComment(
                        context: context,
                        dataList: widget.dataList,
                      );
                    }
                  : null,
              confirmDismiss: _commentController.commentList[index]["username"]
                          .toString() !=
                      dataStorage.read('username').toString()
                  ? (direction) {
                      return showDialog(
                        context: context,
                        builder: (context) => ErrorAlertDialog(
                          title: 'Report Comment',
                          action: 'Report',
                          theme: theme,
                          content: 'Do you want to report this comment?',
                          cancelTap: () {
                            Navigator.of(context).pop(false);
                          },
                          tap: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      );
                    }
                  : null,
              child: InkWell(
                // onLongPress: () {
                //   if (_commentController.commentList[index]["username"]
                //           .toString() ==
                //       dataStorage.read('username').toString()) {
                //     _commentController.isLongPress.value = true;
                //     _commentController.commentId =
                //         _commentController.commentList[index]["id"].toString();
                //     _commentController.update();
                //   } else {
                //     // log("message");
                //   }
                // },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _videoController.isAutoplay.value = false;
                        _videoController.isPlaying.value = false;
                        //todo managed
                        _videoController
                            .videoController(
                                _videoController.currentIndex.value)
                            ?.pause();
                        // videoPlayerController!.value.pause();
                        if (dataStorage.read('isLogging') == true) {
                          Get.to(
                            () => ProfileScreen(
                              fromMainUser: false,
                              updateUserStatus: (bool isFollow) {
                                // widget.videosList[
                                //             currentIndex
                                //                 .value]
                                //         [
                                //         "following"] =
                                //     isFollow;
                                // _videoController.update();
                              },
                              profileUsername: _commentController
                                  .commentList[index]["username"]
                                  .toString(),
                            ),
                          )!
                              .then((value) {
                            _videoController.isPlaying.value = true;
                            _videoController.isAutoplay.value = true;
                            //todo managed
                            _videoController
                                .videoController(
                                    _videoController.currentIndex.value)
                                ?.pause();
                            // videoPlayerController!.value.play();
                          });
                        } else {
                          _mainHomeScreenController.showAuthBottomSheet(
                            context: context,
                          );
                        }
                        setState(() {});
                      },
                      child: UIInterface.profileImageWidget(
                        imgUrl:
                            '${_commentController.commentList[index]["picture_url"]}',
                        height: 48,
                        width: 48,
                      ),
                    ),
                    width10,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _videoController.isAutoplay.value = false;
                          _videoController.isPlaying.value = false;
                          //todo managed
                          _videoController
                              .videoController(
                                  _videoController.currentIndex.value)
                              ?.pause();
                          // videoPlayerController!.value.pause();
                          if (dataStorage.read('isLogging') == true) {
                            Get.to(
                              () => ProfileScreen(
                                fromMainUser: false,
                                updateUserStatus: (bool isFollow) {
                                  // widget.videosList[
                                  //             currentIndex
                                  //                 .value]
                                  //         [
                                  //         "following"] =
                                  //     isFollow;
                                  // _videoController.update();
                                },
                                profileUsername: _commentController
                                    .commentList[index]["username"]
                                    .toString(),
                              ),
                            )!
                                .then((value) {
                              _videoController.isPlaying.value = true;
                              _videoController.isAutoplay.value = true;
                              //todo managed
                              _videoController
                                  .videoController(
                                      _videoController.currentIndex.value)
                                  ?.pause();
                              // videoPlayerController!.value.play();
                            });
                          } else {
                            _mainHomeScreenController.showAuthBottomSheet(
                              context: context,
                            );
                          }
                          setState(() {});
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _commentController.commentList[index]["username"],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            customHeight(2),
                            Text(
                              _commentController.commentList[index]["body"],
                            ),
                            height5,
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // (_commentController.isLongPress.value == true &&
                        //         _commentController.longPressIndex == index)
                        //     ? Container(
                        //         height: 30,
                        //         width: 100,
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 15, vertical: 5),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(30),
                        //           color: grey.withOpacity(0.3),
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Image.asset(
                        //               AppAsset.heart,
                        //               height: 15,
                        //             ),
                        //             Image.asset(
                        //               AppAsset.heart1,
                        //               height: 15,
                        //             ),
                        //             Image.asset(
                        //               AppAsset.heart2,
                        //               height: 15,
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     :
                        Text(
                          formatTimestamp(_commentController.commentList[index]
                                  ["created_at"])
                              .timeAgo(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12),
                        ),
                        starContainer(index, theme),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  starContainer(index, theme) {
    // bool isGold = false;
    // bool isSilver = false;
    // bool isBronze = false;
    return SizedBox(
      // height: 50,
      child: Row(
        children: [
          //customWidth(2.5),
          InkWell(
            onTap: () {
              //isGold = true;
              _commentController.isLongPress.value = false;
              if (_commentController.commentList[index]["upvoted"] == true) {
                _commentController.commentLikeRemove(
                    id: _commentController.commentList[index]["id"],
                    dataList: _commentController.commentList[index]);
              } else {
                _commentController.commentLike(
                    id: _commentController.commentList[index]["id"],
                    dataList: _commentController.commentList[index]);
              }
              _commentController.update();
            },
            // onLongPress: () {
            //   _commentController.isLongPress.value = true;
            //   _commentController.longPressIndex = index;
            //   _commentController.update();
            // },
            child: Container(
              height: 40,
              width: 30,
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: _commentController.commentList[index]["upvoted"] == true
              //         ? theme
              //             ? fillGrey
              //             : simpleGrey
              //         : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    _commentController.commentList[index]["upvoted"] == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color:
                        _commentController.commentList[index]["upvoted"] == true
                            ? Colors.red
                            : secondaryGrey,
                    size: 18,
                  ),
                  Text(
                    _commentController.commentList[index]["upvote_count"]
                        .toString(),
                  )
                ],
              ),
            ),
          ),
          // customWidth(2.5),
          // InkWell(
          //     onTap: () {
          //       // isSilver = true;
          //     },
          //     child: Container(
          //       height: 40,
          //       width: 30,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           // ignore: dead_code
          //           color: isSilver ? simpleGrey : null),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Image.asset(
          //             AppAsset.heart1,
          //             height: 15,
          //           ),
          //           const Text(
          //             "0",
          //             // style: AppTextStyle.normalRegular10,
          //           )
          //         ],
          //       ),
          //     )),
          // customWidth(2.5),
          // InkWell(
          //   onTap: () {
          //     // isBronze = true;
          //   },
          //   child: Container(
          //     height: 40,
          //     width: 30,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         // ignore: dead_code
          //         color: isBronze ? simpleGrey : null),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           AppAsset.heart2,
          //           height: 15,
          //         ),
          //         const Text(
          //           "0",
          //           // style: AppTextStyle.normalRegular10,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          //customWidth(2.5),
        ],
      ),
    );
  }

  Widget bottomTextField(theme, context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: Platform.isIOS // isIOS
            ? isKeyboardShowing
                ? Get.height * 0.08
                : Get.height * 0.1
            : Get.height * 0.08,
        width: Get.width,
        decoration: BoxDecoration(
          color: theme ? fillGrey : primaryWhite,
          boxShadow: [
            BoxShadow(
              color: primaryBlack.withOpacity(0.1),
              blurRadius: 10.0,
              spreadRadius: 0.5,
            )
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
          child: TextFormField(
            controller: _commentController.commentController,
            style: Theme.of(context).textTheme.bodySmall,
            focusNode: _focusNode,
            decoration: InputDecoration(
              fillColor: whiteColor,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              //   child: GestureDetector(
              //     onTap: () => FocusScope.of(context).requestFocus(_focusNode),
              //     child: SvgPicture.asset(
              //       AppAsset.icemjois,
              //     ),
              //   ),
              // ),
              hintText: "Add comment...",
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: IconButton(
                onPressed: _commentController.commentController.text.isEmpty
                    ? () {
                        _commentController.isFromCommentWidget = true;
                        HapticFeedback.mediumImpact();
                        _commentController.floatingScaffold(
                          context,
                          message: 'Enter a comment',
                          height:
                              _commentController.isFromCommentWidget == false
                                  ? Platform.isIOS
                                      ? Get.height * 0.14
                                      : Get.height * 0.12
                                  : Platform.isIOS
                                      ? Get.height * 0.83
                                      : Get.height * 0.85,
                        );
                      }
                    : () {
                        _commentController.addComment(
                          postID: widget.postID,
                          data: _commentController.commentController.text
                              .toString(),
                          context: context,
                          dataList: widget.dataList,
                        );
                        // _focusNode.unfocus();
                        _commentController.commentController.clear();
                        _commentController.isFromCommentWidget = true;
                      },
                icon: SvgPicture.asset(
                  AppAsset.icsend,
                  height: 20,
                  color: Theme.of(context).errorColor,
                ),
              ),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
