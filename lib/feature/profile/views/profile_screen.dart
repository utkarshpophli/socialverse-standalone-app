import 'dart:developer';
import 'package:socialverse/core/config/dynamic_link_service.dart';
import 'package:socialverse/export.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  final bool fromMainUser;
  final String? profileUsername;

  final Function(bool isFollow)? updateUserStatus;
  const ProfileScreen(
      {Key? key,
      required this.fromMainUser,
      this.profileUsername,
      this.updateUserStatus})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());
  final searchController = Get.put(SearchController());
  DynamicRepository dynamicRepository = DynamicRepository();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return RefreshIndicator(
      color: purpleColor,
      backgroundColor: Colors.transparent,
      onRefresh: () async {
        String userName = widget.profileUsername.toString();
        HapticFeedback.mediumImpact();
        profileController.page = 1;
        profileController.videoList.clear();
        profileController.getProfileDetails(
          context,
          fromUser: widget.fromMainUser,
          profileusername: userName,
        );
        // profileController.getVideos(
        //   context,
        //   fromUser: widget.fromMainUser,
        //   profileusername: userName,
        // );
      },
      child: GetBuilder<ProfileController>(
        dispose: (state) {
          // profileController.myPostList.clear();
          if (widget.fromMainUser == false) {
            profileController.tempVideoList.clear();
            profileController.profileDataList = {};
          }
        },
        initState: (state) async {
          profileController.username = widget.profileUsername;
          profileController.fromUser = widget.fromMainUser;
          profileController.temppage = 1;
          await profileController.getProfileDetails(
            context,
            fromUser: widget.fromMainUser,
            profileusername: widget.profileUsername.toString(),
          );
          // if (widget.fromMainUser == true) {
          //   String userName = widget.profileUsername.toString();
          //   profileController.getProfileDetails(
          //     context,
          //     fromUser: widget.fromMainUser,
          //     profileusername: userName,
          //   );
          // } else {
          // if (profileController.tempProfileList.isEmpty) {
          //   String userName = widget.profileUsername.toString();
          //   profileController.getProfileDetails(
          //     context,
          //     fromUser: widget.fromMainUser,
          //     profileusername: userName,
          //   );
          // } else {
          //   profileController.profileDataList =
          //       profileController.tempProfileList;
          //   profileController.update;
          //   // log(" ======> ${profileController.tempVideoList}");
          //   profileController.videoList =
          //       profileController.tempVideoList.reversed.toList();
          //   profileController.update;
          // }
          // if (profileController.tempProfileList.isEmpty) {
          //   String userName = widget.profileUsername.toString();
          //   profileController.getProfileDetails(
          //     context,
          //     fromUser: widget.fromMainUser,
          //     profileusername: userName,
          //   );
          // }
          // }
        },
        builder: (controller) {
          bool theme = dataStorage.read("isDarkMode");

          //Get.theme.brightness.obs == Brightness.dark.obs;
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SingleChildScrollView(
              controller: controller.scrollController,
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: Get.width,
                    decoration: UIInterface.profileBackgroundTheme(),
                    padding:
                        const EdgeInsets.only(top: 50, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  if (widget.fromMainUser == false)
                                    IconsIconButton(
                                      icon: Icons.arrow_back_ios_new_rounded,
                                      borderRadius: 12,
                                      ontap: () {
                                        // profileController.profileDataList =
                                        //     profileController.tempProfileList;
                                        // profileController.update;
                                        // log(" ======> ${profileController.tempVideoList}");
                                        // profileController.videoList =
                                        //     profileController.tempVideoList;
                                        // profileController.update;
                                        Get.back();
                                        // profileController.update();
                                        // setState(() {});
                                      },
                                    ),
                                  width05,
                                  // if (widget.profileUsername ==
                                  //     dataStorage.read('username'))
                                  //   UIInterface.iconButtonWidget(
                                  //     AppAsset.chat,
                                  //     () {
                                  //       // Get.to(
                                  //       //   () => ChatScreen(),
                                  //       // );
                                  //     },
                                  //   ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: controller.profileDataList.isNotEmpty
                                  ? SizedBox(
                                      width: 100,
                                      child: Text(
                                        controller.profileDataList["username"]
                                                    .toString() !=
                                                'null'
                                            ? controller
                                                .profileDataList["username"]
                                                .toString()
                                            : "N/A",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.normalBold16
                                            .copyWith(color: primaryWhite),
                                      ),
                                    )
                                  : Container(),
                            ),
                            // customWidth(20),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (controller.profileDataList.isNotEmpty)
                                    if (widget.profileUsername !=
                                        dataStorage.read('username'))
                                      Container(
                                        height: 45,
                                        width: 45,
                                      ),
                                  // if (widget.profileUsername !=
                                  //     dataStorage.read('username'))
                                  //   UIInterface.iconButtonWidget(
                                  //     AppAsset.chat,
                                  //     () {
                                  //       // Get.to(
                                  //       //   () => ChatScreen(),
                                  //       // );
                                  //     },
                                  //   ),
                                  // if (widget.profileUsername ==
                                  //     dataStorage.read('username'))
                                  //   UIInterface.iconButtonWidget(
                                  //     AppAsset.icnotification,
                                  //     () {
                                  //       // Get.to(
                                  //       //   () => const NotificationScreen(),
                                  //       // );
                                  //     },
                                  //   ),
                                  width05,
                                  if (widget.profileUsername ==
                                      dataStorage.read('username'))
                                    UIInterface.iconButtonWidget(
                                      AppAsset.icsetting,
                                      () {
                                        Get.to(
                                          () => SettingScreen(
                                            fromMainUser: widget.fromMainUser,
                                            name: controller
                                                .profileDataList["name"],
                                            profileUsername:
                                                dataStorage.read("username"),
                                          ),
                                        );
                                      },
                                    ),
                                  if (widget.profileUsername !=
                                      dataStorage.read('username'))
                                    InkWell(
                                      onTap: () async {
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
                                            return UserMoreBottomSheet(
                                              username: controller
                                                  .profileDataList["username"]
                                                  .toString(),
                                              theme: theme,
                                            );
                                          },
                                        );
                                        HapticFeedback.mediumImpact();
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: whiteColor.withOpacity(.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.more_vert,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 200,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: Get.height * 0.09),
                          decoration: BoxDecoration(
                            color: themeData.primaryColor,
                            borderRadius: const BorderRadius.vertical(
                              top: const Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  controller.profileDataList["name"]
                                              .toString() !=
                                          'null'
                                      ? controller.profileDataList["name"]
                                      : " ",
                                  style:
                                      themeData.textTheme.bodySmall!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              height10,
                              followerBar(theme, widget.profileUsername),
                              height10,
                              dataStorage.read('username') ==
                                      widget.profileUsername
                                  ? SizedBox(
                                      width: Get.width * 0.75,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              // width: Get.width / 1.5,
                                              child: ImageTextButton(
                                                title: 'Edit Profile',
                                                onPressed: () =>
                                                    controller.goToEditProfile(
                                                  context,
                                                  widget.fromMainUser,
                                                  dataStorage.read("username"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          controller.profileDataList[
                                                          "instagram_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "youtube_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "tiktok_url"] !=
                                                      ''
                                              ? width10
                                              : const SizedBox(),
                                          controller.profileDataList[
                                                          "instagram_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "youtube_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "tiktok_url"] !=
                                                      ''
                                              ? PopupMenuButton(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Icon(
                                                          UniconsLine.link,
                                                          size: 25,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: secondaryGrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            UniconsLine
                                                                .instagram,
                                                            size: 25,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          width05,
                                                          Text(
                                                            'Instagram',
                                                            style: AppTextStyle
                                                                .normalRegular16
                                                                .copyWith(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      value: 1,
                                                      onTap: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        launchUrl(
                                                          Uri.parse(controller
                                                              .profileDataList[
                                                                  "instagram_url"]
                                                              .toString()),
                                                          mode: LaunchMode
                                                              .externalNonBrowserApplication,
                                                        ).then((value) {
                                                          // Get.back();
                                                        });
                                                        LaunchMode
                                                            .externalApplication;
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            UniconsLine.youtube,
                                                            size: 25,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          width05,
                                                          Text(
                                                            'Youtube',
                                                            style: AppTextStyle
                                                                .normalRegular16
                                                                .copyWith(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      value: 2,
                                                      onTap: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        launchUrl(
                                                          Uri.parse(controller
                                                              .profileDataList[
                                                                  "youtube_url"]
                                                              .toString()),
                                                          mode: LaunchMode
                                                              .externalNonBrowserApplication,
                                                        ).then((value) {
                                                          // Get.back();
                                                        });
                                                        LaunchMode
                                                            .externalApplication;
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .tiktok_outlined,
                                                            size: 25,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          width05,
                                                          Text(
                                                            'TikTok',
                                                            style: AppTextStyle
                                                                .normalRegular16
                                                                .copyWith(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      value: 3,
                                                      onTap: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        launchUrl(
                                                          Uri.parse(controller
                                                              .profileDataList[
                                                                  "tiktok_url"]
                                                              .toString()),
                                                          mode: LaunchMode
                                                              .externalNonBrowserApplication,
                                                        ).then((value) {
                                                          // Get.back();
                                                        });
                                                        LaunchMode
                                                            .externalApplication;
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    controller.profileDataList[
                                                                "instagram_url"] !=
                                                            ''
                                                        ? width10
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "instagram_url"] !=
                                                            ''
                                                        ? SocialLink(
                                                            context,
                                                            link: controller
                                                                .profileDataList[
                                                                    "instagram_url"]
                                                                .toString(),
                                                            icon: UniconsLine
                                                                .instagram,
                                                          )
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "youtube_url"] !=
                                                            ''
                                                        ? width10
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "youtube_url"] !=
                                                            ''
                                                        ? SocialLink(
                                                            context,
                                                            link: controller
                                                                .profileDataList[
                                                                    "youtube_url"]
                                                                .toString(),
                                                            icon: UniconsLine
                                                                .youtube,
                                                          )
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "tiktok_url"] !=
                                                            ''
                                                        ? width10
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "tiktok_url"] !=
                                                            ''
                                                        ? SocialLink(
                                                            context,
                                                            link: controller
                                                                .profileDataList[
                                                                    "tiktok_url"]
                                                                .toString(),
                                                            icon: Icons
                                                                .tiktok_outlined,
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                )
                                          //  controller.profileDataList[
                                          //             "instagram_url"] !=
                                          //         ''
                                          //     ? width10
                                          //     : SizedBox(),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: Get.width * 0.75,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              // width: Get.width / 1.5,
                                              child: controller.profileDataList[
                                                          "is_following"] !=
                                                      true
                                                  ? ImageTextButton(
                                                      title: 'Subscribe',
                                                      onPressed: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        if (widget
                                                                .updateUserStatus !=
                                                            null) {
                                                          widget
                                                              .updateUserStatus!(
                                                            true,
                                                          );
                                                        }
                                                        controller.followUser(
                                                          context,
                                                          widget.fromMainUser,
                                                          widget
                                                              .profileUsername,
                                                        );
                                                      })
                                                  : TransparentButton(
                                                      title: 'Unsubscribe',
                                                      onPressed: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        controller.followUser(
                                                            context,
                                                            widget.fromMainUser,
                                                            widget
                                                                .profileUsername);
                                                        if (widget
                                                                .updateUserStatus !=
                                                            null) {
                                                          widget.updateUserStatus!(
                                                              false);
                                                        }
                                                      },
                                                    ),
                                            ),
                                          ),
                                          controller.profileDataList[
                                                          "instagram_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "youtube_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "tiktok_url"] !=
                                                      ''
                                              ? width10
                                              : const SizedBox(),
                                          controller.profileDataList[
                                                          "instagram_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "youtube_url"] !=
                                                      '' &&
                                                  controller.profileDataList[
                                                          "tiktok_url"] !=
                                                      ''
                                              ? PopupMenuButton(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Icon(
                                                          UniconsLine.link,
                                                          size: 25,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: secondaryGrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            UniconsLine
                                                                .instagram,
                                                            size: 25,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          width05,
                                                          Text(
                                                            'Instagram',
                                                            style: AppTextStyle
                                                                .normalRegular16
                                                                .copyWith(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      value: 1,
                                                      onTap: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        launchUrl(
                                                          Uri.parse(controller
                                                              .profileDataList[
                                                                  "instagram_url"]
                                                              .toString()),
                                                          mode: LaunchMode
                                                              .externalNonBrowserApplication,
                                                        ).then((value) {
                                                          // Get.back();
                                                        });
                                                        LaunchMode
                                                            .externalApplication;
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            UniconsLine.youtube,
                                                            size: 25,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          width05,
                                                          Text(
                                                            'Youtube',
                                                            style: AppTextStyle
                                                                .normalRegular16
                                                                .copyWith(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      value: 2,
                                                      onTap: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        launchUrl(
                                                          Uri.parse(controller
                                                              .profileDataList[
                                                                  "youtube_url"]
                                                              .toString()),
                                                          mode: LaunchMode
                                                              .externalNonBrowserApplication,
                                                        ).then((value) {
                                                          // Get.back();
                                                        });
                                                        LaunchMode
                                                            .externalApplication;
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .tiktok_outlined,
                                                            size: 25,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          width05,
                                                          Text(
                                                            'TikTok',
                                                            style: AppTextStyle
                                                                .normalRegular16
                                                                .copyWith(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      value: 3,
                                                      onTap: () {
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        launchUrl(
                                                          Uri.parse(controller
                                                              .profileDataList[
                                                                  "tiktok_url"]
                                                              .toString()),
                                                          mode: LaunchMode
                                                              .externalNonBrowserApplication,
                                                        ).then((value) {
                                                          // Get.back();
                                                        });
                                                        LaunchMode
                                                            .externalApplication;
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    controller.profileDataList[
                                                                "instagram_url"] !=
                                                            ''
                                                        ? width10
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "instagram_url"] !=
                                                            ''
                                                        ? SocialLink(
                                                            context,
                                                            link: controller
                                                                .profileDataList[
                                                                    "instagram_url"]
                                                                .toString(),
                                                            icon: UniconsLine
                                                                .instagram,
                                                          )
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "youtube_url"] !=
                                                            ''
                                                        ? width10
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "youtube_url"] !=
                                                            ''
                                                        ? SocialLink(
                                                            context,
                                                            link: controller
                                                                .profileDataList[
                                                                    "youtube_url"]
                                                                .toString(),
                                                            icon: UniconsLine
                                                                .youtube,
                                                          )
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "tiktok_url"] !=
                                                            ''
                                                        ? width10
                                                        : const SizedBox(),
                                                    controller.profileDataList[
                                                                "tiktok_url"] !=
                                                            ''
                                                        ? SocialLink(
                                                            context,
                                                            link: controller
                                                                .profileDataList[
                                                                    "tiktok_url"]
                                                                .toString(),
                                                            icon: Icons
                                                                .tiktok_outlined,
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                              height10,
                              controller.profileDataList["bio"].toString() != ''
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                      ),
                                      child: Text(
                                        controller.profileDataList["bio"]
                                                    .toString() !=
                                                'null'
                                            ? controller.profileDataList["bio"]
                                            : " ",
                                        style: themeData.textTheme.bodySmall!
                                            .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : const SizedBox(),
                              controller.profileDataList["website"]
                                          .toString() !=
                                      ''
                                  ? height5
                                  : const SizedBox(),
                              controller.profileDataList["website"]
                                              .toString() !=
                                          '' &&
                                      controller.profileDataList["website"]
                                              .toString() !=
                                          'null'
                                  ? SizedBox(
                                      width: Get.width / 1.2,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          launchUrl(
                                            Uri.parse(
                                              controller
                                                  .profileDataList["website"]
                                                  .toString(),
                                            ),
                                          ).then((value) {
                                            // Get.back();
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // Expanded(
                                            //   child: Center(
                                            //     child: RichText(
                                            //       overflow:
                                            //           TextOverflow.ellipsis,
                                            //       maxLines: 1,
                                            //       text: TextSpan(
                                            //         style: DefaultTextStyle.of(
                                            //                 context)
                                            //             .style,
                                            //         children: [
                                            //           WidgetSpan(
                                            //             child: Icon(
                                            //               UniconsLine.link,
                                            //               color: Colors
                                            //                   .grey.shade600,
                                            //               size: 18,
                                            //             ),
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "https://www.instagram.com/michaeldadziie",
                                            //             style: TextStyle(
                                            //               fontStyle:
                                            //                   FontStyle.italic,
                                            //               color: Colors
                                            //                   .grey.shade600,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: Center(
                                                child: Text.rich(
                                                  TextSpan(
                                                    style: themeData
                                                        .textTheme.bodySmall!
                                                        .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    children: [
                                                      WidgetSpan(
                                                        child: Icon(
                                                          UniconsLine.link,
                                                          color: Colors
                                                              .grey.shade600,
                                                          size: 18,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: controller
                                                                .profileDataList[
                                                            "website"],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //////////////////////////////
                                            // Icon(
                                            //   UniconsLine.link,
                                            //   color: Colors.grey.shade600,
                                            // ),
                                            // Expanded(
                                            //   child: Text(
                                            //     controller
                                            //         .profileDataList["website"],
                                            //     style: themeData
                                            //         .textTheme.bodySmall!
                                            //         .copyWith(
                                            //       fontSize: 13,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.grey.shade600,
                                            //     ),
                                            //     textAlign: TextAlign.center,
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              height10,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      tabBarItem(
                                        label: dataStorage.read('username') ==
                                                widget.profileUsername
                                            ? "My Posts"
                                            : "Posts",
                                        index: 0,
                                      ),
                                      UIInterface.verticalDivider(),
                                      tabBarItem(
                                        label: "Liked",
                                        index: 1,
                                      ),
                                      // if (dataStorage.read('username') ==
                                      //     widget.profileUsername)
                                      //   UIInterface.verticalDivider(),
                                      // if (dataStorage.read('username') ==
                                      //     widget.profileUsername)
                                      //   tabBarItem(
                                      //     label: "Bookmarked",
                                      //     index: 2,
                                      //   ),
                                    ],
                                  ),
                                ),
                              ),
                              height20,
                              if (controller.tabIndex == 0 &&
                                  widget.profileUsername ==
                                      dataStorage.read('username') &&
                                  controller.videoList.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: CommonPostGridView(
                                    videosList: controller.videoList,
                                  ),
                                )
                              ],
                              if (controller.tabIndex == 0 &&
                                  widget.profileUsername !=
                                      dataStorage.read('username') &&
                                  controller.tempVideoList.isNotEmpty) ...[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 100),
                                  child: CommonPostGridView(
                                    videosList: controller.tempVideoList,
                                  ),
                                )
                              ],
                              if (controller.tabIndex == 0 &&
                                  controller.videoList.isEmpty &&
                                  widget.profileUsername ==
                                      dataStorage.read('username')) ...[
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 50, left: 40, right: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'You don\'t have any posts uploaded yet, click on the icon below to create your first post',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 14,
                                                color: grey,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        height15,
                                        InkWell(
                                          onTap: () {
                                            HapticFeedback.mediumImpact();
                                            Get.off(
                                              () => EditorScreen(
                                                fromHomeScreen: false,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: theme
                                                  ? fillGrey
                                                  : Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SvgPicture.asset(
                                              AppAsset.icadd,
                                              height: 22.5,
                                              width: 22.5,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                              if (controller.tabIndex == 0 &&
                                  controller.tempVideoList.isEmpty &&
                                  widget.profileUsername !=
                                      dataStorage.read('username')) ...[
                                Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Text(
                                    'This user hasn\'t uploaded any post yet',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 14,
                                          color: grey,
                                        ),
                                  ),
                                ),
                              ],
                              if (controller.tabIndex == 1 &&
                                  widget.profileUsername ==
                                      dataStorage.read('username') &&
                                  controller.likedVideoList.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 100,
                                  ),
                                  child: CommonPostGridView(
                                    videosList: controller.likedVideoList,
                                  ),
                                )
                              ],
                              if (controller.tabIndex == 1 &&
                                  widget.profileUsername ==
                                      dataStorage.read('username') &&
                                  controller.likedVideoList.isEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 100,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      height20,
                                      height20,
                                      height10,
                                      Center(
                                        child: Text(
                                          'You haven\'t liked any post yet',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 14,
                                                color: grey,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                              if (controller.tabIndex == 1 &&
                                  widget.profileUsername !=
                                      dataStorage.read('username')) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 100,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      height20,
                                      height20,
                                      height10,
                                      Center(
                                        child: Text(
                                          'This user\'s liked videos are private',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 14,
                                                color: grey,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.profileDataList["profile_picture_url"] != null)
                    Padding(
                      padding: EdgeInsets.only(top: 140, left: Get.width / 3),
                      child: UIInterface.profileImageWidget(
                        imgUrl:
                            controller.profileDataList["profile_picture_url"],
                        height: Get.height / 7,
                        width: Get.width / 3.5,
                        radius: 80,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // followers and following bar
  Widget followerBar(bool theme, username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: followerBarItem(
              ontap: () {
                // videothumnail();

                Get.to(() => FollowingScreen(
                      userName: username,
                    ))?.then((value) => {
                      // profileController.profileDataList =
                      //     profileController.tempProfileList,
                      // profileController.update,
                      // log(" ======> ${profileController.tempVideoList}"),
                      // profileController.videoList =
                      //     profileController.tempVideoList,
                      // profileController.update,
                      profileController.getProfileDetails(
                        context,
                        fromUser: widget.fromMainUser,
                        profileusername: widget.profileUsername,
                      )
                    });
              },
              numberCounter:
                  profileController.profileDataList["following_count"] != null
                      ? profileController.profileDataList["following_count"]
                          .toString()
                      : " ",
              label: "Following",
              theme: theme),
        ),
        Expanded(
          child: followerBarItem(
              ontap: () {
                Get.to(
                  () => FollowerScreen(userName: username),
                )?.then(
                  (value) => {
                    profileController.getProfileDetails(
                      context,
                      fromUser: widget.fromMainUser,
                      profileusername: widget.profileUsername,
                    )
                  },
                );
              },
              numberCounter:
                  profileController.profileDataList["follower_count"] != null
                      ? profileController.profileDataList["follower_count"]
                          .toString()
                      : " ",
              label: "Followers",
              theme: theme),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              // Get.to(() => WalletScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dataStorage.read("username") != widget.profileUsername
                    ? Text(
                        profileController.profileDataList["post_count"] != null
                            ? profileController.profileDataList["post_count"]
                                .toString()
                            : " ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        profileController.profileDataList["post_count"] != null
                            ? profileController.profileDataList["post_count"]
                                .toString()
                            : " ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                Text(
                  'Posts',
                  style: AppTextStyle.normalRegular14.copyWith(color: greyText),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  // followers bar Item
  Widget followerBarItem({ontap, numberCounter, label, bool? theme}) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            label: numberCounter,
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextWidget(
            label: label,
            textStyle: AppTextStyle.normalRegular14.copyWith(color: greyText),
          )
        ],
      ),
    );
  }

  /// tabbar Item
  Widget tabBarItem({label, index}) {
    return InkWell(
      onTap: () {
        profileController.onChangeIndex(
          index,
        );

        if (index == 1 &&
            (widget.profileUsername == dataStorage.read('username')))
          profileController.getLikeVideos(
              context, widget.fromMainUser, widget.profileUsername);
      },
      child: TextWidget(
        label: label,
        textStyle: AppTextStyle.normalSemiBold13.copyWith(
          color: profileController.tabIndex == index
              ? Theme.of(context).errorColor
              : grey,
          fontSize: 14,
        ),
      ),
    );
  }

  // Widget feedsGridView(theme) {
  //   return GridView.builder(
  //       itemCount: categories.length,
  //       shrinkWrap: true,
  //       padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
  //       physics: NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         mainAxisExtent: 280,
  //         crossAxisSpacing: 12,
  //         mainAxisSpacing: 12,
  //         crossAxisCount: 2,
  //       ),
  //       itemBuilder: (BuildContext context, int index) {
  //         return Container(
  //             decoration: BoxDecoration(
  //               color: theme == false ? lightGrey : tikTokGrey,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Text(categories[index].toString(),
  //                     style: AppTextStyle.normalSemiBold18.copyWith(
  //                         fontSize: 16,
  //                         color: theme == false ? primaryBlack : grey)),
  //                 feedsDetailsGridView(),
  //               ],
  //             ));
  //       });
  // }

  Widget feedsDetailsGridView() {
    return GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 70,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: whiteColor, width: 2),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        searchController.recentAccount[index]["image"]))),
            child: Text(
              searchController.recentAccount[index]["name"],
              style: const TextStyle(color: whiteColor),
            ),
          );
        });
  }
}

Widget SocialLink(BuildContext context,
    {required String link, required IconData icon}) {
  return GestureDetector(
    onTap: () {
      HapticFeedback.mediumImpact();
      launchUrl(
        Uri.parse(
          link,
        ),
        mode: LaunchMode.externalNonBrowserApplication,
      ).then((value) {
        // Get.back();
      });
      LaunchMode.externalApplication;
    },
    child: Container(
      height: 50,
      width: 50,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            size: 25,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(width: 1, color: secondaryGrey),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
