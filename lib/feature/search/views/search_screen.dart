import 'package:socialverse/export.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SphereScreenState();
}

class _SphereScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    bool theme = dataStorage.read("isDarkMode");
    return GetBuilder<SearchController>(
      init: SearchController(),
      initState: (state) {
        searchController.tabController = TabController(
          vsync: this,
          length: 2,
        );
      },
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              leading: const SizedBox.shrink(),
              elevation: 0,
              leadingWidth: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      searchController.searchTextController.clear();
                      searchController.categorySearchList.clear();
                      searchController.userSearchList.clear();
                      searchController.postSearchList.clear();
                      searchController.isSearching = false;
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
                      autofocus: false,
                      controller: controller.searchTextController,
                      darkTheme: theme,
                      onChanged: (String? value) =>
                          controller.onSearchChange(context, value!),
                    ),
                  ),
                  // width05,
                  // SVGIconButton(
                  //   icon: AppAsset.filter,
                  //   buttonColor: theme ? fillGrey : grey,
                  //   ontap: () {
                  //     Get.to(() => FilterScreen());
                  //     // isAutoplay.value = false;
                  //     // videoPlayerController!.value.pause();
                  //     // Get.to(() => MessageScreen())?.then(
                  //     //   (value) {
                  //     //     videoPlayerController!.value.play();
                  //     //     isAutoplay.value = true;
                  //     //   },
                  //     // );
                  //   },
                  //   padding: 15.0,
                  //   borderRadius: 10.0,
                  // ),
                  // width05,
                  // InkWell(
                  //   onTap: () {
                  //     if (dataStorage.read('isLogging') == true) {
                  //       Get.to(() => CreatSphereScreen())?.then((value) {
                  //         searchController.categoriesList.clear();
                  //         searchController.page = 1;
                  //         searchController.getCategories(context);
                  //       });
                  //     } else {
                  //       showModalBottomSheet(
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(30.0),
                  //             topRight: Radius.circular(30.0),
                  //           ),
                  //         ),
                  //         context: context,
                  //         builder: (context) {
                  //           return const Bottomsheet();
                  //         },
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(12),
                  //     decoration: BoxDecoration(
                  //       color: theme ? fillGrey : grey,
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Icon(
                  //       Icons.add,
                  //       color: primaryWhite,
                  //     ),
                  //     // child: Image.asset(
                  //     //   widget.icon!,
                  //     //   color: widget.iconColor ?? primaryWhite,
                  //     //   height: widget.iconHeight ?? 18,
                  //     // )
                  //   ),
                  // )
                ],
              ),
              centerTitle: true,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: greyText.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                ),
                child: TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: searchController.tabController,
                  indicatorColor: Theme.of(context).errorColor,
                  labelStyle: ThemeData().textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                  tabs: const [
                    // Tab(
                    //   text: "Subverses",
                    // ),
                    Tab(
                      text: "Videos",
                    ),
                    Tab(
                      text: "Users",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: searchController.tabController,
                  children: [
                    // SpheresSearchGrid(searchController: searchController),
                    PostSearchGrid(searchController: searchController),
                    AccountSearchGrid(searchController: searchController),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
