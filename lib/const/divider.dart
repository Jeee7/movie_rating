import 'package:flutter/material.dart';
import 'package:movie_rating/const/colorlist.dart';

Widget gapHeight(double height) {
  return SizedBox(height: height);
}

Widget gapWidth(double width) {
  return SizedBox(width: width);
}

Widget divider({
  Color color = ColorList.grey,
  double thickness = 1.0,
  EdgeInsetsGeometry? margin,
}) {
  return Container(
    margin: margin,
    child: Divider(
      color: color,
      thickness: thickness,
    ),
  );
}

Widget buildDividerWithText() {
  return const Row(
    children: [
      Expanded(
        child: Divider(
          color: ColorList.gray5,
          thickness: 1,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          'Or',
          style: TextStyle(
            color: ColorList.gray5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: ColorList.gray5,
          thickness: 1,
        ),
      ),
    ],
  );
}
