import 'dart:developer';

import 'package:socialverse/export.dart';
import 'package:socialverse/feature/profile/views/settings/socialverse_code/socialverse_code.dart';
import 'package:socialverse/feature/profile/views/settings/manage_account/manage_my_account_screen.dart';

class SettingScreen extends StatelessWidget {
  final bool fromMainUser;
  final String? profileUsername;
  final String? name;
  SettingScreen(
      {required this.fromMainUser, this.profileUsername, this.name, Key? key})
      : super(key: key);
  final SettingController controller = Get.put(SettingController());
  final TextEditingController deleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingController>(initState: (state) {
        String userName = profileUsername.toString();
        controller.getPofileDetails(
          context,
          fromMainUser,
          userName,
        );
      }, builder: (controller) {
        ThemeData themeData = Theme.of(context);
        bool theme = dataStorage.read("isDarkMode");

        return Container(
          decoration: UIInterface.backgroundTheme(),
          child: commonAppbar(
            context: context,
            title: "Privacy and Settings",
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                      left: 10,
                      bottom: 5,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ACCOUNT",
                            style: themeData.textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          height10,
                          listTile(
                            imagePath: AppAsset.icuser,
                            text: "Manage my Account",
                            context: context,
                            themeData: themeData,
                            onTap: () {
                              Get.to(
                                () => ManageMyAccountScreen(
                                  fromMainUser: fromMainUser,
                                  profileUsername: dataStorage.read("username"),
                                ),
                              );
                            },
                          ),
                          listTile(
                            imagePath: AppAsset.icshareprofile,
                            text: "Share Profile",
                            onTap: () {
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
                                  return SharetoSheet(
                                    username:
                                        controller.profileDataList["username"],
                                    theme: theme,
                                  );
                                },
                              );
                            },
                            context: context,
                            themeData: themeData,
                          ),
                          listTile(
                            imagePath: AppAsset.icfliccode,
                            text: "QR Code",
                            onTap: () {
                              Get.to(
                                () => SocialVerseCodeScreen(
                                  name: name!,
                                  username: profileUsername!,
                                ),
                              );
                            },
                            context: context,
                            themeData: themeData,
                          ),
                          Divider(
                            color: grey.withOpacity(0.3),
                            thickness: 1,
                          ),
                          height5,
                          Text(
                            "GENERAL",
                            style: themeData.textTheme.bodySmall!.copyWith(
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
                          ListTile(
                            horizontalTitleGap: 0,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            leading: const Icon(
                              Icons.dark_mode_outlined,
                              color: grey,
                            ),
                            // leading: SvgPicture.asset(AppAsset.iccomment),
                            title: Text(
                              "Theme",
                              style: themeData.textTheme.bodySmall!
                                  .copyWith(fontSize: 15),
                            ),
                            trailing: SizedBox(
                              width: 50,
                              height: 25,
                              child: FlutterSwitch(
                                activeColor: appColor.withOpacity(0.3),
                                activeToggleColor: appColor,
                                value: dataStorage.read('isDarkMode'),
                                borderRadius: 30.0,
                                onToggle: (val) {
                                  if (dataStorage.read('isDarkMode')) {
                                    dataStorage.write('isDarkMode', false);

                                    Get.changeThemeMode(ThemeMode.light);
                                  } else {
                                    dataStorage.write('isDarkMode', true);

                                    Get.changeThemeMode(ThemeMode.dark);
                                  }
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                          listTile(
                            imagePath: AppAsset.iclogout,
                            text: "Log out",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => ErrorAlertDialog(
                                  title: 'Log Out',
                                  action: 'Log Out',
                                  theme: theme,
                                  content: 'Are you sure you want to log out?',
                                  tap: () {
                                    if (dataStorage.read('apple') == true) {
                                      log('apple');
                                      controller.logOutApple();
                                    } else if (dataStorage.read('google') ==
                                        true) {
                                      log('google');
                                      controller.logOutGoogle();
                                    } else {
                                      controller.logout(context);
                                    }
                                  },
                                ),
                              );
                            },
                            context: context,
                            themeData: themeData,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
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
}
