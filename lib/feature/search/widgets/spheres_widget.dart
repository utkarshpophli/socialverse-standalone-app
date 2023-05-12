import 'dart:developer';
import 'dart:io';
import '../../../export.dart';

class Spheres extends StatefulWidget {
  final SearchController searchController;
  const Spheres({Key? key, required this.searchController}) : super(key: key);

  @override
  State<Spheres> createState() => _SpheresState();
}

class _SpheresState extends State<Spheres> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      initState: (state) {
        widget.searchController.getCategories(context);
        // widget.searchController.getPostByUser(context, index);
      },
      builder: (controller) {
        bool isGridView = dataStorage.read('isGridView') == true ? true : false;
        final list = widget.searchController.categoriesList
            .where((category) => category['name'] != ''
                // && category['name'] != '',
                )
            .toList();
        return widget.searchController.categoriesList.isNotEmpty
            ? isGridView == true
                ? SingleChildScrollView(
                    controller: widget.searchController.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (dataStorage.read('isGridView') == true) {
                              dataStorage.write('isGridView', false);
                              setState(() {
                                isGridView = false;
                              });
                            } else {
                              dataStorage.write('isGridView', true);
                              setState(() {
                                isGridView = true;
                              });
                            }
                            log(isGridView.toString());
                            log(dataStorage.read('isGridView').toString());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            // child: Icon(Icons.list),
                            child: isGridView == true
                                ? const Icon(Icons.grid_view)
                                : const Icon(Icons.list),
                          ),
                        ),
                        height10,
                        GridView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 5,
                            right: 5,
                            bottom: Get.height * 0.12,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 3.3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onLongPress: () {
                                    HapticFeedback.mediumImpact();
                                    showModalBottomSheet(
                                      backgroundColor: primaryBlack,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return SphereMoreBottomSheet(
                                          onEditTap: () {
                                            Get.back();
                                            if (widget.searchController
                                                        .categoriesList[index]
                                                    ["name"] ==
                                                "Uncategorized") {
                                              HapticFeedback.mediumImpact();
                                              widget.searchController
                                                  .floatingScaffold(context,
                                                      message:
                                                          'You can\'t edit this sphere',
                                                      height: Platform.isIOS
                                                          ? Get.height * 0.08
                                                          : Get.height * 0.12);
                                            } else
                                            // if (
                                            //    // TODO: Check if sphere was created by the user or edit by everyone is true (Inform backend)
                                            //   searchController.categoriesList[index]
                                            //         ["creator"] !=
                                            //     "username" || searchController.categoriesList[index]
                                            //         ["allow_edit"] ==
                                            //     "true"
                                            // )
                                            {
                                              Get.to(
                                                () => EditSphereScreen(
                                                  id: widget
                                                      .searchController
                                                      .categoriesList[index]
                                                          ['id']
                                                      .toString(),
                                                  name: widget.searchController
                                                          .categoriesList[index]
                                                      ['name'],
                                                  imageUrl: widget
                                                          .searchController
                                                          .categoriesList[index]
                                                      ['image_url'],
                                                  description: widget
                                                          .searchController
                                                          .categoriesList[index]
                                                      ['description'],
                                                ),
                                              )?.then(
                                                (value) => {
                                                  widget.searchController
                                                      .categoriesList
                                                      .clear(),
                                                  widget.searchController.page =
                                                      1,
                                                  widget.searchController
                                                      .getCategories(context),
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onTap: () {
                                    if (list[index]["name"] ==
                                        "Uncategorized") {
                                      widget.searchController
                                          .uncategorizedOnTap(
                                        context: context,
                                        index: index,
                                        isGetCategories: false,
                                      );
                                      HapticFeedback.mediumImpact();
                                      //
                                    } else {
                                      widget.searchController.spheresOnTap(
                                        context: context,
                                        index: index,
                                        isGetCategories: false,
                                      );
                                      widget.searchController.floatingScaffold(
                                        context,
                                        message:
                                            'Entering ${widget.searchController.categoriesList[index]['name']} Subverse',
                                        height: Platform.isIOS
                                            ? Get.height * 0.08
                                            : Get.height * 0.06,
                                      );
                                      HapticFeedback.mediumImpact();
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            height: Get.height,
                                            width: Get.width,
                                            // colorBlendMode: BlendMode.darken,
                                            // color:
                                            //     Colors.black.withOpacity(0.8),
                                            imageUrl: list[index]["image_url"],
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    Image.asset(
                                              AppAsset.load,
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Image.asset(
                                                AppAsset.socialverselogo,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // const Positioned(
                                      //   top: 20,
                                      //   right: 20,
                                      //   left: 20,
                                      //   bottom: 20,
                                      //   child: Icon(
                                      //     Icons.lock_outline_rounded,
                                      //     size: 35,
                                      //     color: Colors.white,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                height5,
                                SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    list[index]["name"] ?? '',
                                    style:
                                        AppTextStyle.normalRegular14.copyWith(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    controller: widget.searchController.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (dataStorage.read('isGridView') == true) {
                              dataStorage.write('isGridView', false);
                              setState(() {
                                isGridView = false;
                              });
                            } else {
                              dataStorage.write('isGridView', true);
                              setState(() {
                                isGridView = true;
                              });
                            }
                            log(isGridView.toString());
                            log(dataStorage.read('isGridView').toString());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            // child: Icon(Icons.list),
                            child: isGridView == true
                                ? const Icon(
                                    Icons.grid_view,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.list,
                                    size: 30,
                                  ),
                          ),
                        ),
                        height10,
                        ListView.builder(
                          itemCount:
                              widget.searchController.categoriesList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // controller: widget.searchController.scrollController,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: Get.height * 0.12,
                          ),
                          itemBuilder: (context, index) {
                            return
                                // widget.searchController.categoriesList[index]
                                //                 ["count"] !=
                                //             0
                                //              &&
                                widget.searchController.categoriesList[index]
                                            ["name"] !=
                                        ''
                                    //     &&
                                    // widget.searchController
                                    //         .categoriesList[index]["name"] !=
                                    //     'Uncategorized'
                                    ? Container(
                                        height: 85,
                                        width: Get.width,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: const BoxDecoration(
                                          // borderRadius: BorderRadius.circular(30),
                                          color: Colors.transparent,
                                        ),
                                        child: InkWell(
                                          onLongPress: () {
                                            HapticFeedback.mediumImpact();
                                            // TODO: Implement report feature for spheres (catergories)
                                            showModalBottomSheet(
                                              backgroundColor: primaryBlack,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30.0),
                                                  topRight:
                                                      Radius.circular(30.0),
                                                ),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return SphereMoreBottomSheet(
                                                  onEditTap: () {
                                                    Get.back();
                                                    if (widget.searchController
                                                                .categoriesList[
                                                            index]["name"] ==
                                                        "Uncategorized") {
                                                      HapticFeedback
                                                          .mediumImpact();
                                                      widget.searchController
                                                          .floatingScaffold(
                                                              context,
                                                              message:
                                                                  'You can\'t edit this sphere',
                                                              height: Platform
                                                                      .isIOS
                                                                  ? Get.height *
                                                                      0.08
                                                                  : Get.height *
                                                                      0.12);
                                                    } else
                                                    // if (
                                                    //    // TODO: Check if sphere was created by the user or edit by everyone is true (Inform backend)
                                                    //   searchController.categoriesList[index]
                                                    //         ["creator"] !=
                                                    //     "username" || searchController.categoriesList[index]
                                                    //         ["allow_edit"] ==
                                                    //     "true"
                                                    // )
                                                    {
                                                      Get.to(
                                                        () => EditSphereScreen(
                                                          id: widget
                                                              .searchController
                                                              .categoriesList[
                                                                  index]['id']
                                                              .toString(),
                                                          name: widget
                                                                  .searchController
                                                                  .categoriesList[
                                                              index]['name'],
                                                          imageUrl: widget
                                                                  .searchController
                                                                  .categoriesList[
                                                              index]['image_url'],
                                                          description: widget
                                                                  .searchController
                                                                  .categoriesList[
                                                              index]['description'],
                                                        ),
                                                      )?.then(
                                                        (value) => {
                                                          widget
                                                              .searchController
                                                              .categoriesList
                                                              .clear(),
                                                          widget
                                                              .searchController
                                                              .page = 1,
                                                          widget
                                                              .searchController
                                                              .getCategories(
                                                                  context),
                                                        },
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          onTap: () {
                                            if (widget.searchController
                                                        .categoriesList[index]
                                                    ["name"] ==
                                                "Uncategorized") {
                                              widget.searchController
                                                  .uncategorizedOnTap(
                                                context: context,
                                                index: index,
                                                isGetCategories: false,
                                              );
                                              HapticFeedback.mediumImpact();
                                              //
                                            } else {
                                              widget.searchController
                                                  .spheresOnTap(
                                                context: context,
                                                index: index,
                                                isGetCategories: false,
                                              );
                                              widget.searchController
                                                  .floatingScaffold(
                                                context,
                                                message:
                                                    'Entering ${widget.searchController.categoriesList[index]['name']} Subverse',
                                                height: Platform.isIOS
                                                    ? Get.height * 0.08
                                                    : Get.height * 0.06,
                                              );
                                              HapticFeedback.mediumImpact();
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              widget.searchController.categoriesList[
                                                                  index]
                                                              ["image_url"] !=
                                                          null &&
                                                      widget.searchController
                                                                  .categoriesList[
                                                              index]["image_url"] !=
                                                          ""
                                                  ? CircleAvatar(
                                                      radius: 40.0,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          40,
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: widget
                                                                  .searchController
                                                                  .categoriesList[
                                                              index]["image_url"],
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      progress) =>
                                                                  Image.asset(
                                                            AppAsset.load,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Image.asset(
                                                              AppAsset
                                                                  .socialverselogo,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // NetworkImage(
                                                      //   widget.searchController
                                                      //           .categoriesList[
                                                      //       index]["image_url"],
                                                      // ),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    )
                                                  : CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Image.asset(
                                                          AppAsset
                                                              .socialverselogo,
                                                        ),
                                                      ),
                                                    ),
                                              width10,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if (widget.searchController
                                                                .categoriesList[
                                                            index]["name"] !=
                                                        null)
                                                      Text(
                                                        widget.searchController
                                                                .categoriesList[
                                                            index]["name"],
                                                        style: AppTextStyle
                                                            .normalRegular14
                                                            .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    if (widget.searchController
                                                                        .categoriesList[
                                                                    index][
                                                                "description"] !=
                                                            null &&
                                                        widget.searchController
                                                                        .categoriesList[
                                                                    index][
                                                                "description"] !=
                                                            '')
                                                      Text(
                                                        widget.searchController
                                                                .categoriesList[
                                                            index]["description"],
                                                        style: AppTextStyle
                                                            .normalRegular14
                                                            .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          fontSize: 13,
                                                        ),
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                          },
                        ),
                      ],
                    ),
                  )
            : isGridView == true
                ? GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 3.3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 5,
                      right: 5,
                      bottom: Get.height * 0.12,
                    ),
                    children: const [
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                      GridViewPlaceholder(),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 15,
                      right: 15,
                      bottom: Get.height * 0.12,
                    ),
                    children: const [
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                      LoadingPlaceholder(),
                    ],
                  );
      },
    );
  }
}

class GridViewPlaceholder extends StatelessWidget {
  const GridViewPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(AppAsset.load), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        height5,
        SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: 30,
              height: 8,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAsset.load),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SphereWidget extends StatelessWidget {
  final String name;
  const SphereWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
        ),
        height5,
        Text(
          name,
          style: AppTextStyle.normalRegular14
              .copyWith(color: Theme.of(context).errorColor, fontSize: 12),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.load),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              height10,
              Container(
                width: 120,
                height: 10,
                decoration: const BoxDecoration(
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
    );
  }
}
