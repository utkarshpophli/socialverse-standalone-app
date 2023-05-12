import 'package:socialverse/export.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        builder: (controller) {
          return Container(
            decoration: UIInterface.backgroundTheme(),
            // height: 200,
            child: commonAppbar(
              context: context,
              title: "Chat",
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return index.isEven
                            ? senderMessageWidget(context, index)
                            : myMessageWidget(context, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: messageTextFieldWidget(
            chatController,
            () {},
            context,
          ),
        ),
      ),
    );
  }

  Widget senderMessageWidget(context, index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    UIInterface.profileImageWidget(
                      imgUrl:
                          'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80',
                      height: 40,
                      width: 40,
                      radius: 20,
                    ),
                    width05,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                          ),
                          color: lightGrey,
                        ),
                        child: Text(
                          'Lorem Ipsum is not simply random text. It has roots in a piece of @classical from 45 BC',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                customHeight(2),
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    " 12:50 PM",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget myMessageWidget(context, index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Theme.of(context).errorColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem Ipsum is not simply random text. It has roots in a piece of @classical from 45 BC',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                customHeight(2),
                const Text(
                  " 12:50 PM",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageTextFieldWidget(
      ChatController controller, Function()? sendTap, context) {
    return TextFormField(
      controller: controller.messageController,
      decoration: InputDecoration(
        fillColor: dataStorage
                .read("isDarkMode") //Get.theme.brightness == Brightness.dark
            ? primaryWhite.withOpacity(0.3)
            : grey.withOpacity(0.1),
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 5.0),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 5.0),
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: "Message.....",
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AppAsset.icemjois,
            color: Theme.of(context).errorColor,
          ),
        ),
        suffixIcon: InkWell(
          onTap: sendTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              AppAsset.icsend,
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
