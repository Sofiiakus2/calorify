import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const primaryColor = Colors.grey;
const secondaryColor = Color(0xFFdfe9fd);
Color alertBackgroundColor = Colors.grey.shade200;
const lightGreen = Color(0xFFe1fea7);
const green = Color(0xFFc3fd56);
const felicata = Color(0xFFefbc7c);
//const felicata = Color(0xFFF56D53);
const lightPurple = Color(0xFFeceefa);
const lightSalad = Color(0xFFf6fadb);
const lightBlue = Color(0xFFe9fdfa);
const lightPink = Color(0xFFf5effb);

const List<Color> lightColors = [
  lightPurple,
  lightSalad,
  lightGreen,
  lightBlue,
  lightPink,
];

Color getRandomLightColor() {
  final random = Random();
  return lightColors[random.nextInt(lightColors.length)];
}

var appMainGrey = Colors.grey.withOpacity(0.2);

const backgroundColor = Colors.white;

final themeData = ThemeData();

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  dividerTheme: const DividerThemeData(
   // color: Colors.black,
    thickness: 1,
    space: 10,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white
  ),
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),

);

final textTheme = TextTheme(
  labelSmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black
  ),
  labelMedium: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black
  ),
  labelLarge: GoogleFonts.raleway(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: Colors.black
  ),
  bodySmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black
  ),
  bodyMedium: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black
  ),
  titleSmall: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: Colors.black
  ),

);
