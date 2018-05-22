import 'package:flutter/material.dart';
import 'package:quizapp_redux/themes/quiz_theme.dart';

class QuizQuestionDisplay extends StatelessWidget {

  final String category;
  final String qaText;
  final VoidCallback onClickQA;
  final VoidCallback onReportAnswer;

  QuizQuestionDisplay(this.category, this.qaText, this.onClickQA,
      this.onReportAnswer);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          flex: 2,
          child: new _QuizDecorationWrapper(
              new _QuestionCategoryWidget(category)),
        ),
        new Flexible(
          flex: 6,
          child: new GestureDetector(
            onTap: onClickQA,
            child: new _QuizDecorationWrapper(new _QuestionAnswerWidget(
                qaText)),
          ),
        ),
        new Flexible(
          flex: 1,
          child: new Center(
            child: new FlatButton(
                padding: const EdgeInsets.all(4.0),
                onPressed: onReportAnswer,
                child: new Text(
                  'Report Question',
                  style: new TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                )
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCategoryWidget extends StatelessWidget {
  final String _category;
  _QuestionCategoryWidget(this._category);


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        _category == null ? '' : _category.toUpperCase(),
        textAlign: TextAlign.center,
        style: QuizQuestionTheme.categoryTextTheme(),
      ),
    );
  }
}

class _QuestionAnswerWidget extends StatelessWidget {
  final String _mainText;
  _QuestionAnswerWidget(this._mainText);

  Widget _buildQATextWidget() {
    if (_mainText.contains(new RegExp(r'<\/?i>'))) {
      RegExp exp = new RegExp(r'<i>(.*?)<\/i>');
      Match match = exp.firstMatch(_mainText);
      int matchStrPos = match.start;
      int matchEndPos = match.end;
      String matchText = match.group(1);
      var children = <TextSpan>[];
      if (matchStrPos > 0) {
        children.add(new TextSpan(
          text: _mainText.substring(0, matchStrPos),
          style: QuizQuestionTheme.questionAnswerTextTheme(),
        ));
      }
      children.add(new TextSpan(
        text: matchText,
        style: QuizQuestionTheme.questionAnswerTextThemeWithItalics()
      ));
      if (matchEndPos != -1 && matchEndPos < _mainText.length) {
        children.add(new TextSpan(
          text: _mainText.substring(matchEndPos),
          style: QuizQuestionTheme.questionAnswerTextTheme()
        ));
      }
      return new RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          children: children,
        ),
      );
    } else {
      return new Text(
        _mainText == null ? '' : _mainText.toUpperCase(),
        textAlign: TextAlign.center,
        style: QuizQuestionTheme.questionAnswerTextTheme(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: _buildQATextWidget(),
      scrollDirection: Axis.vertical,
    );
  }
}

class _QuizDecorationWrapper extends StatelessWidget {
  final Widget _widget;

  _QuizDecorationWrapper(this._widget);

  @override
  Widget build(BuildContext context) {
    return new Container(
        constraints: new BoxConstraints.expand(
        ),
        decoration: new BoxDecoration(
          border: new Border.all(width: 8.0, color: Colors.black),
          borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
          color: const Color(0xFFFF060CE9),
        ),
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: _widget
    );
  }
}