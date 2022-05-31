import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffEA680E);
const Color accentColor = Color(0xff2E3642);
const Color redColor = Color(0xffED3238);
const Color greyLigthColor = Color(0xffEFEFEF);
const Color textColor1 = Color(0xff1A222E);
const Color textColor2 = Color(0xff848586);
const Color textColor3 = Color(0xffC5C5C5);

Color getPrimaryColor(int num) => Color(int.parse('0x${num}EA680E'));

const String errInet = 'Пожалуйста, проверьте подключение и повторите еще раз';

const String tokenBox = 'token_box';
const String tokenBoxKey = 'token_box_key';

kTextStyle(
    {Color? color,
    double size = 14,
    FontWeight fontWeight = FontWeight.w500,
    double? letterSpacing}) {
  return TextStyle(
      color: color ?? textColor1,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing);
}
