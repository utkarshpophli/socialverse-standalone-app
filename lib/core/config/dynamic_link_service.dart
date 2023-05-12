import 'dart:developer';
import '../../export.dart';


class DynamicRepository {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<Uri> createDynamicLink(context) async {
    String uriPrefix = "https://watchflic.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('https://www.watchflic.com/'),
      androidParameters: const AndroidParameters(
        packageName: 'com.socialverse.app',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.socialverse.app',
        // appStoreId: ''
      ),
    );

    var dynamicUrl = await dynamicLinks.buildLink(parameters);
    onSuccessLink(dynamicLinks, context, parameters);
    log('\x1b[97m Dynamic URL : $dynamicUrl');
    return dynamicUrl;
  }

  Future<void> initDynamicLinks(context) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
}
Future<void> onSuccessLink(dynamicLinks, context, parameters) async {
  PendingDynamicLinkData? dynamicLink = await dynamicLinks.getInitialLink();
  final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
  Uri? url = shortLink.shortUrl;

  log('\x1b[93m Dynamic URL :  $url');
  if (dynamicLink != null) {
    String? query = dynamicLink.link.query;
    Uri? link = dynamicLink.link;
    String? path = dynamicLink.link.path;
    log('\x1b[93m Query $query');
    log('\x1b[93m Link $link');
    log('\x1b[93m Path $path');
  }
}
