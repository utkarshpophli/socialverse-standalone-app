import 'dart:io';
// import 'package:show_more_text_popup/show_more_text_popup.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../export.dart';

class AuthBottomSheet extends StatelessWidget {
  const AuthBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeVideoController = Get.put(HomeCommonVideoPlayerController());
    ThemeData themeData = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Theme.of(context).primaryColor,
          ),
          // height: Get.height / 2.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              height15,
              Text(
                "Please Sign up To Continue",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              customHeight(40),
              ImageTextButton(
                title: 'About',
                onPressed: () {
                  homeVideoController
                      .videoController(
                          homeVideoController.currentVideoIndex.value)!
                      .pause();
                  showModalBottomSheet(
                    backgroundColor: Theme.of(context).primaryColor,
                    constraints: BoxConstraints(maxHeight: Get.height - 70),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Container(
                          width: Get.width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 20,
                              left: 20,
                              bottom: 0,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ABOUT",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  height10,
                                  ListTile(
                                    onTap: () {
                                      HapticFeedback.mediumImpact();
                                      Get.to(
                                        () => const ReportPage(
                                          link: 'https://discord.gg/N6qMSHscx5',
                                        ),
                                      );
                                    },
                                    horizontalTitleGap: 1,
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    leading: const Icon(
                                      Icons.discord,
                                      size: 25,
                                      color: grey,
                                    ),
                                    title: Text(
                                      'Join our discord server',
                                      style: themeData.textTheme.bodySmall!
                                          .copyWith(fontSize: 15),
                                    ),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_right_sharp,
                                      color: themeData.errorColor,
                                    ),
                                  ),
                                  listTile(
                                    imagePath: AppAsset.icprivacy,
                                    text: "Privacy Policy",
                                    onTap: () {
                                      Get.to(
                                        () => const ReportPage(
                                          link:
                                              'https://www.socialverseapp.com/privacy-policy',
                                        ),
                                      );
                                    },
                                    context: context,
                                    themeData: themeData,
                                  ),
                                  listTile(
                                    imagePath: AppAsset.icdigital,
                                    text: "Terms & Conditions",
                                    onTap: () {
                                      HapticFeedback.mediumImpact();
                                      Get.to(
                                        () => const ReportPage(
                                          link:
                                              'https://www.socialverseapp.com/terms-and-conditions',
                                        ),
                                      );
                                    },
                                    context: context,
                                    themeData: themeData,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              height15,
              ImageTextButton(
                title: 'Sign Up',
                onPressed: () {
                  homeVideoController.disposed(
                    homeVideoController.currentVideoIndex.value,
                  );
                  Get.offAll(
                    () => const SignUpScreen(),
                  );
                },
              ),
              height15,
              Divider(
                thickness: 1,
                color: grey.withOpacity(0.5),
              ),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextStyle.normalRegular17.copyWith(
                      color: hintGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      homeVideoController.disposed(
                        homeVideoController.currentVideoIndex.value,
                      );
                      Get.offAll(() => LoginScreen());
                    },
                    child: Text(
                      ' Sign in',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                    ),
                  )
                ],
              ),
              Platform.isAndroid ? SizedBox.shrink() : height20,
            ],
          ),
        ),
      ],
    );
  }
}

class ExitBottomSheet extends StatefulWidget {
  const ExitBottomSheet({Key? key}) : super(key: key);

  @override
  State<ExitBottomSheet> createState() => _ExitBottomSheetState();
}

