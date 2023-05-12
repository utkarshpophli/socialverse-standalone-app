import '/export.dart';

class HomeScreen extends StatefulWidget {
  final EditorController? editorController;
  const HomeScreen({Key? key, this.editorController}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final homeController = Get.put(HomeController());
  final homeVideoPlayerController = Get.put(HomeCommonVideoPlayerController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBlack,
      body: RefreshIndicator(
        color: purpleColor,
        backgroundColor: Colors.black,
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          homeController.getFeedList(context);
        },
        child: GetBuilder<HomeController>(
          initState: (state) {
            homeController.getFeedList(context);
          },
          dispose: (state) {},
          builder: (_) {
            return Stack(
              children: [
                homeController.feedPostList.isNotEmpty
                    ? HomeVideoWidget(
                        videoIndex: homeController.videoIndex,
                        videosList: homeController.feedPostList,
                        pageController: homeController.pageController.obs,
                        fromHomePage: true,
                      )
                    : const CustomProgressIndicator(),
                Obx(
                  () => SafeArea(
                    child: Visibility(
                      visible: !isPipModeOn.value,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [],
                            ),
                          ),
                          uploadDialog(dataStorage.read("isDarkMode")),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget labelButton(
      {onTap, controller, label, buttonColor, textColor, isSelected}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyle.normalBold12.copyWith(
                color: textColor,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 3.h),
            if (isSelected)
              Container(
                height: 2.8.h,
                width: 28.h,
                color: primaryWhite,
              )
          ],
        ),
      ),
    );
  }

  uploadDialog(theme) {
    return widget.editorController != null
        ? StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
            return Obx(
              () => widget.editorController!.isUploadStart.value ==
                      true //dataStorage.read('isUploadVideo')
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 20.h),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme
                              ? fillGrey.withOpacity(0.5)
                              : primaryBlack.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => CircularPercentIndicator(
                                radius: 20.0.r,
                                lineWidth: 2.0.w,
                                percent: (widget.editorController!
                                        .uploadPercentageValue.value) /
                                    100,
                                progressColor: purpleColor,
                                animation: true,
                                animationDuration: 0,
                                center: Text(
                                  // dataStorage.read('uploadValue').toString(),
                                  widget.editorController!.uploadPercentageValue
                                          .value
                                          .toString() +
                                      "%",
                                  style: AppTextStyle.normalBold18.copyWith(
                                      color: primaryWhite, fontSize: 12.sp),
                                ),
                              ),
                            ),
                            width15,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your video is uploading",
                                    style: AppTextStyle.normalBold16
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                  customHeight(0),
                                  Text(
                                    "Please wait a little longer",
                                    style: AppTextStyle.normalBold14.copyWith(
                                        color: hintGrey.withOpacity(0.9),
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Offstage(),
            );
          })
        : Offstage();
  }
}
