import 'dart:developer';
import 'package:socialverse/export.dart';

enum SelectSphereStatus { initial, searching, searched }

class SelectSphere extends StatefulWidget {
  SelectSphere({Key? key}) : super(key: key);

  @override
  State<SelectSphere> createState() => _SelectSphereState();
}

class _SelectSphereState extends State<SelectSphere> {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    bool theme = dataStorage.read("isDarkMode");
    return GetBuilder<PostController>(
      initState: (state) {
        postController.getCategories(context);
      },
      builder: (controller) {
        SelectSphereStatus selectSphereStatus =
            postController.searchController.text.isEmpty
                ? SelectSphereStatus.initial
                : postController.isSearching == true
                    ? SelectSphereStatus.searching
                    : SelectSphereStatus.searched;
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              leading: SizedBox(),
              elevation: 0,
              leadingWidth: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      postController.searchController.clear();
                      postController.categorySearchList.clear();
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: theme ? fillGrey : grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 16,
                        color: primaryWhite,
                      ),
                    ),
                  ),
                  width05,
                  Expanded(
                    child: SearchBar(
                      autofocus: true,
                      controller: controller.searchController,
                      hintText: 'Search Sphere',
                      darkTheme: theme,
                      onChanged: (String? value) =>
                          controller.onSearchChange(context, value!),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
          ),
          body: Builder(
            builder: (_) {
              switch (selectSphereStatus) {
                case SelectSphereStatus.searching:
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                      SelectSphereLoadingWidget(),
                    ],
                  );
                case SelectSphereStatus.searched:
                  return ListView.builder(
                    itemCount: postController.categorySearchList.length,
                    scrollDirection: Axis.vertical,
                    controller: postController.scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return postController.categorySearchList[index]["name"] !=
                              ''
                          ? Container(
                              height: 50,
                              width: Get.width,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(30),
                                color: Colors.transparent,
                              ),
                              child: InkWell(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  postController.categoryController.text =
                                      postController.categorySearchList[index]
                                          ["name"];
                                  postController.selectedSphere = postController
                                      .categorySearchList[index]["id"]
                                      .toString();
                                  log('category.controller.text: ' +
                                      postController.categoryController.text +
                                      ', ' +
                                      'selected sphere: ' +
                                      postController.selectedSphere!);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    postController.categorySearchList[index]
                                                    ["image_url"] !=
                                                null &&
                                            postController.categorySearchList[
                                                    index]["image_url"] !=
                                                ""
                                        ? CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage: NetworkImage(
                                              postController
                                                      .categorySearchList[index]
                                                  ["image_url"],
                                            ),
                                            backgroundColor: secondaryGrey,
                                          )
                                        : SvgPicture.asset(
                                            AppAsset.sphereLogo,
                                            color: Theme.of(context).errorColor,
                                            height: 80,
                                            width: 80,
                                          ),
                                    width05,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (postController
                                                    .categorySearchList[index]
                                                ["name"] !=
                                            null)
                                          Text(
                                            postController
                                                    .categorySearchList[index]
                                                ["name"],
                                            style: AppTextStyle.normalBold16
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .errorColor),
                                            textAlign: TextAlign.center,
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  );
                default:
                  return postController.categoriesList.isNotEmpty
                      ? ListView.builder(
                          itemCount: postController.categoriesList.length,
                          scrollDirection: Axis.vertical,
                          controller: postController.scrollController,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return postController.categoriesList[index]
                                        ["name"] !=
                                    ''
                                ? Container(
                                    height: 50,
                                    width: Get.width,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        HapticFeedback.mediumImpact();
                                        postController.categoryController.text =
                                            postController.categoriesList[index]
                                                ["name"];
                                        postController.selectedSphere =
                                            postController.categoriesList[index]
                                                    ["id"]
                                                .toString();
                                        Navigator.pop(context);
                                        log(
                                          'category.controller.text: ' +
                                              postController
                                                  .categoryController.text +
                                              ', ' +
                                              'selected sphere: ' +
                                              postController.selectedSphere!,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          postController.categoriesList[index]
                                                          ["image_url"] !=
                                                      null &&
                                                  postController.categoriesList[
                                                          index]["image_url"] !=
                                                      ""
                                              ? CircleAvatar(
                                                  radius: 40.0,
                                                  backgroundImage: NetworkImage(
                                                    postController
                                                            .categoriesList[
                                                        index]["image_url"],
                                                  ),
                                                  backgroundColor:
                                                      secondaryGrey,
                                                )
                                              : SvgPicture.asset(
                                                  AppAsset.sphereLogo,
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  height: 80,
                                                  width: 80,
                                                ),
                                          width05,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (postController
                                                          .categoriesList[index]
                                                      ["name"] !=
                                                  null)
                                                Text(
                                                  postController
                                                          .categoriesList[index]
                                                      ["name"],
                                                  style: AppTextStyle
                                                      .normalBold16
                                                      .copyWith(
                                                    color: Theme.of(context)
                                                        .errorColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        )
                      : ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                            SelectSphereLoadingWidget(),
                          ],
                        );
              }
            },
          ),
        );
      },
    );
  }
}

class SelectSphereLoadingWidget extends StatelessWidget {
  const SelectSphereLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(
                AppAsset.load,
              ),
              backgroundColor: Colors.transparent,
            ),
            width10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAsset.load),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
