import 'package:socialverse/export.dart';
import 'package:socialverse/feature/search/views/subverse_screen.dart';

class SphereScreen extends StatefulWidget {
  const SphereScreen({Key? key}) : super(key: key);

  @override
  State<SphereScreen> createState() => _SphereScreenState();
}

class _SphereScreenState extends State<SphereScreen>
    with SingleTickerProviderStateMixin
//  AutomaticKeepAliveClientMixin
{
  // bool get wantKeepAlive => true;
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    bool theme = dataStorage.read("isDarkMode");
    // super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              Expanded(
                child: SearchBar(
                  onTap: () {
                    // Get.to(() => SearchScreen());
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => const SearchScreen(),
                      ),
                    );
                  },
                  readOnly: true,
                  // controller: controller.searchTextController,
                  darkTheme: theme,
                ),
              ),
              // width05,
              // InkWell(
              //   onTap: () {
              //     if (dataStorage.read('isLogging') == true) {
              //       Get.to(() => const CreateSphereScreen())?.then((value) {
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
              //           return const SizedBox();
              //         },
              //       );
              //     }
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //       color: theme ? fillGrey : Colors.grey.shade300,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Icon(
              //       Icons.add,
              //       color: primaryWhite,
              //     ),
              //   ),
              // )
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: GetBuilder<SearchController>(
        init: SearchController(),
        initState: (state) {
          searchController.tabController =
              TabController(vsync: this, length: 3);
        },
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              height5,
              Expanded(
                child: SubverseScreen(),
              )
            ],
          );
        },
      ),
    );
  }
}