class _ExitBottomSheetState extends State<ExitBottomSheet> {
  GlobalKey key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(15),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5),
                Text(
                  'I FEEL INSPIRED',
                  style: AppTextStyle.normalRegular16.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'This button means you were INSPIRED and you would like to EXIT THE APP, Are you sure you want to exit?',
                  style: AppTextStyle.normalRegular16.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).errorColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 1,
            right: 0,
            child: Tooltip(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(40),
              showDuration: Duration(seconds: 5),
              triggerMode: TooltipTriggerMode.tap,
              preferBelow: false,
              message:
                  'Using this button to exit the app allows us to collect information on the most empowering videos. This subverse uses an empowerment algorithm rather than an engagement algorithm which is why these data point s are so helpful for us!',
              child: Icon(
                Icons.info,
                color: Colors.grey.shade400,
              ),
            ),
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ImageTextButton(
                  title: 'Yes',
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                ),
              ),
              height20,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: PrimaryTextButton(
                  title: 'No',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  buttonColor: Theme.of(context).errorColor,
                  textColor: Theme.of(context).primaryColor,
                ),
              ),
              height10,
            ],
          ),
        )
      ],
    );
  }

  // void showMoreText(String text, BuildContext context, key) {
  //   ShowMoreTextPopup popup = ShowMoreTextPopup(
  //     context,
  //     text: 'text text text text text text text',
  //     textStyle: TextStyle(color: Colors.black),
  //     height: 200,
  //     width: 100,
  //     backgroundColor: Color(0xFF16CCCC),
  //     padding: EdgeInsets.all(4.0),
  //     borderRadius: BorderRadius.circular(10.0),
  //   );
  //   // show
  //   popup.show(widgetKey: key);
  // }
}

class MoreBottomSheet extends StatefulWidget {
  final bool isOwner;
  final bool? isFromVideoPlayer;
  final String slug;
  final String identifier;
  final String videoLink;
  // final Widget? sphere;
  final dynamic theme;
  final Rx<PageController> pageController;
  final RxInt currentIndex;
  final Function() onSaveVideoTap;
  // final Function() onPostDeleteTap;
  const MoreBottomSheet({
    Key? key,
    required this.isOwner,
    this.isFromVideoPlayer,
    required this.slug,
    required this.identifier,
    required this.videoLink,
    // this.sphere,
    this.theme,
    required this.pageController,
    required this.currentIndex,
    required this.onSaveVideoTap,
    // required this.onPostDeleteTap,
  }) : super(key: key);

  @override
  State<MoreBottomSheet> createState() => _MoreBottomSheetState();
}

class _MoreBottomSheetState extends State<MoreBottomSheet> {
  NetworkRepository networkRepository = NetworkRepository();

