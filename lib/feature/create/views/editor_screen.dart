import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// ignore: must_be_immutable
class EditorScreen extends StatefulWidget {
  bool fromHomeScreen;
  EditorScreen({Key? key, required this.fromHomeScreen}) : super(key: key);

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final editorController = Get.put(EditorController());
  final mainController = Get.put(MainHomeScreenController());
  final homeVideoController = Get.put(HomeCommonVideoPlayerController());

  List<AssetEntity> assets = <AssetEntity>[];
  // @override
  // void initState() {
  //   editorController.callInit(context  );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(
      dispose: (state) {
        if (editorController.clickTimer != null) {
          editorController.clickTimer!.cancel();
        }
        editorController.cameraController!.dispose();
      },
      initState: (state) {
        // editorController.callInit();
        if (homeVideoController
                .videoController(homeVideoController.currentVideoIndex.value)!
                .value
                .isPlaying ==
            true) {
          homeVideoController.isPlaying.value = false;
          homeVideoController
              .videoController(homeVideoController.currentVideoIndex.value)
              ?.pause();
        }
      },
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: primaryBlack,
              body: controller.cameraController != null &&
                      controller.cameraController!.value.isInitialized
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            controller.editorVideoPlayerController == null
                                ? Container(
                                    height: controller
                                                .editorVideoPlayerController ==
                                            null
                                        ? Get.height / 1.3
                                        : Get.height,
                                    width: Get.width,
                                    child: GestureDetector(
                                      onVerticalDragStart: (d) async {
                                        await imagepic(controller);
                                      },
                                      onTap: () {
                                        log("ontap");
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CameraPreview(
                                          controller.cameraController!,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: Get.height / 1.09,
                                    child: Center(
                                      child: AspectRatio(
                                        aspectRatio: controller
                                            .editorVideoPlayerController!
                                            .value
                                            .aspectRatio,
                                        child: VideoPlayer(
                                          controller
                                              .editorVideoPlayerController!,
                                        ),
                                      ),
                                    ),
                                  ),
                            recordWidget(controller),
                            if (controller.isVideoRecord == false)
                              Positioned(
                                top: Platform.isIOS ? 45 : 35,
                                left: 15,
                                child: GestureDetector(
                                  onTap: () {
                                    if (controller.recordedVideo == null) {
                                      // controller.cameraController!.dispose();
                                      // mainController.pageIndex.value = 1;
                                      Get.offAll(() => MainHomeScreen());
                                      // if (widget.fromHomeScreen == true) {
                                      //   Get.offAll(() => MainHomeScreen());
                                      // } else {
                                      //   mainController.pageIndex.value = 0;
                                      //   Get.offAll(() => MainHomeScreen());
                                      // }
                                    } else {
                                      controller.editorVideoPlayerController!
                                          .dispose();
                                      controller.resetValues();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: whiteColor.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      controller.recordedVideo == null
                                          ? Icons.arrow_back_ios_new_outlined
                                          : Icons.close,
                                      size: 16,
                                      color: primaryWhite,
                                    ),
                                  ),
                                ),
                              ),
                            //   Container(
                            //     margin: const EdgeInsets.only(left: 20),
                            //     decoration: BoxDecoration(
                            //       color: primaryWhite.withOpacity(.2),
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //     child: IconButton(
                            //       constraints: const BoxConstraints(),
                            //       onPressed: () {
                            //         if (controller.recordedVideo == null) {
                            //           controller.cameraController!
                            //               .dispose();
                            //           widget.fromHomeScreen == true
                            //               ? Get.offAll(
                            //                   () => MainHomeScreen(),
                            //                 )
                            //               : Get.back();
                            //         } else {
                            //           controller
                            //               .editorVideoPlayerController!
                            //               .dispose();
                            //           controller.resetValues();
                            //         }
                            //       },
                            //       icon: Icon(
                            //         controller.recordedVideo == null
                            //             ? Icons.arrow_back_ios_new
                            //             : Icons.close,
                            //         size: 16,
                            //       ),
                            //       color: primaryWhite,
                            //     ),
                            //   ),
                            // ),
                            if ((controller.isRecordStart == true &&
                                controller.recordedVideo == null))
                              Positioned(
                                top: Platform.isIOS ? 45 : 35,
                                right: 10,
                                child: Column(
                                  children: [
                                    menuItem(
                                      label: "Flip",
                                      ontap: () {
                                        availableCameras().then((value) {
                                          controller.cameraValue = value;
                                        }).then(
                                          (value) {
                                            controller.cameraController =
                                                CameraController(
                                              controller.cameraValue[
                                                  controller.isCameraFlip
                                                      ? 1
                                                      : 0],
                                              ResolutionPreset.max,
                                            );

                                            controller.cameraController!
                                                .initialize()
                                                .then((_) {
                                              // controller.cameraController!
                                              //     .setZoomLevel(1.0);
                                              // controller.cameraController!
                                              //     .setExposurePoint(Offset.zero);
                                              controller.update();
                                            });
                                          },
                                        );
                                        controller.isCameraFlip =
                                            !controller.isCameraFlip;
                                        controller.update();
                                      },
                                      icon: AppAsset.icflip,
                                    ),
                                    height10,
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryWhite.withOpacity(0.10),
                                      ),
                                      child: PopupMenuButton<int>(
                                        color: primaryWhite,
                                        icon: SvgPicture.asset(
                                          AppAsset.icspeed,
                                          height: 25,
                                        ),
                                        onSelected: (value) async {
                                          if (value == 1) {
                                            controller.videoSpeed = 0.5;
                                            controller.update();
                                          }
                                          if (value == 2) {
                                            controller.videoSpeed = 1.0;
                                            controller.update();
                                          }
                                          if (value == 3) {
                                            controller.videoSpeed = 10.0;
                                            controller.update();
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: Text(
                                              "0.5",
                                              style: AppTextStyle.normalBold14
                                                  .copyWith(
                                                      color: primaryBlack),
                                            ),
                                            value: 1,
                                            height: 30,
                                          ),
                                          PopupMenuDivider(),
                                          PopupMenuItem(
                                            child: Text(
                                              "1",
                                              style: AppTextStyle.normalBold14
                                                  .copyWith(
                                                      color: primaryBlack),
                                            ),
                                            height: 30,
                                            value: 2,
                                          ),
                                          PopupMenuDivider(),
                                          PopupMenuItem(
                                            child: Text(
                                              "10",
                                              style: AppTextStyle.normalBold14
                                                  .copyWith(
                                                      color: primaryBlack),
                                            ),
                                            height: 30,
                                            value: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                    height5,
                                    Text(
                                      "Speed",
                                      style: AppTextStyle.normalBold14
                                          .copyWith(color: primaryWhite),
                                    ),
                                    height10,
                                    menuItem(
                                      icon: AppAsset.ictimer,
                                      label: "Timer",
                                      ontap: () {
                                        controller.isTimerOn =
                                            !controller.isTimerOn;

                                        controller.update();
                                        // startTimerbutton();
                                      },
                                    ),
                                    height10,
                                    menuItem(
                                      icon: editorController.isCameraFlashOn ==
                                              false
                                          ? AppAsset.icflash
                                          : AppAsset.icflash2,
                                      label: "Flash",
                                      ontap: () {
                                        controller.isCameraFlashOn =
                                            !controller.isCameraFlashOn;
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (controller.isTimercount == true)
                              Positioned(
                                top: Get.height / 2,
                                left: Get.width / 2,
                                child: Text(
                                  controller.timervalue.value != 3
                                      ? (3 - controller.timervalue.value)
                                          .toString()
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: primaryWhite,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (controller.editorVideoPlayerController == null)
                          height25,
                        if (controller.editorVideoPlayerController == null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await imagepic(controller);
                                    },
                                    child: SvgPicture.asset(
                                      AppAsset.icupload,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: purpleColor,
                      ),
                    )),
        );
      },
    );
  }

  Future<void> imagepic(controller) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: RequestType.video,
        maxAssets: 1,
        selectedAssets: assets,
      ),
    ).then((value) async {
      await value![0].originFile.then((value) {
        controller.recordedVideo = XFile(value!.path);
        controller.videoinit();
        controller.startTimer();
        controller.cameraController!.buildPreview();
        controller.update();
      });
      return null;
    });
  }

  Widget menuItem({ontap, label, icon, index}) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: label == 'Timer'
                  ? editorController.isTimerOn == true
                      ? primaryBlack.withOpacity(0.50)
                      : primaryWhite.withOpacity(0.10)
                  : label == 'Flash'
                      ? editorController.isCameraFlashOn == true
                          ? primaryBlack.withOpacity(0.50)
                          : primaryWhite.withOpacity(0.10)
                      : primaryWhite.withOpacity(0.10),
            ),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              icon,
              height: 25,
            ),
          ),
        ),
        height5,
        Text(
          label,
          style: AppTextStyle.normalBold14.copyWith(color: primaryWhite),
        ),
      ],
    );
  }

  Widget recordWidget(EditorController controller) {
    return Positioned(
      bottom: 20,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
          ),
          controller.editorVideoPlayerController == null
              ? Obx(
                  () => CircularPercentIndicator(
                    radius: controller.percentIndicatorRadius,
                    lineWidth: 5.0,
                    percent:
                        (controller.recordPercentageValue.value * 3.33) / 100,
                    progressColor: appColor,
                    animation: true,
                    addAutomaticKeepAlive: true,
                    animationDuration: 1000,
                    animateFromLastPercent: true,
                    center: GestureDetector(
                      onTap: () async {
                        if (controller.isTimerOn == true) {
                          if (controller.isFirstClick == false) {
                            controller.isRecordStart =
                                !controller.isRecordStart;
                            controller.isTimercount = !controller.isTimercount;
                            controller.isVideoRecord =
                                !controller.isVideoRecord;
                            controller.startTimerbutton();
                            controller.isFirstClick = !controller.isFirstClick;
                            controller.update();
                          } else {
                            controller.isVideoPause = !controller.isVideoPause;
                            controller.isVideoRecord =
                                !controller.isVideoRecord;
                            controller.isTimerSelected = true;
                            if (controller.isCameraFlashOn == true) {
                              controller.cameraController!.setFlashMode(
                                FlashMode.off,
                              );
                            }

                            controller.recordedVideo = await controller
                                .cameraController!
                                .stopVideoRecording();
                            controller.videoinit();
                            controller.startTimer();
                            controller.cameraController!.buildPreview();
                            controller.update();
                          }
                        }
                      },
                      onLongPress: () async {
                        if (controller.isTimerOn == false) {
                          controller.buttonPressSize = 70;
                          controller.percentIndicatorRadius = 50;
                          controller.isRecordStart = !controller.isRecordStart;
                          controller.isTimerSelected = false;
                          controller.isVideoRecord = !controller.isVideoRecord;

                          controller.startTimer();

                          if (controller.isCameraFlashOn == true) {
                            controller.cameraController!.setFlashMode(
                              FlashMode.torch,
                            );
                          }
                          await controller.cameraController!
                              .startVideoRecording();
                          // forautostop();
                          controller.update();
                        }
                      },
                      onLongPressEnd: (value) async {
                        if (controller.isTimerOn == false) {
                          controller.percentIndicatorRadius = 40;
                          controller.buttonPressSize = 50;

                          controller.isTimerSelected = true;
                          controller.isVideoRecord = !controller.isVideoRecord;

                          if (controller.isCameraFlashOn == true) {
                            controller.cameraController!.setFlashMode(
                              FlashMode.off,
                            );
                          }
                          controller.recordedVideo = await controller
                              .cameraController!
                              .stopVideoRecording();
                          controller.videoinit();
                          controller.startTimer();
                          controller.cameraController!.buildPreview();
                          controller.update();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: controller.buttonPressSize,
                        width: controller.buttonPressSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColor,
                        ),
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    controller.editorVideoPlayerController!.pause();
                    controller.cameraController!.dispose();
                    Get.to(
                      () => PostScreen(
                        videolist: controller.recordedVideo,
                      ),
                    )!
                        .then(
                      (value) {
                        controller.resetValues();
                        controller.callInit();
                      },
                    );
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColor,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryWhite,
                    ),
                  ),
                ),
          SizedBox(
            width: 50,
          ),
          // controller.editorVideoPlayerController == null
          //     ? InkWell(
          //         onTap: () async {
          //           var status = await Permission.camera.status;
          //           if (status.isDenied) {
          //             await [
          //               Permission.camera,
          //               Permission.storage,
          //             ].request().then((value) async {
          //               final ImagePicker _picker = ImagePicker();
          //               controller.recordedVideo = await _picker.pickVideo(
          //                   maxDuration: const Duration(seconds: 30),
          //                   source: ImageSource.gallery);
          //               controller.videoinit();
          //               controller.update();
          //             });
          //             controller.update();
          //           }
          //           if (await Permission.storage.isPermanentlyDenied) {
          //             openAppSettings();
          //           }
          //           if (status.isGranted) {
          //             final ImagePicker _picker = ImagePicker();
          //             controller.recordedVideo = await _picker.pickVideo(
          //                 maxDuration: const Duration(seconds: 30),
          //                 source: ImageSource.gallery);
          //             controller.videoinit();
          //             controller.update();
          //           }
          //         },
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: 50,
          //               width: 50,
          //               child: Center(
          //                 child: SvgPicture.asset(AppAsset.icupload),
          //               ),
          //             ),
          //             // Text(
          //             //   "Upload",
          //             //   style: AppTextStyle.normalSemiBold14
          //             //       .copyWith(color: primaryWhite),
          //             // )
          //           ],
          //         ),
          //       )
          //     : const SizedBox(
          //         height: 50,
          //         width: 50,
          //       ),
        ],
      ),
    );
  }
}
