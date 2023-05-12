import 'package:socialverse/export.dart';

enum PostSearchStatus { initial, searched }

class PostSearchGrid extends StatelessWidget {
  final SearchController searchController;
  const PostSearchGrid({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime formatTimestamp(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return date;
    }

    PostSearchStatus postSearchStatus =
        searchController.searchTextController.text.isEmpty
            ? PostSearchStatus.initial
            : PostSearchStatus.searched;

    switch (postSearchStatus) {
      case PostSearchStatus.searched:
        return searchController.postSearchList.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount: searchController.postSearchList.length,
                itemBuilder: (context, index) {
                  return searchController.postSearchList[index]["identifier"] !=
                          null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 10,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => VideoPlayerWidget(
                                      videoIndex: index,
                                      videosList:
                                          searchController.postSearchList.obs,
                                      pageController: PageController(
                                        initialPage: index,
                                      ).obs,
                                      fromHomePage: false,
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Center(
                                      child: NetworkImageWidget(
                                        imageUrl: searchController
                                            .postSearchList[index]
                                                ["thumbnail_url"]
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: Get.height,
                                        width: Get.width,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 5,
                                      child: Row(
                                        children: [
                                          Text(
                                            formatTimestamp(searchController
                                                        .postSearchList[index]
                                                    ["created_at"])
                                                .dayMonth(),
                                            style: AppTextStyle.normalRegular14
                                                .copyWith(
                                              color: whiteColor,
                                            ),
                                          ),

                                          // Icon(
                                          //   Icons.play_arrow,
                                          //   color: primaryWhite,
                                          //   size: 12,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            height10,
                            Expanded(
                              flex: 1,
                              child: Text(
                                searchController.postSearchList[index]["title"],
                                style: AppTextStyle.normalRegular14.copyWith(
                                  color: Theme.of(context).errorColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => ProfileScreen(
                                          fromMainUser: false,
                                          profileUsername: searchController
                                                  .postSearchList[index]
                                              ["username"],
                                        ),
                                      );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        searchController.postSearchList[index]
                                                    ["picture_url"] !=
                                                null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child: FadeInImage(
                                                    placeholder:
                                                        const AssetImage(
                                                            AppAsset.load),
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      searchController
                                                              .postSearchList[
                                                          index]["picture_url"],
                                                    ),
                                                    fadeInDuration:
                                                        const Duration(
                                                            milliseconds: 300),
                                                    fit: BoxFit.cover,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 8,
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    AppAsset.icuser,
                                                    width: 8,
                                                    height: 8,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                        width05,
                                        Text(
                                          searchController.postSearchList[index]
                                              ["username"],
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        size: 10,
                                        color: Colors.grey.shade500,
                                      ),
                                      width05,
                                      Text(
                                        searchController.postSearchList[index]
                                                ["upvote_count"]
                                            .toString(),
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(
                                          color: Colors.grey.shade500,
                                          fontSize: 10,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : const SizedBox.shrink();
                },
              )
            : const Center(
                child: Text("No videos found"),
              );
      default:
        return const Center(
          child: Text('Search for anything you can imagine'),
        );
    }
  }
}
