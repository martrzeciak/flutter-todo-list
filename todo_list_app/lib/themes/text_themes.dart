import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getHeadingTextStyle() {
  return GoogleFonts.lato(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getSubHeadingTextStyle() {
  return GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );
}

TextStyle getTitleTextStyle() {
  return GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );
}

TextStyle getInputTextStyle() {
  return GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white
  );
}

TextStyle getPlaceholderTextStyle() {
  return GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white70
  );
}


TextStyle getPriorityListTextStyle() {
  return GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white70,
  );
}
