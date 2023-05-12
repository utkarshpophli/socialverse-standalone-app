// ignore_for_file: constant_identifier_names

enum Environment { DEV, STAGING, PROD }

class AppConstants {
  // Network Constants

  static String apiEndPoint = 'https://api.socialverseapp.com/';
  static String apiStageEndPoint = 'https://api-stage.socialverseapp.com/';

  static String signup = 'user/create';
  static String login = 'user/login';
  static String uploadtoken = 'posts/generate-upload-url';
  static String feedpost = 'feed';
  static String bookmark = 'bookmarks';
  static String userprofile = "profile";
  static String comments = "comments";
  static String update_profile = "profile/update";
  static String follow = "profile/follow";
  static String following = "profile/following";
  static String followers = "profile/followers";
  static String unfollow = "profile/unfollow";
  static String logout = "user/logout";
  static String search = "search";
  static String categories = "categories";
  static String posts = "posts";
  static String create_sphere = "categories/add";
  static String reset_initiate = "auth/credentials/reset/start";
}
