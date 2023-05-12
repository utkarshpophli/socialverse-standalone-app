import 'package:webview_flutter/webview_flutter.dart';

import '/export.dart';

class ReportPage extends StatefulWidget {
  final String link;
  const ReportPage({
    required this.link,
    Key? key,
  }) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageSheetState();
}

class _ReportPageSheetState extends State<ReportPage> {
  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            key: _key,
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              )
              ..loadRequest(
                Uri.parse(widget.link),
              ),
          ),
          isLoading
              ? Positioned(
                  top: Get.height * 0.32,
                  left: 0,
                  right: 0,
                  child: const CustomProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
