import 'dart:io';
import 'package:socialverse/export.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryname;
  final String categorydesc;
  final int categorycount;
  final int categoryid;
  final bool fromVideoPlayer;
  final String categoryphoto;

  const CategoryScreen({
    Key? key,
    required this.categoryname,
    required this.categorydesc,
    required this.categorycount,
    required this.fromVideoPlayer,
    required this.categoryid,
    required this.categoryphoto,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final SearchController controller = Get.put(SearchController());
    final MainHomeScreenController _mainHomeScreenController = Get.put(
      MainHomeScreenController(),
    );
    // final CategoryController categoryController = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 16,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      body: GetBuilder<SearchController>(
        initState: (state) {
          controller.getPostByUser(context, widget.categoryid);
        },
        builder: (controller) {
          return widget.fromVideoPlayer == true ||
                  controller.postByUser.isNotEmpty
              ? SizedBox(
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
                                  top: 20, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.categoryphoto.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 40.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: widget.categoryphoto,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Image.asset(
                                                AppAsset.load,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Image.asset(
                                                  AppAsset.socialverselogo,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // NetworkImage(
                                          //   widget.searchController
                                          //           .categoriesList[
                                          //       index]["image_url"],
                                          // ),
                                          backgroundColor: Colors.transparent,
                                        )
                                      // CircleAvatar(
                                      //     radius: 40.0,
                                      //     backgroundImage: NetworkImage(
                                      //       widget.categoryphoto,
                                      //     ),
                                      //     backgroundColor: Colors.grey.shade100,
                                      //   )
                                      : CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage: const AssetImage(
                                            AppAsset.socialverselogo,
                                          ),
                                          backgroundColor: Colors.grey.shade100,
                                        ),
                                  width10,
                                  SizedBox(
                                    width: Get.width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.categoryname,
                                          style: AppTextStyle.normalBold18
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .errorColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          widget.categorycount.toString() +
                                              ' Videos',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .errorColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        if (widget.categoryname != '' &&
                                            widget.categoryname.isNotEmpty)
                                          Text(
                                            widget.categorydesc,
                                            style: AppTextStyle.normalRegular16
                                                .copyWith(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                          )
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
                                bottom: Platform.isIOS ? Get.height * 0.08 : 0,
                              ),
                              // reverse: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio: 0.65,
                              ),
                              itemCount: controller.postByUser.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => VideoPlayerWidget(
                                        videoIndex: index,
                                        videosList: controller.postByUser.obs,
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
                                          imageUrl: controller.postByUser[index]
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
                                          children: const [
                                            Icon(
                                              Icons.play_arrow,
                                              color: primaryWhite,
                                              size: 12,
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
                      Positioned(
                        bottom: Platform.isIOS
                            ? Get.height * 0.06
                            : Get.height * 0.04,
                        left: 20,
                        right: 20,
                        child: ImageButton(
                          borderRadius: BorderRadius.circular(30),
                          title:
                              'Upload to ${widget.categoryname.isEmpty ? 'Sphere' : widget.categoryname}',
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            dataStorage.read('isLogging') == true
                                ? Get.to(
                                    () => EditorScreen(
                                      fromHomeScreen: false,
                                    ),
                                  )
                                : _mainHomeScreenController.showAuthBottomSheet(
                                    context: context,
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    widget.categoryphoto.isNotEmpty
                                        ? CircleAvatar(
                                            radius: 50.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: widget.categoryphoto,
                                                progressIndicatorBuilder:
                                                    (context, url, progress) =>
                                                        Image.asset(
                                                  AppAsset.load,
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Image.asset(
                                                    AppAsset.socialverselogo,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // NetworkImage(
                                            //   widget.searchController
                                            //           .categoriesList[
                                            //       index]["image_url"],
                                            // ),
                                            backgroundColor: Colors.transparent,
                                          )
                                        // CircleAvatar(
                                        //     radius: 40.0,
                                        //     backgroundImage: NetworkImage(
                                        //       widget.categoryphoto,
                                        //     ),
                                        //     backgroundColor: secondaryGrey,
                                        //   )
                                        : SvgPicture.asset(
                                            AppAsset.sphereLogo,
                                            color: Theme.of(context).errorColor,
                                            height: 80,
                                            width: 80,
                                          ),
                                    width10,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.categoryname,
                                            style: AppTextStyle.normalBold18
                                                .copyWith(
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                          ),
                                          Text(
                                            widget.categorycount.toString() +
                                                ' Videos',
                                            style: AppTextStyle.normalRegular16
                                                .copyWith(
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                          ),
                                          if (widget.categoryname != '' &&
                                              widget.categoryname.isNotEmpty)
                                            Text(
                                              widget.categorydesc,
                                              style: AppTextStyle
                                                  .normalRegular16
                                                  .copyWith(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                            )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                customHeight(Get.height * 0.25),
                                Text(
                                  "This sphere has no videos yet! Click the Upload to ${widget.categoryname.isEmpty ? 'Sphere' : widget.categoryname} button below to upload one now.",
                                  textAlign: TextAlign.center,
                                  style:
                                      themeData.textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: Platform.isIOS
                              ? Get.height * 0.06
                              : Get.height * 0.04,
                          left: 20,
                          right: 20,
                        ),
                        child: ImageButton(
                          borderRadius: BorderRadius.circular(30),
                          title:
                              'Upload to ${widget.categoryname.isEmpty ? 'Sphere' : widget.categoryname}',
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            HapticFeedback.mediumImpact();
                            dataStorage.read('isLogging') == true
                                ? Get.to(
                                    () => EditorScreen(
                                      fromHomeScreen: false,
                                    ),
                                  )
                                : _mainHomeScreenController.showAuthBottomSheet(
                                    context: context,
                                  );
                          },
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
