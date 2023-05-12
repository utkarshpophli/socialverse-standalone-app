import 'package:socialverse/export.dart';

class MyAlgoController extends GetxController {
  double numberOfFeatures = 16;
  var ticks = [0, 25, 50, 78, 100];
  List<String> features = [];

  var featuresList = [
    "Drama",
    "Beauty",
    "Action",
    "Flim & Animarion",
    "Music",
    "Pets & Animals",
    "Sports",
    "Travel & Events",
    "Gaminmg",
    "People & Vlogs",
    "Comedy",
    "Entertainment",
    "News & Politics",
    "How to & Style",
    "Education",
    "Science & Tech",
    "Ninprofits & Activism",
  ];
  var data = [
    [80, 70, 70, 80, 70, 80, 70, 80, 70, 80, 70, 80, 70, 80, 70, 80],
    [40, 50, 40, 50, 40, 50, 40, 50, 40, 50, 40, 50, 40, 50, 40, 50]
  ];
  // getChartData() {
  //   data = data
  //       .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
  //       .toList();
  // }
}
