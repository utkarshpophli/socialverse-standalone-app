// ignore_for_file: prefer_adjacent_string_concatenation
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class EditorController extends GetxController {
  CameraController? cameraController;
  VideoPlayerController? editorVideoPlayerController;
  static Circle processIndicator = Circle();
  var dio = Dio();
  final NetworkRepository _networkRepository = NetworkRepository();
  final postController = Get.put(PostController());

  dynamic cameraValue;
  XFile? recordedVideo;
  bool isCameraFlashOn = false;
  bool isCameraFlip = false;
  bool isTimerOn = false;
  bool isTimercount = false;
  double videoSpeed = 1.0;
  bool isFirstClick = false;
  bool isVideoPause = false;
  bool isRecordStart = true;
  bool isVideoRecord = false;

  RxInt uploadPercentageValue = 0.obs;
  RxBool isUploadStart = false.obs;
  double buttonPressSize = 50;
  double percentIndicatorRadius = 40;
  // camera click timer
  Timer? clickTimer;
  RxDouble recordPercentageValue = 0.0.obs;

  bool isTimerSelected = true;
  // Timer button timer
  Timer? timer;
  RxInt timervalue = 0.obs;
  @override
  void onInit() {
    resetValues();
    callInit();
    super.onInit();
  }

  callInit() {
    // getUploadToken();
    availableCameras().then((value) {
      cameraValue = value;
    }).then(
      (value) async {
        cameraController = CameraController(
          cameraValue[0],
          ResolutionPreset.max,
        );

        await cameraController!.initialize().then(
          (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) => update());
            // cameraController!.setZoomLevel(1.0);
            cameraController!.lockCaptureOrientation();
          },
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  getUploadToken([context]) async {
    log('Generating upload url & hash');
    final response = await _networkRepository.getUploadToken(context);
    if (response != null && response["status"] == "success") {
      dataStorage.write('UploadUrl', response['url']);
      dataStorage.write('hash', response['hash']);

      log(dataStorage.read("hash"));
      log(dataStorage.read("UploadUrl"));
    } else {
      ErrorDialog.showErrorDialog(response['message'], context);
    }
    update();
  }

  uploadvideo(context, path) async {
    editorVideoPlayerController!.pause();
    isUploadStart.value = true;

    String uploadUrl = await dataStorage.read("UploadUrl");
    var videoupload = File(path).readAsBytesSync();

    Options options = Options(contentType: "mp4", headers: {
      'Accept': "*/*",
      'Content-Length': videoupload.length,
      'Connection': 'keep-alive',
      'User-Agent': 'ClinicPlush'
    });

    // ignore: unused_local_variable
    var response = await dio.put(
      uploadUrl,
      data: Stream.fromIterable(videoupload.map((e) => [e])),
      // onReceiveProgress: (int sent, int total) {},
      onSendProgress: (int sent, int total) {
        uploadPercentageValue.value = (sent / total * 100).round();
        // log(uploadPercentageValue.toString());
      },
      options: options,
    );
    await postController.postVideo(context);
    isUploadStart.value = false;
    update();
  }

  void videoinit() {
    if (recordedVideo != null) {
      editorVideoPlayerController =
          VideoPlayerController.file(File(recordedVideo!.path));

      editorVideoPlayerController!.addListener(() {
        update();
      });
      editorVideoPlayerController!.setLooping(true);
      editorVideoPlayerController!.initialize().then((_) {
        editorVideoPlayerController!.setPlaybackSpeed(videoSpeed);
        editorVideoPlayerController!.play();
      });
    }
  }

  void startTimerbutton() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timerbutton) async {
        if (timervalue.value == 3.0) {
          isTimercount = !isTimercount;

          timerbutton.cancel();
          isTimerSelected = false;
          if (isCameraFlashOn == true) {
            cameraController!.setFlashMode(
              FlashMode.torch,
            );
          }
          await cameraController!.startVideoRecording();
          startTimer();

          update();

          Timer(const Duration(seconds: 30), () async {
            if (isVideoPause == false) {
              isTimerSelected = true;
              isVideoRecord = !isVideoRecord;
              if (isCameraFlashOn == true) {
                cameraController!.setFlashMode(
                  FlashMode.off,
                );
              }

              recordedVideo = await cameraController!.stopVideoRecording();
              videoinit();
              startTimer();
              cameraController!.buildPreview();
              update();
            }
          });
        } else {
          timervalue.value++;
          update();
        }
      },
    );
  }

  void startTimer() {
    // if (isSelected) {
    const oneSec = Duration(seconds: 1);
    clickTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (recordPercentageValue.value == 30.0 || isTimerSelected) {
          timer.cancel();
          update();
        } else {
          recordPercentageValue.value++;
          update();
        }
      },
    );
  }

  resetValues() {
    recordedVideo = null;

    editorVideoPlayerController = null;
    recordPercentageValue.value = 0.0;
    timervalue.value = 0;
    videoSpeed = 1.0;
    isVideoPause = false;
    isTimerOn = false;
    isRecordStart = true;
    isFirstClick = false;
    uploadPercentageValue.value = 0;
    isUploadStart.value = false;
    update();
  }

  floatingScaffold(context, {required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: whiteColor),
        ),
        margin: EdgeInsets.only(
          bottom: Get.height * 0.125,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
