import 'LoginPage.dart';

import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const title_style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.w800,
      fontFamily: 'Irs',
      fontSize: 19,
      letterSpacing: 0.5);

  @override
  Widget build(BuildContext context) {
    Widget example = SplashScreenView(
      navigateRoute: LoginPage(),
      duration: 4000,
      imageSize: 200,
      pageRouteTransition: PageRouteTransition.Normal,
      imageSrc: 'splashscreen_image.png',
      textStyle: title_style,
      textType: TextType.TyperAnimatedText,
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: example,
    );
  }
}
