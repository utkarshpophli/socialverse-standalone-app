import 'package:socialverse/export.dart';

enum AccountSearchStatus { initial, searching, searched }

class AccountSearchGrid extends StatelessWidget {
  final SearchController searchController;
  const AccountSearchGrid({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AccountSearchStatus accountSearchStatus =
        searchController.searchTextController.text.isEmpty
            ? AccountSearchStatus.initial
            : searchController.isSearching == true
                ? AccountSearchStatus.searching
                : AccountSearchStatus.searched;
    switch (accountSearchStatus) {
      case AccountSearchStatus.searching:
        return searchController.userSearchList.isEmpty
            ? ListView(
                padding: EdgeInsets.zero,
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
              )
            : const SizedBox.shrink();
      case AccountSearchStatus.searched:
        return searchController.userSearchList.isNotEmpty
            ? ListView.builder(
                itemCount: searchController.userSearchList.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => ProfileScreen(
                          fromMainUser: false,
                          profileUsername: searchController
                              .userSearchList[index]["username"],
                        ),
                      );
                    },
                    child: Container(
                      height: 65,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          searchController.userSearchList[index]
                                      ["profile_picture_url"] !=
                                  null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: FadeInImage(
                                      placeholder:
                                          const AssetImage(AppAsset.load),
                                      image: CachedNetworkImageProvider(
                                        searchController.userSearchList[index]
                                            ["profile_picture_url"],
                                      ),
                                      fadeInDuration:
                                          const Duration(milliseconds: 300),
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppAsset.icuser,
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          width10,

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (searchController.userSearchList[index]
                                      ["username"] !=
                                  null)
                                Text(
                                  searchController.userSearchList[index]
                                      ["username"],
                                  style:
                                      themeData.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (searchController.userSearchList[index]
                                          ["first_name"] !=
                                      null &&
                                  searchController.userSearchList[index]
                                          ["last_name"] !=
                                      null)
                                Text(
                                  searchController.userSearchList[index]
                                          ["first_name"] +
                                      ' ' +
                                      searchController.userSearchList[index]
                                          ["last_name"],
                                  style: themeData.textTheme.bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade500),
                                ),
                              if (searchController.userSearchList[index]
                                          ["bio"] !=
                                      null &&
                                  searchController.userSearchList[index]
                                          ["bio"] !=
                                      '')
                                Text(
                                  searchController.userSearchList[index]["bio"],
                                  style: themeData.textTheme.bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey.shade500),
                                ),
                            ],
                          ),
                          const Spacer(),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   child: Text(
                          //     "200k",
                          //     style: themeData.textTheme.bodySmall!,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text("No users found"),
              );
      default:
        return const Center(
          child: Text('Search for cool SocialVerse users'),
        );
    }
  }
}
