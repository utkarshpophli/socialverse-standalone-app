import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';

class EditProfileScreen extends StatefulWidget {
  final String? name;
  final String? lastname;
  final String? username;
  final String? bio;
  final String? profile;
  final String? tiktok;
  final String? youtube;
  final String? instagram;
  final String? website;
  const EditProfileScreen({
    Key? key,
    this.name,
    this.username,
    this.bio,
    this.lastname,
    this.tiktok,
    this.youtube,
    this.instagram,
    this.website,
    required this.profile,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController controller = Get.put(EditProfileController());

  XFile? progileImg;

  @override
  Widget build(BuildContext context) {
    log(controller.bioController.text.length.toString());
    bool theme = dataStorage
        .read("isDarkMode"); // Get.theme.brightness.obs == Brightness.dark.obs;

    return GetBuilder<EditProfileController>(
      initState: (state) {
        controller.firstNameController.text = widget.name ?? "";
        controller.userNameController.text = widget.username ?? "";
        controller.lastNameController.text = widget.lastname ?? "";
        controller.bioController.text = widget.bio ?? "";
        controller.youtubeUrlController.text =
            widget.youtube ?? "https://www.youtube.com/";
        controller.tiktokUrlController.text =
            widget.tiktok ?? "https://www.tiktok.com/";
        controller.instagramUrlController.text =
            widget.instagram ?? "https://www.instagram.com/";
        controller.websiteUrlController.text =
            widget.website ?? "https://www.google.com/";
      },
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height,
            decoration: UIInterface.backgroundTheme(),
            child: commonAppbar(
              onBackTap: () {
                Get.back(result: false);
              },
              context: context,
              title: "Edit Profile",
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                shrinkWrap: true,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        // ignore: unnecessary_null_comparison
                        controller.imagePath == ''
                            ? UIInterface.profileImageWidget(
                                imgUrl: widget.profile.toString(),
                                height: 100,
                                width: 100,
                                radius: 50)
                            : UIInterface.fileProfileImageWidget(
                                imgUrl: File(controller.imagePath),
                                height: 100,
                                width: 100,
                                radius: 50),
                        // Container(
                        //   height: 100,
                        //   width: 100,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     color: primaryBlack,
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //       fit: BoxFit.cover,
                        //       image: NetworkImage(profile.toString()),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 4,
                          right: -1,
                          child: InkWell(
                            onTap: () {
                              controller.getImage();
                              // final ImagePicker _picker = ImagePicker();
                              // // setState(() {
                              // progileImg = await _picker.pickImage(
                              //     source: ImageSource.gallery);
                              // // });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: primaryWhite, width: 1.2),
                                  color: purpleColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(7),
                                child: const Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: primaryWhite,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFiledtitleText("First name", theme),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.firstNameController,
                        hintText: 'First Name',
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        filledColor: Theme.of(context).backgroundColor,
                        theme: theme,
                        style: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : blackColor,
                        ),
                      ),
                      height10,
                      textFiledtitleText("Last name", theme),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.lastNameController,
                        hintText: 'Last Name',
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        theme: theme,
                        filledColor: Theme.of(context).backgroundColor,
                        style: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : blackColor,
                        ),
                      ),
                      height10,
                      textFiledtitleText("Username", theme),
                      height5,
                      GestureDetector(
                        onTap: () => controller.floatingScaffold(
                          context,
                          message: 'Username cannot be changed',
                          height: Platform.isIOS
                              ? Get.height * 0.08
                              : Get.height * 0.06,
                        ),
                        child: TextFormFieldWidget(
                          controller: controller.userNameController,
                          hintText: 'Username',
                          theme: theme,
                          hintStyle: AppTextStyle.normalRegular14.copyWith(
                            color: theme ? primaryWhite : grey.withOpacity(.8),
                          ),
                          enabled: false,
                          filledColor: Theme.of(context).backgroundColor,
                          style: AppTextStyle.normalRegular14.copyWith(
                            color: theme ? primaryWhite : grey.withOpacity(.8),
                          ),
                        ),
                      ),
                      height10,
                      Row(
                        children: [
                          textFiledtitleText("Bio", theme),
                          const Spacer(),
                          Text(
                            controller.bioController.text.length.toString() +
                                "/200",
                            style: AppTextStyle.normalRegular14.copyWith(
                                fontSize: 12,
                                color: theme
                                    ? primaryWhite
                                    : grey.withOpacity(.8)),
                          ),
                        ],
                      ),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.bioController,
                        hintText: 'Write something awesome...',
                        maxLines: 4,
                        maxLength: 200,
                        theme: theme,
                        onChanged: (text) {
                          controller.onTextChanged(text!);
                        },
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        filledColor: Theme.of(context).backgroundColor,
                        style: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : blackColor,
                        ),
                      ),
                      height10,
                      textFiledtitleText("Instagram", theme),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.instagramUrlController,
                        hintText: "http://instagram.com/...",
                        theme: theme,
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        filledColor: Theme.of(context).backgroundColor,
                        style: AppTextStyle.normalRegular14
                            .copyWith(color: theme ? primaryWhite : blackColor),
                      ),
                      height10,
                      textFiledtitleText("Youtube", theme),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.youtubeUrlController,
                        hintText: "http://youtube.com/...",
                        theme: theme,
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        filledColor: Theme.of(context).backgroundColor,
                        style: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : blackColor,
                        ),
                      ),
                      height10,
                      textFiledtitleText("Tiktok", theme),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.tiktokUrlController,
                        hintText: "http://tiktok.com/...",
                        theme: theme,
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        filledColor: Theme.of(context).backgroundColor,
                        style: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : blackColor,
                        ),
                      ),
                      height10,
                      textFiledtitleText("Website", theme),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.websiteUrlController,
                        hintText: "Website url..",
                        theme: theme,
                        hintStyle: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : grey.withOpacity(.8),
                        ),
                        filledColor: Theme.of(context).backgroundColor,
                        style: AppTextStyle.normalRegular14.copyWith(
                          color: theme ? primaryWhite : blackColor,
                        ),
                      ),
                      height20,
                      ImageTextButton(
                        title: 'Save',
                        onPressed: () {
                          controller.updateprofile(context);
                        },
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       // log(firstnamecontrroller.text);
                      //       // log(lastnamecontroller.text);
                      //       controller.updateprofile();
                      //     },
                      //     child: theme
                      //         ? darkappButton(text: "Save")
                      //         : appButton(text: "Save")),
                      height10,
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Text textFiledtitleText(text, bool theme) {
    return Text(
      text,
      style: AppTextStyle.normalRegular14
          .copyWith(color: theme ? primaryWhite : grey.withOpacity(.8)),
    );
  }
}
