import 'package:socialverse/export.dart';

class HashtagSearch extends StatelessWidget {
  final SearchController searchController;
  const HashtagSearch({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ListView.builder(
        itemCount: searchController.recentAccount.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Get.to(() => ProfileScreen(
              //       fromMainUser: false,
              //       profileUsername: searchController.userSearchList[index]
              //           ["username"],
              //     ));
            },
            child: Container(
              height: 50,
              width: Get.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).backgroundColor,
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                searchController.recentAccount[index]["image"]),
                            fit: BoxFit.cover)),
                  ),
                  width10,
                  Text(
                    "@" + searchController.recentAccount[index]["name"],
                    style: themeData.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "200k",
                      style: themeData.textTheme.bodySmall!,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
