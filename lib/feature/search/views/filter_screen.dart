import 'package:socialverse/export.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final DateTime _dateMin = DateTime(2000, 00, 01, 00, 00);
  final DateTime _dateMax = DateTime(2000, 00, 01, 00, 60);
  SfRangeValues _dateValues = SfRangeValues(
      DateTime(2000, 00, 01, 00, 30), DateTime(2000, 00, 01, 00, 50));

  List categories = ["Entertainment", "Sports", "Suggested"];
  final searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconsIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    iconColor: blackColor,
                    borderRadius: 12.0,
                    ontap: () {
                      Get.back();
                    },
                  ),
                  Text(
                    "Fliter",
                    style: ThemeData().textTheme.bodySmall!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).cardColor),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              height20,
              Text(
                "Timeline",
                style: ThemeData().textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).cardColor),
              ),
              SizedBox(
                width: Get.width,
                child: SfRangeSliderTheme(
                  data: SfRangeSliderThemeData(
                    activeTrackColor: purpleColor,
                    thumbColor: primaryWhite,
                    inactiveTrackColor: grey,
                    thumbRadius: 8,
                  ),
                  child: SfRangeSlider(
                    onChanged: (newValues) {
                      setState(() {
                        _dateValues = newValues;
                      });
                    },
                    stepDuration: SliderStepDuration(minutes: 10),
                    min: _dateMin,
                    max: _dateMax,
                    values: _dateValues,
                    labelFormatterCallback:
                        (dynamic actualValue, String formattedText) {
                      DateTime value = actualValue;
                      return (value.minute.toString() + "m");
                    },
                    interval: 10,
                    dateIntervalType: DateIntervalType.minutes,
                    dateFormat: DateFormat.M(),
                    showLabels: true,
                  ),
                ),
              ),
              height15,
              Text(
                "Feed",
                style: ThemeData().textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).cardColor),
              ),
              height15,
              Expanded(child: feedsGridView())
            ],
          ),
        ),
      ),
    );
  }

  Widget feedsGridView() {
    return GridView.builder(
        itemCount: categories.length + 1,
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 280,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: tikTokGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: index != categories.length
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(categories[index].toString()),
                      feedsDetailsGridView(),
                    ],
                  )
                : Icon(
                    Icons.add,
                    size: 80,
                    color: whiteColor,
                  ),
          );
        });
  }

  Widget feedsDetailsGridView() {
    return GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 70,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: whiteColor, width: 2),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        searchController.recentAccount[index]["image"]))),
            child: Text(
              searchController.recentAccount[index]["name"],
              style: TextStyle(color: whiteColor),
            ),
          );
        });
  }
}
