import '/export.dart';
import 'dart:isolate';

BuildContext? CONTEXT_FOR_ISOLATE;
Future createIsolate(int index, BuildContext context) async {
  ReceivePort mainReceivePort = ReceivePort();

  Isolate.spawn<SendPort>(getVideosTask, mainReceivePort.sendPort);

  SendPort isolateSendPort = await mainReceivePort.first;

  ReceivePort isolateResponseReceivePort = ReceivePort();

  isolateSendPort.send([index, isolateResponseReceivePort.sendPort]);

  final isolateResponse = await isolateResponseReceivePort.first;
  final _urls = isolateResponse;
  final HomeController homeController = Get.put(HomeController());
  homeController.feedPostList.addAll(_urls['posts']);
}

void getVideosTask(SendPort mySendPort) async {
  ReceivePort isolateReceivePort = ReceivePort();

  mySendPort.send(isolateReceivePort.sendPort);

  await for (var message in isolateReceivePort) {
    if (message is List) {
      final int index = message[0];

      final SendPort isolateResponseSendPort = message[1];
      final data = await NetworkRepository()
          .getSpherePosts(context: CONTEXT_FOR_ISOLATE, id: 0, page: index);

      isolateResponseSendPort.send(data);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.window.platformBrightness;
  await Firebase.initializeApp();
  await GetStorage.init();
  NetworkDioHttp.setDynamicHeader(endPoint: AppConstants.apiEndPoint);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const SocialVerse());
}