  List reportList = [
    "It's spam",
    "Nudity or sexual activity",
    "I just don't like it",
    "Hate speech or symbols",
    "Violence or dangerous organizations",
    "Bullying or harassment",
    "False information",
    "Scam or fraud",
    "Suicide or self-injury",
    "Sale of illegal or regulated goods",
    "Intellectual property violation",
    "Something else"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: widget.theme == true ? fillGrey : primaryWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // widget.sphere!,
          MoreItems(
            icon: Icons.download_outlined,
            name: 'Save Video',
            tap: widget.onSaveVideoTap,
          ),
          // height5,
          widget.isOwner == false
              ? const SizedBox()
              : const Divider(color: grey, thickness: 0.1),
          widget.isOwner == false ? const SizedBox() : height5,
          widget.isOwner == false
              ? const SizedBox()
              : MoreItems(
                  icon: Icons.flag_outlined,
                  name: 'Report',
                  tap: () {
                    Get.back();
                    showModalBottomSheet(
                      constraints: BoxConstraints(maxHeight: Get.height - 50),
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 1,
                          child: ReportSheet(
                            theme: widget.theme,
                            reportList: reportList,
                            pageController: widget.pageController,
                            currentIndex: widget.currentIndex,
                          ),
                        );
                      },
                    );
                  },
                ),
          height5,
          // widget.isowner == true
          //     ? SizedBox()
          //     : Divider(color: grey, thickness: 0.1),
          // widget.isowner == true ? SizedBox() : height5,
          // widget.isowner == true
          //     ? SizedBox()
          //     : MoreItems(
          //         icon: Icons.delete_outlined,
          //         name: 'Delete Post',
          //         tap: widget.onPostDeleteTap,
          //       ),
          // widget.isowner == true ? SizedBox() : height5,
          const Divider(color: grey, thickness: 0.1),
          height5,
          SizedBox(
            height: 60,
            width: Get.width,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SendToOptions(
                      title: 'Email',
                      color: purpleColor,
                      icon: Icons.email_outlined,
                      tap: () async {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri(
                            scheme: 'mailto',
                            queryParameters: {
                              'subject':
                                  'Join SocialVerse and see what SocialVerse users have been up to!',
                              'body': widget.videoLink,
                            },
                          ),
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'SMS',
                      color: Colors.green,
                      icon: Icons.sms_outlined,
                      tap: () async {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri(
                            scheme: 'sms',
                            queryParameters: {
                              'subject': '',
                              'body':
                                  'Join SocialVerse and see what SocialVerse users have been up to!\n\n' +
                                      widget.videoLink
                            },
                          ),
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'Copy link',
                      color: Colors.yellow,
                      icon: Icons.link_outlined,
                      tap: () {
                        Get.back();
                        Clipboard.setData(
                          ClipboardData(text: widget.videoLink),
                        ).then((_) {
                          _floatingScaffold(
                            context,
                            message: 'Link Copied',
                            height: Platform.isIOS
                                ? Get.height * 0.085
                                : Get.height * 0.125,
                          );
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'WhatsApp',
                      color: Colors.green.shade700,
                      icon: Icons.wechat,
                      tap: () {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri.parse(
                            'https://wa.me/?text=Join SocialVerse and see what SocialVerse users have been up to!\n\n' +
                                widget.videoLink,
                          ),
                          mode: LaunchMode.externalNonBrowserApplication,
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'Telegram',
                      color: Colors.blue.shade700,
                      icon: Icons.telegram,
                      tap: () {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri.parse(
                            'https://telegram.me/share/url?url=' +
                                widget.videoLink +
                                '&text=Join SocialVerse and see what SocialVerse users have been up to!',
                          ),
                          mode: LaunchMode.externalNonBrowserApplication,
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'More',
                      color: Colors.red,
                      icon: Icons.more_vert,
                      tap: () {
                        HapticFeedback.mediumImpact();
                        Share.share(
                          widget.videoLink,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserMoreBottomSheet extends StatefulWidget {
  final String username;
  final dynamic theme;
  const UserMoreBottomSheet({
    Key? key,
    required this.username,
    this.theme,
  }) : super(key: key);

  @override
  State<UserMoreBottomSheet> createState() => _UserMoreBottomSheet();
}

class _UserMoreBottomSheet extends State<UserMoreBottomSheet> {
  NetworkRepository networkRepository = NetworkRepository();

  @override
  Widget build(BuildContext context) {
    bool theme = dataStorage.read("isDarkMode");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: widget.theme == true ? fillGrey : primaryWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoreItems(
            icon: Icons.block,
            name: 'Block',
            tap: () {
              Get.back();
              showDialog(
                context: context,
                builder: (context) => ErrorAlertDialog(
                  title: 'Block' + ' ' + widget.username + '?',
                  action: 'Block',
                  theme: theme,
                  content:
                      'They will not be able to see your profile, see your posts or find your profile. They\'ll not be notified that you blocked them.',
                  tap: () {
                    Get.back();
                    Get.back();
                    Fluttertoast.showToast(
                      msg: "User has been blocked",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: purpleColor,
                      textColor: primaryWhite,
                      fontSize: 16.0,
                    );
                  },
                ),
              );
            },
          ),
          height5,
          const Divider(color: grey, thickness: 0.1),
          height5,
          MoreItems(
            icon: Icons.flag_outlined,
            name: 'Report',
            tap: () {
              Get.back();
              showModalBottomSheet(
                constraints: BoxConstraints(maxHeight: Get.height - 50),
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 1,
                    child: ReportUserOptionsSheet(
                      theme: widget.theme,
                    ),
                  );
                },
              );
            },
          ),
          height5,
          const Divider(color: grey, thickness: 0.1),
          height5,
          Container(
            height: 60,
            width: Get.width,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SendToOptions(
                      title: 'Email',
                      color: purpleColor,
                      icon: Icons.email_outlined,
                      tap: () async {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri(
                            scheme: 'mailto',
                            path: '',
                            queryParameters: {
                              'subject':
                                  'Join SocialVerse and see what SocialVerse users have been up to!',
                              'body': 'https://beta.watchflic.com/@' +
                                  widget.username
                            },
                          ),
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'SMS',
                      color: Colors.green,
                      icon: Icons.sms_outlined,
                      tap: () async {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri(
                            scheme: 'sms',
                            queryParameters: {
                              'subject': '',
                              'body':
                                  'Join SocialVerse and see what SocialVerse users have been up to!\n\n' +
                                      'https://beta.watchflic.com/@' +
                                      widget.username
                            },
                          ),
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'Copy link',
                      color: Colors.yellow,
                      icon: Icons.link_outlined,
                      tap: () {
                        Get.back();
                        Clipboard.setData(
                          ClipboardData(
                            text: 'https://beta.watchflic.com/@' +
                                widget.username,
                          ),
                        ).then((_) {
                          _floatingScaffold(context,
                              message: 'Link copied',
                              height: Platform.isIOS
                                  ? Get.height * 0.08
                                  : Get.height * 0.04);
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'WhatsApp',
                      color: Colors.green.shade700,
                      icon: Icons.wechat,
                      tap: () {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri.parse(
                            'https://wa.me/?text=Join SocialVerse and see what SocialVerse users have been up to!\n\n' +
                                'https://beta.watchflic.com/@' +
                                widget.username,
                          ),
                          mode: LaunchMode.externalNonBrowserApplication,
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'Telegram',
                      color: Colors.blue.shade700,
                      icon: Icons.telegram,
                      tap: () {
                        HapticFeedback.mediumImpact();
                        launchUrl(
                          Uri.parse(
                            'https://telegram.me/share/url?url=https://beta.watchflic.com/@' +
                                widget.username +
                                '&text=Join SocialVerse and see what SocialVerse users have been up to!',
                          ),
                          mode: LaunchMode.externalNonBrowserApplication,
                        ).then((value) {
                          // Get.back();
                        });
                      },
                    ),
                    width20,
                    SendToOptions(
                      title: 'More',
                      color: Colors.red,
                      icon: Icons.more_vert,
                      tap: () {
                        HapticFeedback.mediumImpact();
                        Share.share(
                          'https://beta.watchflic.com/@' + widget.username,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SphereMoreBottomSheet extends StatelessWidget {
  final dynamic theme;
  final void Function() onEditTap;
  const SphereMoreBottomSheet({
    Key? key,
    required this.onEditTap,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool theme = dataStorage.read("isDarkMode");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: theme == true ? fillGrey : primaryWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoreItems(
            icon: Icons.edit_outlined,
            name: 'Edit sphere',
            tap: onEditTap,
          ),
          height5,
          const Divider(color: grey, thickness: 0.1),
          height5,
          MoreItems(
            icon: Icons.flag_outlined,
            name: 'Report',
            tap: () {},
          ),
          height5,
        ],
      ),
    );
  }
}

class SharetoSheet extends StatefulWidget {
  final String username;
  final dynamic theme;
  const SharetoSheet({
    Key? key,
    required this.username,
    this.theme,
  }) : super(key: key);

  @override
  State<SharetoSheet> createState() => _SharetoSheet();
}

class _SharetoSheet extends State<SharetoSheet> {
  NetworkRepository networkRepository = NetworkRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: widget.theme == true ? fillGrey : primaryWhite,
      ),
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Share to',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 15,
                    color: Theme.of(context).errorColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            height10,
            height10,
            Container(
              height: 60,
              width: Get.width,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SendToOptions(
                        title: 'Email',
                        color: purpleColor,
                        icon: Icons.email_outlined,
                        tap: () async {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri(
                              scheme: 'mailto',
                              path: '',
                              queryParameters: {
                                'subject':
                                    'Join SocialVerse and see what SocialVerse users have been up to!',
                                'body': 'https://beta.watchflic.com/@' +
                                    widget.username
                              },
                            ),
                          ).then((value) {
                            // Get.back();
                          });
                        },
                      ),
                      width20,
                      SendToOptions(
                        title: 'SMS',
                        color: Colors.green,
                        icon: Icons.sms_outlined,
                        tap: () async {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri(
                              scheme: 'sms',
                              queryParameters: {
                                'subject': '',
                                'body':
                                    'Join SocialVerse and see what SocialVerse users have been up to!\n\n' +
                                        'https://beta.watchflic.com/@' +
                                        widget.username
                              },
                            ),
                          ).then((value) {
                            // Get.back();
                          });
                        },
                      ),
                      width20,
                      SendToOptions(
                        title: 'Copy link',
                        color: Colors.yellow,
                        icon: Icons.link_outlined,
                        tap: () {
                          Get.back();
                          Clipboard.setData(
                            ClipboardData(
                              text: 'https://beta.watchflic.com/@' +
                                  widget.username,
                            ),
                          ).then((_) {
                            _floatingScaffold(
                              context,
                              message: 'Link copied',
                              height: Platform.isIOS
                                  ? Get.height * 0.75
                                  : Get.height * 0.78,
                            );
                          });
                        },
                      ),
                      width20,
                      SendToOptions(
                        title: 'WhatsApp',
                        color: Colors.green.shade700,
                        icon: Icons.wechat,
                        tap: () {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri.parse(
                              'https://wa.me/?text=Join SocialVerse and see what SocialVerse users have been up to!\n\n' +
                                  'https://beta.watchflic.com/@' +
                                  widget.username,
                            ),
                            mode: LaunchMode.externalNonBrowserApplication,
                          ).then((value) {
                            // Get.back();
                          });
                        },
                      ),
                      width20,
                      SendToOptions(
                        title: 'Telegram',
                        color: Colors.blue.shade700,
                        icon: Icons.telegram,
                        tap: () {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri.parse(
                              'https://telegram.me/share/url?url=https://beta.watchflic.com/@' +
                                  widget.username +
                                  '&text=Join SocialVerse and see what SocialVerse users have been up to!',
                            ),
                            mode: LaunchMode.externalNonBrowserApplication,
                          ).then((value) {
                            // Get.back();
                          });
                        },
                      ),
                      width20,
                      SendToOptions(
                        title: 'More',
                        color: Colors.red,
                        icon: Icons.more_vert,
                        tap: () {
                          HapticFeedback.mediumImpact();
                          Share.share(
                            'https://beta.watchflic.com/@' + widget.username,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SendToOptions extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function() tap;
  final String title;
  const SendToOptions({
    Key? key,
    required this.color,
    required this.icon,
    required this.tap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: Center(
              child: Icon(
                icon,
                color: whiteColor,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}

class MoreItems extends StatelessWidget {
  final Function() tap;
  final String name;
  final IconData icon;
  const MoreItems({
    Key? key,
    required this.tap,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).errorColor,
            size: 18,
          ),
          width05,
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                ),
          ),
        ],
      ),
    );
  }
}

class ReportSheet extends StatefulWidget {
  final dynamic theme;
  final List reportList;
  final Rx<PageController> pageController;
  final RxInt currentIndex;
  const ReportSheet(
      {Key? key,
      this.theme,
      required this.reportList,
      required this.pageController,
      required this.currentIndex})
      : super(key: key);

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  NetworkRepository networkRepository = NetworkRepository();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: widget.theme == true ? fillGrey : primaryWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Report",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 20,
                  ),
            ),
          ),
          height5,
          Divider(
            color: grey.withOpacity(0.5),
          ),
          height5,
          Text(
            'Select a reason',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, color: grey),
          ),
          height5,
          Expanded(
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.reportList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    Get.back();
                    Fluttertoast.showToast(
                      msg: "Thanks For reporting",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: purpleColor,
                      textColor: primaryWhite,
                      fontSize: 16.0,
                    );
                    int newChangeIndex = widget.currentIndex.value + 1;
                    await widget.pageController.value.animateToPage(
                        newChangeIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {});
                    // Get.to(
                    //   () => ReportPage(link: 'https://www.socialverseapp.com/contact-us'),
                    // );
                    HapticFeedback.mediumImpact();
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    title: Text(
                      widget.reportList[index],
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReportUserOptionsSheet extends StatefulWidget {
  final dynamic theme;
  const ReportUserOptionsSheet({
    Key? key,
    this.theme,
  }) : super(key: key);

  @override
  State<ReportUserOptionsSheet> createState() => _ReportUserOptionsSheetState();
}

class _ReportUserOptionsSheetState extends State<ReportUserOptionsSheet> {
  NetworkRepository networkRepository = NetworkRepository();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: widget.theme == true ? fillGrey : primaryWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Report",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 20,
                  ),
            ),
          ),
          height5,
          Divider(
            color: grey.withOpacity(0.5),
          ),
          height5,
          Text(
            'Select a reason',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, color: grey),
          ),
          height5,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(maxHeight: Get.height - 50),
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 1,
                          child: ReportUserSheet(
                            theme: widget.theme,
                          ),
                        );
                      },
                    );
                    HapticFeedback.mediumImpact();
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    title: Text(
                      'Report Account',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Get.to(
                      () => const ReportPage(
                          link:
                              'https://www.socialverseapp.com/report-content'),
                    );
                    HapticFeedback.mediumImpact();
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    title: Text(
                      'Report Content',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReportUserSheet extends StatefulWidget {
  final dynamic theme;
  const ReportUserSheet({
    Key? key,
    this.theme,
  }) : super(key: key);

  @override
  State<ReportUserSheet> createState() => _ReportUserSheetState();
}

class _ReportUserSheetState extends State<ReportUserSheet> {
  NetworkRepository networkRepository = NetworkRepository();
  @override
  Widget build(BuildContext context) {
    List reportList = [
      "Pretending to be someone",
      "Intellectual property infrigement",
      "Posting inappropriate content",
      "User could be under 12 years old",
      "Inappropriate profile info",
      "Other"
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: widget.theme == true ? fillGrey : primaryWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Report",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 20,
                  ),
            ),
          ),
          height5,
          Divider(
            color: grey.withOpacity(0.5),
          ),
          height5,
          Text(
            'Select a reason',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, color: grey),
          ),
          height5,
          Expanded(
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reportList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    HapticFeedback.mediumImpact();
                    Get.back();
                    Get.back();
                    Get.back();
                    Fluttertoast.showToast(
                      msg: "Your report has been sent",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: purpleColor,
                      textColor: primaryWhite,
                      fontSize: 16.0,
                    );
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    title: Text(
                      reportList[index],
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

_floatingScaffold(
  context, {
  required String message,
  required double height,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.grey.shade900,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 15, color: whiteColor),
      ),
      margin: EdgeInsets.only(
        bottom: height,
        right: 20,
        left: 20,
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Widget listTile({
  required String imagePath,
  required String text,
  void Function()? onTap,
  color,
  context,
  ThemeData? themeData,
}) {
  return ListTile(
    onTap: onTap,
    horizontalTitleGap: 1,
    contentPadding: const EdgeInsets.symmetric(vertical: 0),
    leading: SvgPicture.asset(
      imagePath,
      height: 22,
      width: 22,
      color: color ?? grey,
    ),
    title: Text(
      text,
      style: themeData!.textTheme.bodySmall!.copyWith(fontSize: 15),
    ),
    trailing: InkWell(
      onTap: () {},
      child: Icon(
        Icons.keyboard_arrow_right_sharp,
        color: themeData.errorColor,
      ),
    ),
  );
}
