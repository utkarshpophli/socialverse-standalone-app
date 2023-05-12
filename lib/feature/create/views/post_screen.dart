import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';
import 'select_sphere_screen.dart';

// ignore: must_be_immutable
class PostScreen extends StatefulWidget {
  final XFile? videolist;
  const PostScreen({Key? key, this.videolist}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final postController = Get.put(PostController());
  final editorController = Get.put(EditorController());
  final homeController = Get.put(HomeController());
  final mainController = Get.put(MainHomeScreenController());
  String? _selectedSphere;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<PostController>(
        initState: (state) {
          editorController.getUploadToken();
          postController.selectedSphere = '2';
          log('selected sphere: ${postController.selectedSphere}');
          postController.videoPlayerController = VideoPlayerController.file(
            File(widget.videolist!.path),
          )..initialize().then((_) {
              postController.update();
            });
          postController.focusNode.addListener(
            () {
              postController.update();
            },
          );
        },
        builder: (controller) {
          bool theme = dataStorage.read(
              "isDarkMode"); // Get.theme.brightness.obs == Brightness.dark.obs;
          // log(theme.toString());
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: Container(
              decoration: UIInterface.backgroundTheme(),
              child: commonAppbar(
                  context: context,
                  title: "Post",
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Form(
                                key: controller.formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        height: Get.height / 5,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width / 1.6,
                                              child: SearchBar(
                                                controller:
                                                    controller.titleController,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                darkTheme: theme,
                                                otherScreen: true,
                                                hintText: "Describe your video",
                                                maxLines: 7,
                                              ),
                                            ),
                                            width05,
                                            Expanded(
                                              child: Container(
                                                height: Get.height / 5.25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .errorColor)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: VideoPlayer(
                                                    controller
                                                        .videoPlayerController!,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height15,
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   PageRouteBuilder(
                                          //     transitionDuration:
                                          //         const Duration(seconds: 1),
                                          //     pageBuilder: (_, __, ___) =>
                                          //         SelectSphere(),
                                          //   ),
                                          // ).then(
                                          //   (value) => setState(() {}),
                                          // );
                                        },
                                        child: CommonListTile(
                                          horizontalTitleGap: 5,
                                          imagePath: AppAsset.sphereLogo,
                                          text: 'Add to Sphere',
                                          height: 30,
                                          width: 30,
                                          theme: theme,
                                          trailing: Hero(
                                            tag: "Sphere",
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          AppAsset.apptheme),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                controller.categoryController
                                                        .text.isEmpty
                                                    ? 'WhitePill'
                                                    : controller
                                                        .categoryController
                                                        .text,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: primaryWhite,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: Platform.isIOS
                              ? Get.height * 0.065
                              : Get.height * 0.04,
                          left: 20,
                          right: 20,
                        ),
                        child: ImageTextButton(
                          title: 'Post',
                          onPressed: postController.titleController.text.isEmpty
                              ? () {
                                  postController.floatingScaffold(
                                    context,
                                    message: 'Please enter post description',
                                  );
                                }
                              : () async {
                                  // Get.back();
                                  // Get.back();
                                  Get.offAll(
                                    MainHomeScreen(
                                      editorController: editorController,
                                    ),
                                  );
                                  // homeController.feedPostList.clear();
                                  // homeController.getFeedList();
                                  mainController.pageIndex.value = 0;
                                  editorController.uploadvideo(
                                    context,
                                    editorController.recordedVideo!.path,
                                  );
                                },
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget share(icon) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.2,
          color: grey.withOpacity(0.6),
        ),
      ),
      child: SvgPicture.asset(
        icon,
      ),
    );
  }

  Widget sphere(bool theme) {
    List data = postController.categoriesList;
    return DropdownButton(
      hint: Text(
        _selectedSphere ?? postController.categoriesList[0]['name'],
      ),
      dropdownColor: Theme.of(context).primaryColor,
      style: AppTextStyle.normalSemiBold13 //15
          .copyWith(
        color: theme == true ? primaryWhite : commonText,
        fontSize: 15,
      ),
      value: _selectedSphere,
      onChanged: (dynamic value) {
        setState(() {
          _selectedSphere = value;
          postController.selectedSphere = value;
          log(
            'Selected sphere: ' +
                value +
                ' ' +
                _selectedSphere! +
                ' ' +
                postController.selectedSphere!,
          );
        });
      },
      items: data.map((items) {
        return DropdownMenuItem(
          value: items['id'].toString(),
          child: Text(
            items['name'],
            style: AppTextStyle.normalSemiBold13 //15
                .copyWith(
              color: theme == true ? primaryWhite : commonText,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
    );
  }
}
