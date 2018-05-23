import 'package:flutter/material.dart';
import 'package:quizapp_redux/themes/quiz_theme.dart';

class QuizQuestionListDisplay extends StatelessWidget {
  final List<String> categories;
  QuizQuestionListDisplay(this.categories);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return new _QuizDecorationWrapper(
              new Text(
                categories[index].toUpperCase(),
                style: QuizQuestionTheme.categoryTextTheme(),
              )
          );
        }
    );
  }
}

class _QuizDecorationWrapper extends StatelessWidget {
  final Widget _widget;

  _QuizDecorationWrapper(this._widget);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 150.0,
        decoration: new BoxDecoration(
          border: new Border.all(width: 6.0, color: Colors.black),
          borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
          color: const Color(0xFFFF060CE9),
        ),
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: _widget
    );
  }
}
