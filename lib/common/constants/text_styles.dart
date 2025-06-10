import 'package:flutter/cupertino.dart';

class _InstalledFonts {
  // Text
  static const String rubik = 'Rubik';
  static const String ibmPlexSans = 'IBMPlexSans';
  static const String openSans = 'OpenSans';
  static const String segoeUI = 'SegoeUI';
}

class AppTextStyles {
  // Rubik
  static TextStyle rubikRegular(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.rubik,
        fontWeight: FontWeight.normal,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle rubikMedium(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.rubik,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle rubikBold(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.rubik,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  // IBM Plex Sans
  static TextStyle ibmPlexSansMedium(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.ibmPlexSans,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle ibmPlexSansSemiBold(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.ibmPlexSans,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle ibmPlexSansBold(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.ibmPlexSans,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  // Open Sans
  static TextStyle openSansItalic(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.openSans,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle openSansRegular(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.openSans,
        fontWeight: FontWeight.normal,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle openSansSemiBold(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.openSans,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  static TextStyle openSansBold(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.openSans,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }

  // Segoe UI
  static TextStyle segoeUIRegular(double size, Color color,
      {double letterSpacing = 0, double? lineHeight}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _InstalledFonts.segoeUI,
        fontWeight: FontWeight.normal,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
  }
}
