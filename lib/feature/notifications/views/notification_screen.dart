import 'package:socialverse/export.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationlist = [
    {
      "image":
          "https://images.unsplash.com/photo-1534030347209-467a5b0ad3e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=150&q=40",
      "name": "denish",
      "noti": "Wow! Such a amazing movie",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1534030347209-467a5b0ad3e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=150&q=40",
      "name": "denish",
      "noti":
          "Wow! Such a amazing movie Wow! Such a amazing movie Wow! Such a amazing movie Wow! Such a amazing movie",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1534030347209-467a5b0ad3e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=150&q=40",
      "name": "denish",
      "noti": "Wow! Such a amazing movie",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1534030347209-467a5b0ad3e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=150&q=40",
      "name": "denish",
      "noti":
          "Wow! Such a amazing movie Wow! Such a amazing movie Wow! Such a amazing movie Wow! Such a amazing movie",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: UIInterface.backgroundTheme(),
        child: commonAppbar(
          context: context,
          title: "Notifications",
          child: ListView.builder(
            itemCount: notificationlist.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        UIInterface.profileImageWidget(
                          imgUrl: notificationlist[index]["image"],
                          radius: 30,
                        ),
                        width10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          notificationlist[index]["name"] + " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    TextSpan(
                                      text: notificationlist[index]["noti"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "11:35 PM",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    height5,
                    Divider(
                      thickness: 1,
                      color: greyText.withOpacity(0.1),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
