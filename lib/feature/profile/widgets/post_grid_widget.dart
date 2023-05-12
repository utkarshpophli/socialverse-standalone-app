import 'package:socialverse/export.dart';

class CommonPostGridView extends StatelessWidget {
  final List videosList;
  CommonPostGridView({Key? key, required this.videosList}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        dispose: (state) {},
        initState: (state) {
          // profileController.postList(videosList);
        },
        builder: (controller) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            // reverse: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 0.65,
            ),
            itemCount: videosList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  controller.tabIndex = 0;
                  Get.to(
                    () => VideoPlayerWidget(
                      videoIndex: index,
                      videosList: videosList.obs,
                      fromHomePage: false,
                      pageController: PageController(
                        initialPage: index,
                      ).obs,
                    ),
                  );
                  //     .then(
                  //   (value) => {
                  //     controller.tabIndex = 0,
                  //     profileController.getProfileDetails(
                  //       context,
                  //       fromUser: false,
                  //       profileusername: userName,
                  //     ),
                  //     controller.update(),
                  //   },
                  // );
                },
                child: videosList.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: purpleColor,
                        ),
                      )
                    : Stack(
                        children: [
                          Center(
                            child: NetworkImageWidget(
                              imageUrl:
                                  videosList[index]["thumbnail_url"].toString(),
                              fit: BoxFit.cover,
                              width: 500,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.play_arrow,
                                  color: primaryWhite,
                                  size: 15,
                                ),
                                // Text(
                                //   '',
                                //   style: AppTextStyle.normalSemiBold13.copyWith(
                                //       color: primaryWhite, fontSize: 12),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
              );
            },
          );
        });
  }
}
