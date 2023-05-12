// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:socialverse/export.dart';

class CommentController extends GetxController {
  NetworkRepository networkRepository = NetworkRepository();
  TextEditingController commentController = TextEditingController();
  final CommonVideoPlayerController _videoController = Get.put(
    CommonVideoPlayerController(),
  );

  RxBool isLongPress = false.obs;
  int longPressIndex = 0;
  String commentId = "";
  List commentList = [];
  bool isFromCommentWidget = false;
  bool isLoading = false;

  getComment({postID, context}) async {
    commentList.clear();
    isLoading = true;
    final response = await networkRepository.getComment(
      context: context,
      postID: postID,
    );
    if (response != null) {
      commentList.addAll(response["body"]);
      isLoading = false;
    }
    update();
  }

  deleteComment({context, postID, dataList}) async {
    var response = await networkRepository.deleteComment(
      context: context,
      id: commentId,
    );
    if (response != null && response['status'] == 'success') {
      dataList['comment_count']--;
      await getComment(postID: postID);
      update();
      _videoController.update();
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(
        context,
        message: response['messaged'],
        height: Platform.isIOS ? Get.height * 0.8 : Get.height * 0.85,
      );
    }
    update();
  }

  addComment({postID, data, context, dataList}) async {
    var response = await networkRepository.postComment(
      context: context,
      postID: postID,
      data: data,
    );

    if (response != null && response['body']['status'] == 'success') {
      dataList['comment_count']++;
      await getComment(postID: postID);
      update();
      _videoController.update();
      HapticFeedback.mediumImpact();
      floatingScaffold(
        context,
        message: 'Comment has been added',
        height: isFromCommentWidget == false
            ? Get.height * 0.105
            : Platform.isIOS
                ? Get.height * 0.8
                : Get.height * 0.85,
      );
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(
        context,
        message: 'Error adding comment, Please try again',
        height: isFromCommentWidget == false
            ? Platform.isIOS
                ? Get.height * 0.125
                : Get.height * 0.12
            : Platform.isIOS
                ? Get.height * 0.8
                : Get.height * 0.85,
      );
    }
    commentController.clear();
    update();
  }

  commentLike({required id, dataList}) async {
    dataList["upvote_count"]++;
    dataList["upvoted"] = !dataList['upvoted'];
    final response = await networkRepository.commentLike(id: id);
    if (response != null) {
      update();
    }

    update();
  }

  commentLikeRemove({required id, identifier, slug, dataList}) async {
    dataList["upvote_count"]--;
    dataList["upvoted"] = !dataList['upvoted'];
    final response = await networkRepository.commentLikeRemove(id: id);
    if (response != null) {
      update();
    }

    update();
  }

  floatingScaffold(
    context, {
    required String message,
    required double height,
    Color? color,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(milliseconds: 1500),
        backgroundColor: color ?? Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: height,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
