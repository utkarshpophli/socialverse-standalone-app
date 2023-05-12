import 'dart:io';
import '/export.dart';

// ignore: must_be_immutable
class MainHomeScreen extends StatelessWidget {
  EditorController? editorController;
  ProfileController profileController = Get.put(ProfileController());
  final homeController = Get.put(HomeController());
  final homeVideoController = Get.put(HomeCommonVideoPlayerController());
  final mainHomeScreenController = Get.put(MainHomeScreenController());

  MainHomeScreen({Key? key, this.editorController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<MainHomeScreenController>(
        builder: (controller) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.horizontal,
                  children: [
                    HomeScreen(
                      editorController: editorController,
                    ),
                    const SphereScreen(),
                    // EditorScreen(
                    //   fromHomeScreen: true,
                    // ),
                    // const WalletScreen(),
                    ProfileScreen(
                      fromMainUser: true,
                      profileUsername: dataStorage.read('username'),
                    )
                  ],
                  onPageChanged: (page) {
                    controller.onPageChanged(page);
                    if (page == 0 &&
                        homeVideoController.isPlaying.value == false) {
                      homeVideoController.isPlaying.value = true;
                      homeVideoController
                          .videoController(
                            homeVideoController.currentVideoIndex.value,
                          )
                          ?.play();
                    } else if (page == 1 ||
                        page == 2 ||
                        page == 3 ||
                        page == 4 &&
                            homeVideoController.isPlaying.value == true) {
                      homeVideoController.isPlaying.value = false;
                      homeVideoController
                          .videoController(
                            homeVideoController.currentVideoIndex.value,
                          )
                          ?.pause();
                    }
                  }),
              Positioned(
                bottom: 0.0,
                child: Obx(
                  () => Visibility(
                    visible: !isPipModeOn.value,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Container(
                        height: Platform.isIOS
                            ? Get.height * 0.1
                            : Get.height * 0.08,
                        padding: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30.0)),
                          gradient: controller.pageIndex.value == 0
                              ? const LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0, 0.2, 0.8, 1],
                                )
                              : const LinearGradient(
                                  colors: [primaryBlack, primaryBlack]),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            bottomBarItemWidget(
                                context: context,
                                icon: AppAsset.ichome,
                                index: 0,
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  controller.onBottomIconClick(0);
                                }),
                            bottomBarItemWidget(
                              context: context,
                              icon: AppAsset.sphereLogo,
                              index: 1,
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                controller.onBottomIconClick(1);
                              },
                            ),
                            // bottomBarItemWidget(
                            //   context: context,
                            //   icon: AppAsset.icadd,
                            //   index: 2,
                            //   onTap: () {
                            //     HapticFeedback.mediumImpact();
                            //     dataStorage.read('isLogging') == true
                            //         ? Get.off(
                            //             () => EditorScreen(
                            //               fromHomeScreen: true,
                            //             ),
                            //           )
                            //         : controller.showAuthBottomSheet(
                            //             context: context,
                            //           );
                            //   },
                            // ),
                            // bottomBarItemWidget(
                            //   context: context,
                            //   icon: AppAsset.icwallet,
                            //   index: 3,
                            //   onTap: () {
                            //     HapticFeedback.mediumImpact();
                            //     dataStorage.read('isLogging') == true
                            //         ? controller.onBottomIconClick(3)
                            //         : controller.showAuthBottomSheet(
                            //             context: context,
                            //           );
                            //   },
                            // ),
                            bottomBarItemWidget(
                              context: context,
                              icon: AppAsset.icuser,
                              index: 2,
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                dataStorage.read('isLogging') == true
                                    ? controller.onBottomIconClick(2)
                                    : controller.showAuthBottomSheet(
                                        context: context,
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bottomBarItemWidget({
    BuildContext? context,
    Function? onTap,
    String? icon,
    int? index,
  }) {
    return GetBuilder<MainHomeScreenController>(builder: (controller) {
      return Expanded(
        child: InkWell(
          onTap: () => onTap!(),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return controller.pageIndex.value == index
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[purpleColor, blueColor],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds)
                  : const LinearGradient(
                      colors: <Color>[Colors.white, Colors.white],
                    ).createShader(bounds);
            },
            child: SvgPicture.asset(
              icon!,
              // height: 20,
              // width: 20,
              height: Platform.isIOS
                  ? index == 2
                      ? 30.0
                      : 25
                  : index == 2
                      ? 25.0
                      : 22,
              width: Platform.isIOS
                  ? index == 2
                      ? 30.0
                      : 25
                  : index == 2
                      ? 25.0
                      : 22,
              color: controller.pageIndex.value == index!
                  ? purpleColor
                  : whiteColor,
            ),
          ),
        ),
      );
    });
  }
}
