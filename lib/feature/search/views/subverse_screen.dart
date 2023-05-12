import 'dart:io';
import 'package:socialverse/export.dart';
import 'package:socialverse/feature/search/views/browse_subverse.dart';

class SubverseScreen extends StatefulWidget {
  const SubverseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SubverseScreen> createState() => _SubverseScreenState();
}

class _SubverseScreenState extends State<SubverseScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime formatTimestamp(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return date;
    }

    final controller = Get.put(SearchController());
    final _mainHomeScreenController = Get.put(MainHomeScreenController());
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<SearchController>(
        initState: (state) {
          controller.getSubverseInfo(context);
          controller.subverseList.isEmpty
              ? controller.getPostsInSubverse(context)
              : null;
        },
        builder: (controller) {
          return controller.subverseLoading == true
              ? Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      // height: Get.height,
                      // width: Get.width,
                      child: Column(
                        children: [
                          const PlaceholderHeader(),
                          GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              top: 20,
                              bottom: Platform.isIOS
                                  ? Get.height * 0.1
                                  : Get.height * 0.08,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.65,
                            ),
                            children: const [
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                              PlaceholderGridItem(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // widget.categoryphoto.isNotEmpty ?
                                  CircleAvatar(
                                    radius: 40.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        40,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.subverseImageUrl,
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                Image.asset(
                                          AppAsset.load,
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Image.asset(
                                            AppAsset.socialverselogo,
                                          ),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  // : CircleAvatar(
                                  //     radius: 40.0,
                                  //     backgroundImage: const AssetImage(
                                  //       AppAsset.socialverselogo,
                                  //     ),
                                  //     backgroundColor: Colors.grey.shade100,
                                  //   ),
                                  width10,
                                  SizedBox(
                                    width: Get.width * 0.65,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                controller.subverseName,
                                                style: AppTextStyle.normalBold18
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .errorColor),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            width05,
                                            Expanded(
                                              child: SmallImageButton(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                title: 'Upload',
                                                onPressed: () {
                                                  HapticFeedback.mediumImpact();
                                                  if (dataStorage
                                                          .read('isLogging') ==
                                                      true) {
                                                    // editorController.callInit();
                                                    Get.to(
                                                      () => EditorScreen(
                                                        fromHomeScreen: false,
                                                      ),
                                                    );
                                                  } else {
                                                    _mainHomeScreenController
                                                        .showAuthBottomSheet(
                                                      context: context,
                                                    );
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          controller.subverseCount.toString() +
                                              ' Videos',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .errorColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        height5,
                                        Text(
                                          controller.subverseDescription,
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                top: 20,
                                bottom: Platform.isIOS
                                    ? Get.height * 0.1
                                    : Get.height * 0.08,
                              ),
                              // reverse: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio: 0.65,
                              ),
                              itemCount: controller.subverseList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => VideoPlayerWidget(
                                        videoIndex: index,
                                        videosList: controller.subverseList.obs,
                                        fromHomePage: false,
                                        fromCategoryPage: true,
                                        pageController: PageController(
                                          initialPage: index,
                                        ).obs,
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: NetworkImageWidget(
                                          imageUrl: controller
                                              .subverseList[index]
                                                  ["thumbnail_url"]
                                              .toString(),
                                          fit: BoxFit.cover,
                                          width: 500,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        left: 5,
                                        child: Row(
                                          children: [
                                            Text(
                                              formatTimestamp(controller
                                                          .subverseList[index]
                                                      ["created_at"])
                                                  .dayMonth(),
                                              style: AppTextStyle
                                                  .normalRegular14
                                                  .copyWith(
                                                color: whiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   bottom: Platform.isIOS
                      //       ? Get.height * 0.125
                      //       : Get.height * 0.105,
                      //   left: 20,
                      //   right: 20,
                      //   child: ImageButton(
                      //     borderRadius: BorderRadius.circular(30),
                      //     title: 'Browse other Subverses',
                      //     onPressed: () {
                      //       HapticFeedback.mediumImpact();
                      //       dataStorage.read('isLogging') == true
                      //           ? Get.to(
                      //               () => const BrowseSubverse(),
                      //             )
                      //           : _mainHomeScreenController.showAuthBottomSheet(
                      //               context: context,
                      //             );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class PlaceholderGridItem extends StatelessWidget {
  const PlaceholderGridItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAsset.load),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PlaceholderHeader extends StatelessWidget {
  const PlaceholderHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(
              AppAsset.load,
            ),
            backgroundColor: Colors.transparent,
          ),
          width10,
          SizedBox(
            width: Get.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAsset.load),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                height5,
                Container(
                  width: 70,
                  height: 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAsset.load),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                height5,
                Container(
                  width: 160,
                  height: 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAsset.load),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
