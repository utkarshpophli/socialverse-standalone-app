import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';

class SearchController extends GetxController {
  NetworkRepository networkRepository = NetworkRepository();
  TextEditingController searchTextController = TextEditingController();
  // TextEditingController searchAccountController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List userSearchList = [];
  List postByUser = [];
  List subverseList = [];
  List categoriesList = [];
  PageController pageController = PageController(initialPage: 0);
  // List categorySearchList = [];
  RxList categorySearchList = [].obs;
  List postSearchList = [];
  int page = 1; // TODO: Chnage back to 1
  bool isSearching = false;
  int? id;

  String subverseName = '';
  String subverseDescription = '';
  String subverseImageUrl = '';
  int subverseCount = 0;
  bool subverseLoading = false;
  bool searchCategoryLoading = false;

  List postBySphere = [];
  String? postBySphereName;
  String? postBySphereImgUrl;

  List recentAccount = [
    {
      "image":
          "https://i.pinimg.com/236x/85/54/64/8554641de85c3a45eb19bbeb8ac018cf.jpg",
      "name": "JackJay",
      "followers": "200k",
      "category": "game",
    },
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    // scrollController.addListener(_scrollListener);
    pageController.addListener(_pageScrollListener);
  }

  Future<dynamic> _scrollListener([context]) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      getCategories(Get.overlayContext);
      // getFilterProperty(context, propertyTypeFilter);
    } else {}
  }

  Future<dynamic> _pageScrollListener() async {
    if (pageController.offset >= pageController.position.maxScrollExtent &&
        !pageController.position.outOfRange) {
      floatingScaffold(
        Get.overlayContext,
        message: 'There are no more videos in this sphere',
        height: Get.height * 0.105,
        duration: const Duration(seconds: 3),
      );
      log('max extent');
    } else {}
  }

  onSearchChange(BuildContext context, String value) async {
    if (tabController.index == 0 ||
        tabController.index == 1 ||
        tabController.index == 2) {
      await getUserSearch(context: context, isSearching: isSearching);
      await getCategoriesSearch(context);
      await getPostSearch(context);
    }
  }

  getUserSearch({context, required bool isSearching}) async {
    isSearching = true;
    update();
    userSearchList.clear();
    String profileuser = searchTextController.text;
    final response = await networkRepository.getSearch(
        context: context, username: profileuser, searchfor: "user");
    if (response != null && response.toString().contains('first_name')) {
      userSearchList = response;
      isSearching = false;
      log(userSearchList.toString());
    } else {
      isSearching = true;
      update();
      userSearchList.clear();
    }
    update();
  }

  getPostSearch(context) async {
    postSearchList.clear();
    String profileuser = searchTextController.text;

    final response = await networkRepository.getSearch(
        context: context, username: profileuser, searchfor: "post");
    if (response != null) {
      postSearchList = response.reversed.toList();
      postSearchList.removeWhere((element) => element["video_link"] == null);
      log(postSearchList.toString());
    } else {
      postSearchList.clear();
    }
    update();
  }

  getCategoriesSearch(BuildContext context) async {
    categorySearchList.clear();
    String profileuser = searchTextController.text;
    final response = await networkRepository.getSearch(
        context: context, username: profileuser, searchfor: "category");
    if (searchTextController.text.isNotEmpty) {
      categorySearchList.value = response;
      log(categorySearchList.toString());
    } else {
      categorySearchList.clear();
    }
    update();
  }

  getPostByUser(context, id) async {
    log("id==> $id");
    final response =
        await networkRepository.getSpherePosts(context: context, id: id);
    if (response != null && response["posts"].isNotEmpty) {
      postByUser = response["posts"].reversed.toList();
    } else {
      postByUser.clear();
    }
    update();
  }

  getSubverseInfo(context) async {
    final response =
        await networkRepository.getSphereInfo(context: context, id: '123');
    if (response != null /* && response["posts"].isNotEmpty */) {
      subverseName = response["name"];
      subverseCount = response["count"];
      subverseDescription = response["description"];
      subverseImageUrl = response["image_url"];
      subverseLoading = false;
    } else {
      floatingScaffold(context,
          message: "Something went wrong, Please try again later",
          height: Platform.isIOS ? Get.height * 0.125 : Get.height * 0.04);
    }
    update();
  }

  getPostsInSubverse(context) async {
    if (subverseList.isEmpty) {
      subverseLoading = true;
    } else {
      subverseLoading = false;
    }
    final response = await networkRepository.getSpherePosts(
      context: context,
      id: '123',
      page: '1',
    );
    if (response != null /* && response["posts"].isNotEmpty */) {
      subverseList = response["posts"].reversed.toList();
      subverseLoading = false;
    } else {
      floatingScaffold(context,
          message: "Something went wrong, Please try again later",
          height: Platform.isIOS ? Get.height * 0.125 : Get.height * 0.04);
      // subverseList.clear();
    }
    update();
  }

  getCategories(context) async {
    searchCategoryLoading = true;
    log(page.toString());
    // categoriesList.clear();
    final response = await networkRepository.getCategories(
      context: context,
      page: page,
    );
    if (response != null) {
      searchCategoryLoading = false;
      categoriesList.isEmpty
          ? categoriesList.addAll(response["categories"])
          : null;
    } else {
      searchCategoryLoading = false;
      categoriesList.clear();
      floatingScaffold(
        context,
        message: 'Something went wrong',
        height: Platform.isIOS ? Get.height * 0.08 : Get.height * 0.12,
      );
    }
    update();
  }

  spheresOnTap({
    required BuildContext context,
    required index,
    required bool isGetCategories,
  }) async {
    await getPostByUser(
        context,
        isGetCategories == false
            ? categoriesList[index]["id"].toString()
            : categorySearchList[index]["id"].toString());
    if (postByUser.isEmpty) {
      Get.to(
        () => CategoryScreen(
          categoryname: isGetCategories == false
              ? categoriesList[index]["name"]
              : categorySearchList[index]["name"],
          categorydesc: isGetCategories == false
              ? categoriesList[index]["description"]
              : categorySearchList[index]["description"],
          categorycount: isGetCategories == false
              ? categoriesList[index]["count"]
              : categorySearchList[index]["count"],
          fromVideoPlayer: false,
          categoryid: isGetCategories == false
              ? categoriesList[index]["id"]
              : categorySearchList[index]["id"],
          categoryphoto: isGetCategories == false
              ? categoriesList[index]["image_url"]
              : categorySearchList[index]["image_url"],
        ),
      );
      // log("no video");
    } else {
      Get.to(
        () => VideoPlayerWidget(
          videoIndex: 0,
          videosList: postByUser.obs,
          pageController: pageController.obs,
          fromHomePage: false,
          fromSearchPage: true,
          // sphereName: categoriesList[index]["name"],
        ),
      );
      //   CategoryScreen(
      //     categoryname: isGetCategroies == false
      //         ? categoriesList[index]["name"]
      //         : categorySearchList[index]["name"],
      //     categorycount: categoriesList[index]["count"],
      //     fromVideoPlayer: false,
      //     categoryid: isGetCategroies == false
      //         ? categoriesList[index]["id"]
      //         : categorySearchList[index]["id"],
      //     categoryphoto: categoriesList[index]["image_url"],
      //   ),
      // );
    }
  }

  uncategorizedOnTap({
    required BuildContext context,
    required index,
    required bool isGetCategories,
  }) async {
    await getPostByUser(
        context,
        isGetCategories == false
            ? categoriesList[index]["id"].toString()
            : categorySearchList[index]["id"].toString());
    if (postByUser.isEmpty) {
      Get.to(() => CategoryScreen(
            categoryname: categoriesList[index]["name"],
            categorydesc: '',
            categorycount: categoriesList[index]["count"],
            fromVideoPlayer: false,
            categoryid: categoriesList[index]["id"],
            categoryphoto: categoriesList[index]["image_url"],
          ));
      // log("no video");
    } else {
      Get.to(
        () => VideoPlayerWidget(
          videoIndex: 0,
          videosList: postByUser.obs,
          pageController: pageController.obs,
          fromHomePage: false,
        ),
      );
    }
  }

  floatingScaffold(
    context, {
    required String message,
    required double height,
    dynamic duration,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: duration ?? Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
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
