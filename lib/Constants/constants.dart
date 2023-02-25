import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


double SCREEN_WIDTH(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double SCREEN_HEIGHT(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

TextStyle SET_FONT_STYLE(
    double fontSize, FontWeight fontWeight, Color fontColor,
    {TextField_height, lineheight}) {
  return GoogleFonts.ibarraRealNova(
      color: fontColor,
      fontSize: fontSize,
      height: TextField_height,
      fontWeight: fontWeight);
}