import 'dart:io';
import 'package:socialverse/export.dart';
import 'package:unicons/unicons.dart';

class EditSphereScreen extends StatelessWidget {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;
  const EditSphereScreen({
    Key? key,
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditSphereController>(
      init: EditSphereController(),
      dispose: EditSphereController().selectedImage = null,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              'Edit Sphere: $name',
              style: ThemeData().textTheme.bodySmall!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
            ),
            leading: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Get.back();
              },
              child: controller.isUploading == true
                  ? const SizedBox()
                  : Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                      color: Theme.of(context).errorColor,
                    ),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text(
                  //   'Edit Sphere: $name',
                  //   style: ThemeData().textTheme.bodySmall!.copyWith(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //         color: Theme.of(context).errorColor,
                  //       ),
                  // ),
                  height20,
                  controller.selectedImage?.path == null
                      ? InkWell(
                          onTap: () async {
                            var status = await Permission.camera.status;
                            if (status.isDenied) {
                              await [
                                Permission.camera,
                                Permission.storage,
                              ].request().then((value) async {
                                controller.selectPostImage(context);
                                // final ImagePicker _picker = ImagePicker();
                                // controller.selectedImage = await _picker
                                //     .pickImage(source: ImageSource.gallery);
                                // controller.update();
                              });
                              controller.update();
                            }
                            if (await Permission.storage.isPermanentlyDenied) {
                              openAppSettings();
                            }
                            if (status.isGranted) {
                              controller.selectPostImage(context);
                              // final ImagePicker _picker = ImagePicker();
                              // controller.selectedImage = await _picker
                              //     .pickImage(source: ImageSource.gallery);

                              controller.update();
                            }
                          },
                          child: imageUrl == '' || imageUrl == null
                              ? Image.asset(
                                  AppAsset.imagePicker,
                                  height: 200,
                                  width: 200,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl!,
                                      progressIndicatorBuilder:
                                          (context, url, progress) =>
                                              Image.asset(
                                        AppAsset.load,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            File(controller.selectedImage!.path),
                            height: 200,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            width: 200,
                          ),
                        ),
                  height10,
                  controller.selectedImage?.path == null
                      ? Text(
                          "Tap to add Sphere photo",
                          style: ThemeData().textTheme.bodySmall!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).errorColor,
                              ),
                        )
                      : const SizedBox(),
                  height20,
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: textFormField(
                      maxLines: 1,
                      controller: controller.editSphereController,
                      style: ThemeData().textTheme.bodySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).errorColor,
                          ),
                      maxLength: 90,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(10, 18, 0, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        hintStyle: ThemeData().textTheme.bodySmall!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: grey,
                            ),
                        hintText: description == null || description == ''
                            ? "Description of Sphere (optional)"
                            : description,
                      ),
                    ),
                  ),
                  height20,
                  Center(
                    child: controller.isUploading == true
                        ? const SizedBox(
                            height: 50,
                            width: 50,
                            child: CustomProgressIndicator(),
                          )
                        : SizedBox(
                            width: Get.width / 1.5,
                            child: ImageTextButton(
                              title: 'Update Sphere',
                              onPressed: controller.selectedImage?.path != null
                                  ? () async {
                                      // TODO: implement future
                                      // Future.wait([] );
                                      controller
                                          .uploadCategoriesImage(
                                            context,
                                            id: id,
                                          )
                                          .then(
                                            (value) => {
                                              controller
                                                  .updateCategoryDescription(
                                                context,
                                                id,
                                              ),
                                            },
                                          );
                                    }
                                  : () => controller.floatingScaffold(
                                        context,
                                        message:
                                            'Select image and enter sphere description',
                                        height: Platform.isIOS
                                            ? Get.height * 0.08
                                            : Get.height * 0.06,
                                      ),
                            ),
                          ),
                  ),
                  height20,
                  Text.rich(
                    TextSpan(
                      style: ThemeData().textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                            overflow: TextOverflow.ellipsis,
                          ),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            UniconsLine.exclamation_circle,
                            color: Colors.grey.shade600,
                            size: 15,
                          ),
                        ),
                        const TextSpan(
                          text: 'NB: Sphere image must be a square',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
