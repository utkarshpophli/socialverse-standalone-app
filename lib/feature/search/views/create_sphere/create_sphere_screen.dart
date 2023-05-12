import 'dart:developer';
import 'dart:io';
import 'package:socialverse/export.dart';

class CreateSphereScreen extends StatefulWidget {
  const CreateSphereScreen({Key? key}) : super(key: key);

  @override
  State<CreateSphereScreen> createState() => _CreateSphereScreenState();
}

class _CreateSphereScreenState extends State<CreateSphereScreen> {
  // int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateSphereController>(
      init: CreateSphereController(),
      dispose: CreateSphereController().pickedImage = null,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              "Create Your Sphere",
              style: ThemeData().textTheme.bodySmall!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
            ),
            leading: InkWell(
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  height20,
                  textFormField(
                    maxLines: 1,
                    autofocus: true,
                    controller: controller.nameController,
                    style: ThemeData().textTheme.bodySmall!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).errorColor,
                        ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 18, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      hintStyle: ThemeData().textTheme.bodySmall!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: grey,
                          ),
                      hintText: "Title of Your Sphere",
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  // height20,
                  // Text(
                  //   'Subscription amount: \$$selectedIndex',
                  //   style: ThemeData().textTheme.bodySmall!.copyWith(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //         color: Theme.of(context).errorColor,
                  //       ),
                  // ),
                  // height10,
                  // Slider(
                  //   value: selectedIndex.toDouble(),
                  //   min: 0,
                  //   activeColor: purpleColor,
                  //   inactiveColor: purpleColor.withOpacity(0.5),
                  //   max: 100,
                  //   // divisions: 10,
                  //   label: selectedIndex.toString(),
                  //   onChanged: (double value) {
                  //     setState(() {
                  //       selectedIndex = value.toInt();
                  //       log(value.toString());
                  //     });
                  //   },
                  // ),
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
                              title: 'Create Sphere',
                              onPressed: controller.nameController.text.isEmpty
                                  ? () {
                                      controller.floatingScaffold(
                                        context,
                                        message: 'Enter Sphere title',
                                        height: Platform.isIOS
                                            ? Get.height * 0.06
                                            : Get.height * 0.04,
                                      );
                                    }
                                  : () {
                                      controller.createSphere(context);
                                    },
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
