import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';

class PostController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final NetworkRepository networkRepository = NetworkRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<PopupMenuButtonState<int>> globalKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  VideoPlayerController? videoPlayerController;
  static Circle processIndicator = Circle();
  String? selectedSphere;
  bool comments = false;
  bool isPublic = false;
  bool istap = false;
  int page = 1;
  List categoriesList = [];
  RxList categorySearchList = [].obs;
  bool isSearching = false;

  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      getCategories(Get.overlayContext);
      // getFilterProperty(context, propertyTypeFilter);
    } else {}
  }

  onSearchChange(BuildContext context, String value) async {
    await getCategoriesSearch(context);
  }

  postVideo(context) async {
    var response = await networkRepository.postVideo(
      apiEndPoint: '${AppConstants.apiEndPoint}${AppConstants.posts}',
      title: titleController.text,
      hash: dataStorage.read("hash"),
      category: '123',
      isPrivate: isPublic.toString(),
    );

    response.listen(
      (value) {
        dynamic response = jsonDecode(value);
        log(response.toString());
        if (response != null) {
          log(response.toString());
          log(response['status'].toString());
          HapticFeedback.mediumImpact();
          floatingScaffold(
            Get.context,
            message: 'Post has been created',
          );
        } else {
          HapticFeedback.mediumImpact();
          floatingScaffold(
            Get.context,
            message: 'Something went wrong, please try again later',
          );
        }
      },
    );
  }

  getCategoriesSearch(BuildContext context) async {
    categorySearchList.clear();
    String sphere = searchController.text;
    isSearching = true;
    final response = await networkRepository.getSearch(
        context: context, username: sphere, searchfor: "category");
    isSearching = true;
    if (searchController.text.isNotEmpty) {
      categorySearchList.value = response;
      // log(categorySearchList.toString());
      isSearching = false;
    } else {
      isSearching = true;
      categorySearchList.clear();
    }
    update();
  }

  getCategories(context) async {
    // log(page.toString());
    final response = await networkRepository.getCategories(
      context: context,
      page: page,
    );
    if (response != null) {
      categoriesList.addAll(response["categories"]);
      // log(categoriesList.toString());
    } else {
      categoriesList.clear();
    }
    update();
  }

  floatingScaffold(
    context, {
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: Platform.isIOS ? Get.height * 0.14 : Get.height * 0.12,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
