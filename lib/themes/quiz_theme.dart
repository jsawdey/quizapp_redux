import 'package:flutter/material.dart';

class QuizQuestionTheme {

  // Question/Answer theme constants
  static final String qaFontFamily = 'Korinna';
  static final double qaFontSize = 28.0;
  static final Color qaTextColor = Colors.white;

  // Category theme constants
  static final String categoryFontFamily = 'Swiss911';
  static final double categoryFontSize = 36.0;
  static final Color categoryTextColor = Colors.white;

  static TextStyle questionAnswerTextTheme() {
    return new TextStyle(
      fontFamily: qaFontFamily,
      fontSize: qaFontSize,
      color: qaTextColor,
    );
  }

  static TextStyle questionAnswerTextThemeWithItalics() {
    return new TextStyle(
      fontFamily: qaFontFamily,
      fontSize: qaFontSize,
      color: qaTextColor,
      fontStyle: FontStyle.italic,
    );
  }

  static TextStyle categoryTextTheme() {
    return new TextStyle(
      fontFamily: categoryFontFamily,
      fontSize: categoryFontSize,
      color: categoryTextColor,
    );
  }

}