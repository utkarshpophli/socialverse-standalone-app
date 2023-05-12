import 'package:socialverse/export.dart';

class FollowingScreen extends StatefulWidget {
  final String? userName;
  const FollowingScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  final FollowingController followingController =
      Get.put(FollowingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: UIInterface.backgroundTheme(),
        child: commonAppbar(
          context: context,
          title: "Following",
          child: GetBuilder<FollowingController>(
            initState: (state) {
              followingController.getFollowing(context, widget.userName);
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
                    controller.followingList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.followingList.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => ProfileScreen(
                                                fromMainUser: false,
                                                profileUsername: controller
                                                        .followingList[index]
                                                    ["username"],
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              UIInterface.profileImageWidget(
                                                imgUrl: controller
                                                    .followingList[index]
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
                                                    controller.followingList[
                                                                index]
                                                            ["first_name"] +
                                                        " " +
                                                        controller
                                                                .followingList[
                                                            index]["last_name"],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                  Text(
                                                    "@${controller.followingList[index]["username"]}",
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
                                              controller.followingList[index]
                                                          ["is_following"] ==
                                                      false
                                                  ? TransparentButton(
                                                      width: 120,
                                                      height: 35,
                                                      title: 'Unsubscribe',
                                                      onPressed: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        controller.index =
                                                            index;
                                                        controller.followUser(
                                                          context: context,
                                                          profileUsername: controller
                                                                  .followingList[
                                                              index]["username"],
                                                          isFollowing: controller
                                                                      .followingList[
                                                                  index]
                                                              ["is_following"],
                                                          username:
                                                              widget.userName,
                                                        );

                                                        controller.followingList[
                                                                    index][
                                                                "is_following"] =
                                                            !controller.followingList[
                                                                    index][
                                                                "is_following"];

                                                        setState(() {});
                                                      },
                                                    )
                                                  : ImageTextButton(
                                                      width: 120,
                                                      height: 35,
                                                      onPressed: () {
                                                        controller.followUser(
                                                          context: context,
                                                          profileUsername: controller
                                                                  .followingList[
                                                              index]["username"],
                                                          isFollowing: controller
                                                                      .followingList[
                                                                  index]
                                                              ["is_following"],
                                                          username:
                                                              widget.userName,
                                                        );
                                                        controller.followingList[
                                                                    index][
                                                                "is_following"] =
                                                            !controller.followingList[
                                                                    index][
                                                                "is_following"];
                                                        setState(() {});
                                                      },
                                                      title: "Subscribe",
                                                    ),
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
        ),
      ),
    );
  }
}
