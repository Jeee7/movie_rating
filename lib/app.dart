import 'package:flutter/material.dart';
import 'package:movie_rating/const/colorlist.dart';
import 'package:movie_rating/const/custom_colors.dart';
import 'package:movie_rating/screens/splash_screen/splash_screen.dart';

class MovieRatingApp extends StatelessWidget {
  const MovieRatingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Rating App',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: const [
          CustomColors(
            background: Color(0xFFFFFFFF),
            grayLine: ColorList.lightGrayLine,
            chatBox: ColorList.white,
            whiteBar: ColorList.white,
            colorIc: ColorList.grayDark1,
            silverBg: ColorList.silverBg,
            colorBoxHistory: ColorList.white,
            fontColorGlobal: ColorList.black,
          ),
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: const [
          CustomColors(
            background: ColorList.blackBg,
            grayLine: ColorList.grayLine,
            chatBox: ColorList.gray2,
            whiteBar: ColorList.gray2,
            colorIc: ColorList.white,
            silverBg: ColorList.blackBg,
            colorBoxHistory: ColorList.gray2,
            fontColorGlobal: ColorList.white,
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
