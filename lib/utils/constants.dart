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


const String consumerKey = 'fdf89c8699c01cfd7a4516cc56e11a60';
const String consumerSecret = '8928b7b8aeac0a9d';
const String oauthSignatureMethod = 'HMAC-SHA1';
const String oauthToken = '72157720845342981-085f078479766700';
const String oauthTokenSecret = 'f2a8aedc3f969932';
const String oauthVerifier = '1648f8148972bf0c';

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
