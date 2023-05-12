import 'package:socialverse/export.dart';

class BrowseSubverse extends StatefulWidget {
  const BrowseSubverse({Key? key}) : super(key: key);

  @override
  State<BrowseSubverse> createState() => _BrowseSubverseState();
}

class _BrowseSubverseState extends State<BrowseSubverse>
    with SingleTickerProviderStateMixin {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Subverses",
            style: ThemeData().textTheme.bodySmall!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).errorColor,
                ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Theme.of(context).errorColor),
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
            children: [
              height5,
              Expanded(
                child: Spheres(
                  searchController: searchController,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
