import 'package:socialverse/export.dart';
import 'package:socialverse/feature/profile/controllers/manage_account_controller.dart';

class ManageMyAccountScreen extends StatelessWidget {
  final bool fromMainUser;
  final String? profileUsername;
  ManageMyAccountScreen(
      {required this.fromMainUser, this.profileUsername, Key? key})
      : super(key: key);
  final ManageAccountAcontroller controller =
      Get.put(ManageAccountAcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ManageAccountAcontroller>(initState: (state) {
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
            title: "Manage My Account",
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
                            "ACCOUNT INFORMATION",
                            style: themeData.textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          height10,
                          listTile(
                            imagePath: AppAsset.icuser,
                            text: "Edit Profile",
                            context: context,
                            themeData: themeData,
                            onTap: () => controller.goToEditProfile(
                              context,
                              fromMainUser,
                              dataStorage.read("username"),
                            ),
                          ),
                          Divider(
                            color: grey.withOpacity(0.3),
                            thickness: 1,
                          ),
                          // height5,
                          // Text(
                          //   "ACCOUNT CONTROL",
                          //   style: themeData.textTheme.bodySmall!.copyWith(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // height10,
                          // listTile(
                          //   imagePath: AppAsset.bin,
                          //   text: "Delete Account",
                          //   onTap: () {
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) => ErrorAlertDialog(
                          //         title: 'Delete Account',
                          //         action: 'Delete',
                          //         theme: theme,
                          //         content:
                          //             'They will not be able to see your profile, see your posts or find your profile. They\'ll not be notified that you blocked them.',
                          //         tap: () {},
                          //       ),
                          //     );
                          //   },
                          //   context: context,
                          //   themeData: themeData,
                          // ),
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
