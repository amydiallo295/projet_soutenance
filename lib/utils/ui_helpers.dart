// Flutter imports:
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class TitleWidget extends StatelessWidget {
  TitleWidget({super.key, required this.text, this.color = Colors.white});
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

// ignore: must_be_immutable
class TextDisplay extends StatelessWidget {
  TextDisplay({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 14),
    );
  }
}

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      required this.label,
      required this.icon,
      required this.color,
      required this.onTap});
  Function onTap;
  String label;
  IconData icon;
  Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: color,
      ),
      onPressed: () {
        onTap();
      },
    );
  }
}

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 20.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 20.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = const Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// Returns the pixel amount for the percentage of the screen height. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens height
double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

/// Returns the pixel amount for the percentage of the screen width. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens width
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

var logger = Logger(
  printer: PrettyPrinter(),
);
