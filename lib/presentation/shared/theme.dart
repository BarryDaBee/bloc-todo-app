import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme darkTextTheme = TextTheme(
  headline1: GoogleFonts.anticSlab(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: const Color(0xFFDADADA),
  ),
  subtitle1: GoogleFonts.anticSlab(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF575767),
  ),
  headline3: GoogleFonts.anticSlab(
    color: const Color(0xFFDADADA),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  headline4: GoogleFonts.anticSlab(
    color: const Color(0xFFDADADA),
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: GoogleFonts.anticSlab(
    fontSize: 18,
    color: const Color(0xFF575767),
    fontWeight: FontWeight.w500,
  ),
);

TextTheme lightTextTheme = TextTheme(
  headline1: GoogleFonts.anticSlab(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  subtitle1: GoogleFonts.anticSlab(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF575767),
  ),
  headline3: GoogleFonts.anticSlab(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  headline4: GoogleFonts.anticSlab(
    color: const Color(0xFF575767),
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: GoogleFonts.anticSlab(
    fontSize: 18,
    color: const Color(0xFF575767),
    fontWeight: FontWeight.w500,
  ),
);
