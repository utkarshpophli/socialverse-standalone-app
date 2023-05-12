import 'dart:io';
import 'dart:typed_data';
import 'package:socialverse/feature/profile/views/settings/socialverse_code/qr_code_scanner.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:socialverse/export.dart';
import 'package:screenshot/screenshot.dart';

class SocialVerseCodeScreen extends StatefulWidget {
  final String username;
  final String name;
  const SocialVerseCodeScreen({
    Key? key,
    required this.username,
    required this.name,
  }) : super(key: key);

  @override
  State<SocialVerseCodeScreen> createState() => _SocialVerseCodeScreenState();
}

class _SocialVerseCodeScreenState extends State<SocialVerseCodeScreen> {
  ScreenshotController _screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool theme = dataStorage.read("isDarkMode");
    bool error = false;
    return Scaffold(
      backgroundColor: purpleColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 115, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Screenshot(
                          controller: _screenshotController,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: whiteColor,
                            ),
                            height: 350,
                            width: Get.width - 70,
                            // color: purpleColor,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.username,
                                    style:
                                        themeData.textTheme.bodyLarge!.copyWith(
                                      fontSize: 18,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  height10,
                                  QrImage(
                                    data: 'https://beta.watchflic.com/@' +
                                        widget.username,
                                    version: QrVersions.auto,
                                    size: 200,
                                    gapless: false,
                                    foregroundColor: purpleColor,
                                    errorStateBuilder: (context, error) {
                                      setState(() {
                                        error = true;
                                      });
                                      return Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: whiteColor,
                                          border: Border.all(
                                            width: 1,
                                            color: purpleColor,
                                          ),
                                        ),
                                      );
                                    },
                                    embeddedImage:
                                        AssetImage(AppAsset.socialverselogo),
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: Size(120, 120),
                                      color: purpleColor,
                                    ),
                                  ),
                                  height10,
                                  Text(
                                    'Share your QR so others can follow you',
                                    style:
                                        themeData.textTheme.bodyLarge!.copyWith(
                                      fontSize: 12,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  height10,
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      AppAsset.socialverselogo,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  // bottom: 20,
                  // left: 20,
                  // right: 20,
                  top: 20,
                ),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: theme == true ? fillGrey : primaryWhite,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Share to',
                        style: themeData.textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                          color: Theme.of(context).errorColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      height10,
                      height10,
                      Container(
                        height: 80,
                        width: Get.width,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MoreItems(
                                  icon: Icons.download_outlined,
                                  name: 'Save',
                                  tap: error == true
                                      ? _floatingScaffold(
                                          context,
                                          message:
                                              'Uh oh! Something went wrong...Please try again later.',
                                        )
                                      : () {
                                          HapticFeedback.mediumImpact();
                                          _screenshotController
                                              .capture(
                                            delay: Duration(milliseconds: 10),
                                          )
                                              .then((capturedImage) async {
                                            _saved(capturedImage!);
                                            _floatingScaffold(
                                              context,
                                              message: 'Image saved on device',
                                            );
                                          }).catchError((onError) {
                                            print(onError);
                                          });
                                        },
                                ),
                                height5,
                                Divider(color: grey, thickness: 0.1),
                                MoreItems(
                                  icon: Icons.share_rounded,
                                  name: 'Share',
                                  tap: error == true
                                      ? _floatingScaffold(
                                          context,
                                          message:
                                              'Uh oh! Something went wrong...Please try again later.',
                                        )
                                      : () {
                                          HapticFeedback.mediumImpact();
                                          _screenshotController
                                              .capture(
                                                  delay: Duration(
                                                      milliseconds: 10))
                                              .then(
                                            (Uint8List? value) async {
                                              var dir;
                                              if (Platform.isAndroid) {
                                                dir =
                                                    await getApplicationDocumentsDirectory();
                                              } else {
                                                dir =
                                                    await getApplicationDocumentsDirectory();
                                              }
                                              File file = File(
                                                '${dir.path}/' +
                                                    widget.username +
                                                    '.png',
                                              );
                                              await file.writeAsBytes(value!);
                                              Share.shareFiles([
                                                file.path,
                                              ], text: 'SocialVerse QR Code');
                                              print(
                                                "File Saved to App Documentary",
                                              );
                                            },
                                          );
                                        },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: whiteColor,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => QRScanner(),
                      );
                    },
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        AppAsset.icfliccode,
                        color: whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _floatingScaffold(
    context, {
    required String message,
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
          bottom: Platform.isIOS ? Get.height * 0.16 : Get.height * 0.22,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  _saved(Uint8List image) async {
    await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }
}
