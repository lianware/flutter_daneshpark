import 'package:flutter/material.dart';

class CustomStyles {
  static Widget textFieldStyle1(
      String headTitle,
      String hintTitle,
      TextInputType textInputType,
      bool obscureText,
      IconData tfIcon,
      TextEditingController _usernameController) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            headTitle,
            style: CustomStyles.inputTitle,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: TextField(
          controller: _usernameController,
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          style: CustomStyles.inputTitle,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: CustomStyles.hintText,
            suffixIcon: Icon(tfIcon),
          ),
        ),
      ),
    ]);
  }

  static TextStyle titleStyle(
      Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: color,
      fontFamily: "Irs",
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static var titleStyle1 =
      CustomStyles.titleStyle(Colors.teal, 24, FontWeight.w800);
  static var titleStyle2 =
      CustomStyles.titleStyle(Colors.teal, 20, FontWeight.w800);
  static var titleStyle3 =
      CustomStyles.titleStyle(Colors.blueAccent, 19, FontWeight.w800);
  static var inputTitle =
      CustomStyles.titleStyle(Colors.blueAccent, 16, FontWeight.w800);
  static var hintText =
      CustomStyles.titleStyle(Colors.blueAccent, 14, FontWeight.normal);
}
