import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:http/http.dart' as http;

class NetworkRepository {
  static final NetworkRepository _networkRepository =
      NetworkRepository._internal();
  // static final dataStorage = GetStorage();
  // String? token = dataStorage.read("token");

  factory NetworkRepository() {
    return _networkRepository;
  }
  NetworkRepository._internal();
  static Circle processIndicator = Circle();

  signUp(BuildContext context, Map data) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.signup}',
        data: data,
        context: context,
      );

      return checkResponse(response, context: context);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  login(data, context) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.login}',
        data: data,
        context: context,
      );

      return checkResponse(response, context: context);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  oauth(data, context) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: 'https://api-stage.socialverseapp.com/auth/firebase',
        data: data,
        context: context,
      );
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  resetInitiate(data, context) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.reset_initiate}',
        data: data,
      );
      return checkResponse(response, context: context);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  getUploadToken(context) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.uploadtoken}',
        header: Options(
            headers: {'Flic-Token': dataStorage.read("token").toString()}),
        context: context,
        loader: false,
      );
      // log(response.toString());
      return checkResponse(response, context: context);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<dynamic> postVideo({
    String? apiEndPoint,
    String? title,
    String? hash,
    String? isPrivate,
    String? category,
  }) async {
    var uri = Uri.parse(apiEndPoint!);
    log(uri.toString());
    var request = http.MultipartRequest("POST", uri);
    request.fields.addAll({
      "title": title!,
      "hash": hash!,
      "is_available_in_public_feed": isPrivate!,
      "category_id": category!,
    });

    log(title);
    log(hash);
    log(isPrivate);
    log(category);

    request.headers.addAll({'Flic-Token': dataStorage.read('token')});
    var response = await request.send();
    log(response.toString());
    return response.stream.transform(utf8.decoder);
  }

  sendReport({
    String? identifier,
    String? slug,
  }) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url:
            '${AppConstants.apiEndPoint}${AppConstants.posts}/$identifier/$slug/report',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
          // "Flic-Token":
          //       'flic_3bad5fe96b35e94e3a5e3ecd50305954424d1c9fd88641c887d54ec07c2eb120'
        ),
      );
      log(response.toString());
      return response;
      // ignore: empty_catches
    } catch (e) {
      //log(e.toString());
    }
  }

  postBookmark({
    String? identifier,
    String? slug,
  }) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url:
            '${AppConstants.apiEndPoint}${AppConstants.posts}/$identifier/$slug/bookmarks/add',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      log(response.toString());
      return response;
      // ignore: empty_catches
    } catch (e) {
      //log(e.toString());
    }
  }

  postBookmarkRemove({
    String? identifier,
    String? slug,
  }) async {
    try {
      Map response = await NetworkDioHttp.deleteDioHttpMethod(
        url:
            '${AppConstants.apiEndPoint}${AppConstants.posts}/$identifier/$slug/bookmarks/remove',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getBookmarkedVideo({context, username}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.bookmark}',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
        loader: false,
      );

      List videoList = [];
      for (var i = 0; i < response["body"].length; i++) {
        videoList.add(response["body"][i]);
      }

      return videoList;
    } catch (e) {
      log(e.toString());
    }
  }

  getSearch({BuildContext? context, username, searchfor}) async {
    try {
      // String? token = dataStorage.read("token");
      // log("Token .. " + token);
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            '${AppConstants.apiEndPoint}${AppConstants.search}?query=$username&type=$searchfor',
        // header:Options(
        //   headers: {"Flic-Token": token},
        // ),
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  deletePost({BuildContext? context, String? slug, String? identifier}) async {
    try {
      Map response = await NetworkDioHttp.deleteDioHttpMethod(
        context: context,
        url:
            '${AppConstants.apiEndPoint}${AppConstants.posts}/${identifier}/${slug}/delete',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      print(response.toString());
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getSphereInfo({BuildContext? context, id}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.categories}/$id',
        header: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: true,
          options: Options(
            headers: {"Flic-Token": dataStorage.read("token").toString()},
          ),
        ),
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getSpherePosts({context, id, page}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            '${AppConstants.apiEndPoint}${AppConstants.categories}/$id/posts?page=$page',
        header: buildCacheOptions(
          Duration(hours: 1),
          // forceRefresh: true,
          options: Options(
            headers: {"Flic-Token": dataStorage.read("token").toString()},
          ),
        ),
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getCategories({context, required int page}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.categories}?page=$page',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  fetchSubverses({http.Client? client}) async {
    try {
      dynamic response = await client?.get(Uri.parse(
          '${AppConstants.apiEndPoint}${AppConstants.categories}?page=1'));
      if (response.statusCode == 200) {
        return response['body'];
      } else {
        throw Exception('Failed to load subverses');
      }
    } catch (e) {
      throw Exception('Failed to load subverses');
    }
  }

  getUserVideo({context, username, page}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiStageEndPoint}users/$username/posts?page=$page',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getUserLikeVideo({context, username}) async {
    try {
      // String? token = dataStorage.read("token");
      //  String username = await dataStorage.read("username");
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.posts}/liked',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
        loader: false,
      );

      List videoList = [];
      for (var i = 0; i < response["body"].length; i++) {
        videoList.add(response["body"][i]);
      }
      return videoList; // checkResponseWith200(response, context);
    } catch (e) {
      log(e.toString());
    }
  }

  getFeedpost({context, required int index}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.feedpost}?page=$index',
        header: dataStorage.read("token").toString() == 'null'
            ? null
            : Options(
                headers: {"Flic-Token": dataStorage.read("token").toString()},
              ),
      );

      return checkResponse(response, context: context);
      // ignore: empty_catches
    } catch (e) {
      log(e.toString());
    }
  }

  postLike({String? postID}) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.posts}/$postID/upvote',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return response;
    } catch (e) {
      // log(e.toString());
    }
  }

  postLikeRemove({String? postID}) async {
    try {
      Map response = await NetworkDioHttp.deleteDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.posts}/$postID/upvote',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return response;
    } catch (e) {
      // log(e.toString());
    }
  }

  commentLike({int? id}) async {
    try {
      // String token = await dataStorage.read("token");
      //  String username = await dataStorage.read("username");
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.comments}/$id/upvote',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      //log(response.toString());
      return response;
      // ignore: empty_catches
    } catch (e) {
      //log(e.toString());
    }
  }

  commentLikeRemove({int? id}) async {
    try {
      // String token = await dataStorage.read("token");

      //  String username = await dataStorage.read("username");
      Map response = await NetworkDioHttp.deleteDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.comments}/$id/upvote',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getComment({context, String? postID}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        // url:
        //     '${AppConstants.apiEndPoint}${AppConstants.getUserVideo}/$identifier/$slug/comments',
        url:
            '${AppConstants.apiEndPoint}${AppConstants.posts}/$postID/comments',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
        loader: false,
      );

      return response;
    } catch (e) {}
  }

  postComment({context, String? postID, String? data}) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        data: {"body": data},
        url:
            '${AppConstants.apiEndPoint}${AppConstants.posts}/$postID/comments',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );

      return response;
    } catch (e) {}
  }

  deleteComment({BuildContext? context, String? id}) async {
    try {
      // String? token = dataStorage.read("token");
      // log("Token .. " + token);
      Map response = await NetworkDioHttp.deleteDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.comments}/${id}/delete',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getProfileData({context, String? username}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            '${AppConstants.apiStageEndPoint}${AppConstants.userprofile}/$username',
        loader: false,
        header: buildCacheOptions(
          Duration(days: 7),
          forceRefresh: true,
          options: dataStorage.read("token").toString() == 'null'
              ? null
              : Options(
                  headers: {"Flic-Token": dataStorage.read("token").toString()},
                ),
        ),
      );
      return checkResponseWith200(response, context: context);
    } catch (e) {}
  }

  logout({context}) async {
    try {
      // String token = await dataStorage.read("token");
      Map response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.logout}',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      // log(response.toString());
      return checkResponseWith200(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  userFollow({context, String? username}) async {
    try {
      // String token = await dataStorage.read("token");
      //  String username = await dataStorage.read("username");
      Map response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.follow}/$username',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      // log(response.toString());
      return checkResponseWith200(response, context: context);
      // ignore: empty_catches
    } catch (e) {
      log(e.toString());
    }
  }

  userUnfollow({context, String? username}) async {
    try {
      // String token = await dataStorage.read("token");
      //  String username = await dataStorage.read("username");
      Map response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.unfollow}/$username',
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      // log(response.toString());
      return checkResponseWith200(response, context: context);
      // ignore: empty_catches
    } catch (e) {
      log(e.toString());
    }
  }

  getFollowing({context, username}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
          context: context,
          url: '${AppConstants.apiEndPoint}${AppConstants.following}/$username',
          loader:
              true // TODO: Move laoding indicator into the widget not as an overlay
          );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getFollowers({context, username}) async {
    try {
      Map response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.followers}/$username',
        loader: true,
      );
      return checkResponse(response, context: context);
    } catch (e) {
      log(e.toString());
    }
  }

  getProfileUpdate(context, data) async {
    final response = await NetworkDioHttp.putDioHttpMethod(
      context: context,
      url: '${AppConstants.apiStageEndPoint}${AppConstants.update_profile}',
      data: data,
      header: Options(
        headers: {
          'Flic-Token': dataStorage.read("token").toString(),
        },
      ),
    );

    return checkResponse(response, context: context);
  }

  Future uploadCategoryImage({id, data, context}) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url:
            '${AppConstants.apiEndPoint}${AppConstants.categories}/$id/upload/image',
        data: data,
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  updateCategoryDescription({String? id, data, String? text}) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.categories}/$id/update',
        data: data,
        header: Options(
          headers: {"Flic-Token": dataStorage.read("token").toString()},
        ),
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  createSphere(context, data) async {
    try {
      Map response = await NetworkDioHttp.postDioHttpMethod(
        url: '${AppConstants.apiEndPoint}${AppConstants.create_sphere}',
        data: data,
        header: Options(
          headers: {
            "Flic-Token": dataStorage.read("token").toString(),
          },
        ),
        context: context,
      );
      return checkResponse(response, context: context);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> checkResponse(response, {context}) async {
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body'] != null) {
        return response['body'];
      } else {
        HapticFeedback.mediumImpact();
        floatingScaffold(context, message: response['body']['message']);
        return response['body'];
      }
    } else {
      HapticFeedback.mediumImpact();
      floatingScaffold(
        context,
        message: response['error_description'] ?? 'Something went wrong',
        duration: const Duration(seconds: 3),
      );
    }
  }

  checkResponseWith200(dynamic response, {BuildContext? context}) {
    if (response["error_description"] == null) {
      if (response['body']['code'] == 200 ||
          response['body']['code'] == "200") {
        return response['body'];
      } else if (response['body']['code'] == 500 ||
          response['body']['code'] == "500") {
        // showErrorDialog(response['body']['message'], context);
        return response['body'];
      } else {
        // showErrorDialog(response['body']['message'], context);
        return response['body'];
      }
    }
  }

  checkResponseWith500(var response, BuildContext context) {
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body']['code'] == 200 ||
          response['body']['code'] == "200") {
        return response['body'];
      } else if (response['body']['code'] == 500 ||
          response['body']['code'] == "500") {
        HapticFeedback.mediumImpact();
        showErrorDialog(response['body']['message'], context);
      } else {
        HapticFeedback.mediumImpact();
        showErrorDialog(response['body']['message'], context);
      }
    } else {
      showErrorDialog(response['body']['message'], context);
    }
  }

  void showErrorDialog(String message, BuildContext context) {
    HapticFeedback.mediumImpact();
    floatingScaffold(
      context,
      message: message.toString(),
      duration: const Duration(seconds: 3),
    );
  }

  floatingScaffold(context, {required String message, duration}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
          bottom: Platform.isIOS ? Get.height * 0.085 : Get.height * 0.125,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
