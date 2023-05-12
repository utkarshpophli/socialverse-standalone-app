import 'dart:developer';
import '../../../export.dart';

enum SpheresSearchStatus { initial, searching, searched }

class SpheresSearchGrid extends StatelessWidget {
  final SearchController searchController;
  const SpheresSearchGrid({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SpheresSearchStatus spheresSearchStatus =
        searchController.searchTextController.text.isEmpty
            ? SpheresSearchStatus.initial
            : searchController.isSearching == true
                ? SpheresSearchStatus.searching
                : SpheresSearchStatus.searched;
    switch (spheresSearchStatus) {
      case SpheresSearchStatus.searching:
        return searchController.categorySearchList.isEmpty
            ? ListView(
                shrinkWrap: true,
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
            : const SizedBox();
      case SpheresSearchStatus.initial:
        return GetBuilder<SearchController>(
          initState: (state) {
            // searchController.getCategories(context);
          },
          builder: (controller) {
            return ListView.builder(
              itemCount: searchController.categoriesList.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                return searchController.searchCategoryLoading == false
                    ? InkWell(
                        splashColor: Colors.transparent,
                        // TODO: Add on longPress to open a bottomsheet with options (edit sphere, report sphere, delete sphere)
                        // onLongPress: () {
                        //   showModalBottomSheet(
                        //     backgroundColor: primaryBlack,
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.only(
                        //         topLeft: Radius.circular(30.0),
                        //         topRight: Radius.circular(30.0),
                        //       ),
                        //     ),
                        //     context: context,
                        //     builder: (context) {
                        //       return SphereMoreBottomSheet(
                        //         onEditTap: () {
                        //           Get.back();
                        //           if (searchController.categoriesList[index]
                        //                   ["name"] ==
                        //               "Uncategorized") {
                        //             HapticFeedback.mediumImpact();
                        //             searchController.floatingScaffold(context,
                        //                 message: 'You can\'t edit this sphere',
                        //                 height: Platform.isIOS
                        //                     ? Get.height * 0.08
                        //                     : Get.height * 0.06);
                        //           } else
                        //           // if (
                        //           //    // TODO: Check if sphere was created by the user or edit by everyone is true (Inform backend)
                        //           //   searchController.categoriesList[index]
                        //           //         ["creator"] !=
                        //           //     "username" || searchController.categoriesList[index]
                        //           //         ["allow_edit"] ==
                        //           //     "true"
                        //           // )
                        //           {
                        //             Get.to(
                        //               () => EditSphereScreen(
                        //                 id: searchController
                        //                     .categoriesList[index]['id']
                        //                     .toString(),
                        //                 name: searchController
                        //                     .categoriesList[index]['name'],
                        //                 imageUrl: searchController
                        //                     .categoriesList[index]['image_url'],
                        //               ),
                        //             );
                        //           }
                        //         },
                        //       );
                        //     },
                        //   );
                        // },
                        onTap: () {
                          log(index.toString());
                          searchController.spheresOnTap(
                            context: context,
                            index: index,
                            isGetCategories: false,
                          );
                          FocusScope.of(context).requestFocus(FocusNode());
                          searchController.categoriesList[index]["name"] ==
                                  'Uncategorized'
                              ? null
                              : searchController.floatingScaffold(context,
                                  message:
                                      'Entering ${searchController.categoriesList[index]["name"]} Subverse',
                                  height: Get.height * 0.06);
                          HapticFeedback.mediumImpact();
                        },
                        child: Container(
                          height: 85,
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              searchController.categoriesList[index]
                                              ["image_url"] !=
                                          null &&
                                      searchController.categoriesList[index]
                                              ["image_url"] !=
                                          ''
                                  ? CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: NetworkImage(
                                        searchController.categoriesList[index]
                                            ["image_url"],
                                      ),
                                      backgroundColor: secondaryGrey,
                                    )
                                  : CircleAvatar(
                                      radius: 40.0,
                                      backgroundColor: Colors.grey.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          AppAsset.socialverselogo,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                              width10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (searchController.categoriesList[index]
                                            ["name"] !=
                                        null)
                                      Text(
                                        searchController.categoriesList[index]
                                            ["name"],
                                        style:
                                            AppTextStyle.normalBold16.copyWith(
                                          color: Theme.of(context).errorColor,
                                          // fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    // if (searchController.categoriesList[index]
                                    //         ["count"] !=
                                    //     null)
                                    //   Text(
                                    //     searchController.categoriesList[index]
                                    //                 ["count"]
                                    //             .toString() +
                                    //         ' Videos',
                                    //     style:
                                    //         AppTextStyle.normalRegular14.copyWith(
                                    //       color: Theme.of(context).errorColor,
                                    //       // fontSize: 12,
                                    //     ),
                                    //     textAlign: TextAlign.start,
                                    //   ),
                                    if (searchController.categoriesList[index]
                                            ["description"] !=
                                        null)
                                      Text(
                                        searchController.categoriesList[index]
                                            ["description"],
                                        style:
                                            AppTextStyle.normalBold16.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView(
                        shrinkWrap: true,
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
                      );
                // : SizedBox();
              },
            );
          },
        );
      case SpheresSearchStatus.searched:
        return searchController.categorySearchList.isNotEmpty
            ? ListView.builder(
                itemCount: searchController.categorySearchList.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  return
                      // searchController.categoriesList[index][""] != "" ?
                      InkWell(
                    splashColor: Colors.transparent,
                    // TODO: Add on longPress to open a bottomsheet with options (edit sphere, report sphere, delete sphere)
                    // onLongPress: () {
                    //   showModalBottomSheet(
                    //     backgroundColor: primaryBlack,
                    //     shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(30.0),
                    //         topRight: Radius.circular(30.0),
                    //       ),
                    //     ),
                    //     context: context,
                    //     builder: (context) {
                    //       return SphereMoreBottomSheet(
                    //         onEditTap: () {
                    //           Get.back();
                    //           if (searchController.categorySearchList[index]
                    //                   ["name"] ==
                    //               "Uncategorized") {
                    //             HapticFeedback.mediumImpact();
                    //             searchController.floatingScaffold(context,
                    //                 message: 'You can\'t edit this sphere',
                    //                 height: Platform.isIOS
                    //                     ? Get.height * 0.08
                    //                     : Get.height * 0.06);
                    //           } else
                    //           // if (
                    //           //    // TODO: Check if sphere was created by the user or edit by everyone is true (Inform backend)
                    //           //   searchController.categorySearchList[index]
                    //           //         ["creator"] !=
                    //           //     "username" || searchController.categorySearchList[index]
                    //           //         ["allow_edit"] ==
                    //           //     "true"
                    //           // )
                    //           {
                    //             Get.to(
                    //               () => EditSphereScreen(
                    //                 id: searchController
                    //                     .categorySearchList[index]['id']
                    //                     .toString(),
                    //                 name: searchController
                    //                     .categorySearchList[index]['name'],
                    //                 imageUrl: searchController
                    //                     .categorySearchList[index]['image_url'],
                    //               ),
                    //             );
                    //           }
                    //         },
                    //       );
                    //     },
                    //   );
                    // },
                    onTap: () {
                      log(index.toString());
                      searchController.spheresOnTap(
                        context: context,
                        index: index,
                        isGetCategories: true,
                      );
                      FocusScope.of(context).requestFocus(FocusNode());
                      searchController.categorySearchList[index]["name"] ==
                              'Uncategorized'
                          ? null
                          : searchController.floatingScaffold(context,
                              message:
                                  'Entering ${searchController.categorySearchList[index]["name"]} Subverse',
                              height: Get.height * 0.06);
                      HapticFeedback.mediumImpact();
                    },
                    child: Container(
                      height: 85,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          searchController.categorySearchList[index]
                                          ["image_url"] !=
                                      null &&
                                  searchController.categorySearchList[index]
                                          ["image_url"] !=
                                      ''
                              ? CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(
                                    searchController.categorySearchList[index]
                                        ["image_url"],
                                  ),
                                  backgroundColor: secondaryGrey,
                                )
                              : CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.grey.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppAsset.socialverselogo,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                          width10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (searchController.categorySearchList[index]
                                        ["name"] !=
                                    null)
                                  Text(
                                    searchController.categorySearchList[index]
                                        ["name"],
                                    style: AppTextStyle.normalBold16.copyWith(
                                      color: Theme.of(context).errorColor,
                                      // fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                // if (searchController.categorySearchList[index]
                                //         ["count"] !=
                                //     null)
                                //   Text(
                                //     searchController.categorySearchList[index]
                                //                 ["count"]
                                //             .toString() +
                                //         ' Videos',
                                //     style:
                                //         AppTextStyle.normalRegular14.copyWith(
                                //       color: Theme.of(context).errorColor,
                                //       // fontSize: 12,
                                //     ),
                                //     textAlign: TextAlign.start,
                                //   ),
                                if (searchController.categorySearchList[index]
                                        ["description"] !=
                                    null)
                                  Text(
                                    searchController.categorySearchList[index]
                                        ["description"],
                                    style: AppTextStyle.normalBold16.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  // : SizedBox();
                },
              )
            : const Center(
                child: Text("No Sphere found"),
              );
      default:
        return const Center(
          child: Text('Search for Spheres'),
        );
    }
  }
}
