import 'package:socialverse/export.dart';

class FollowerScreen extends StatelessWidget {
  final String? userName;
  FollowerScreen({Key? key, required this.userName}) : super(key: key);
  final FollowerController followerController = Get.put(FollowerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: UIInterface.backgroundTheme(),
        child: commonAppbar(
          title: "Followers",
          child: GetBuilder<FollowerController>(
            initState: (state) {
              followerController.getfollowers(context, userName);
            },
            builder: (controller) {
              bool theme = dataStorage.read("isDarkMode");
              return Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: SearchBar(
                        darkTheme: theme,
                      ),
                    ),
                    height20,
                    controller.followersList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.followersList.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  // const EdgeInsets.only(
                                  //     left: 10, right: 10),
                                  child: Container(
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => ProfileScreen(
                                                fromMainUser: false,
                                                profileUsername: controller
                                                        .followersList[index]
                                                    ["username"],
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              UIInterface.profileImageWidget(
                                                imgUrl: controller
                                                    .followersList[index]
                                                        ["profile_picture_url"]
                                                    .toString(),
                                                radius: 30,
                                                height: 52,
                                                width: 52,
                                              ),
                                              width10,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.followersList[
                                                                index]
                                                            ["first_name"] ??
                                                        "" " " +
                                                            controller.followersList[
                                                                    index]
                                                                ["last_name"] ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                  Text(
                                                    "@${controller.followersList[index]["username"] ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          fontSize: 12,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              controller.followersList[index]
                                                          ["is_following"] ==
                                                      false
                                                  ? ImageTextButton(
                                                      width: 120,
                                                      height: 35,
                                                      onPressed: () {
                                                        controller.followUser(
                                                          context: context,
                                                          profileUsername: controller
                                                                  .followersList[
                                                              index]["username"],
                                                          isFollowing: controller
                                                                      .followersList[
                                                                  index]
                                                              ["is_following"],
                                                          username: userName,
                                                        );

                                                        controller.followersList[
                                                                    index][
                                                                "is_following"] =
                                                            true;
                                                      },
                                                      title: "Subscribe",
                                                    )
                                                  : TransparentButton(
                                                      height: 35,
                                                      width: 120,
                                                      title: 'Unsubscribe',
                                                      onPressed: () {
                                                        controller.followUser(
                                                          context: context,
                                                          profileUsername: controller
                                                                  .followersList[
                                                              index]["username"],
                                                          isFollowing: controller
                                                                      .followersList[
                                                                  index]
                                                              ["is_following"],
                                                          username: userName,
                                                        );

                                                        controller.followersList[
                                                                    index][
                                                                "is_following"] =
                                                            false;
                                                      },
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Offstage(),
                  ],
                ),
              );
            },
          ),
          context: context,
        ),
      ),
    );
  }
}
