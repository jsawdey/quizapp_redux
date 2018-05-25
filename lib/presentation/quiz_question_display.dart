import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp_redux/model/question.dart';
import 'package:quizapp_redux/themes/quiz_theme.dart';

class QuizQuestionDisplay extends StatelessWidget {

  final String cvText;
  final String qaText;
  final int value;
  final VoidCallback onClickQA;
  final Function(ReportQuestionDialogResult) onReportAnswer;
  final Function(int, bool) onAnswerQuestion;

  QuizQuestionDisplay({
    @required this.cvText,
    @required this.qaText,
    @required this.value,
    @required this.onClickQA,
    @required this.onReportAnswer,
    @required this.onAnswerQuestion,
  });

  Future<Null> _askReportAnswer(BuildContext context) {
    showDialog<ReportQuestionDialogResult>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: const Text('Are you sure you want to report this question as invalid?'),
          children: <Widget>[
            new SimpleDialogOption(
              onPressed: () { Navigator.pop(context, ReportQuestionDialogResult.Yes); },
              child: const Text('Yes'),
            ),
            new SimpleDialogOption(
              onPressed: () { Navigator.pop(context, ReportQuestionDialogResult.No); },
              child: const Text('No'),
            ),
          ],
        );
      }
    ).then<void>((ReportQuestionDialogResult r) {
      onReportAnswer(r);
    });
    return null;
  }

  void _answerQuestion(BuildContext context, int value, bool correct) {
    onAnswerQuestion(value, correct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          flex: 2,
          child: new _QuizDecorationWrapper(
              new _QuestionCategoryWidget(cvText)),
        ),
        new Flexible(
          flex: 6,
          child: new Stack(
            children: <Widget>[
              new Positioned.fill(
                  child: new GestureDetector(
                    onTap: onClickQA,
                    child: new _QuizDecorationWrapper(new _QuestionAnswerWidget(
                        qaText)),
                  ),
              ),
              new Positioned(
                left: 8.0,
                bottom: 8.0,
                child: new FlatButton(
                    padding: const EdgeInsets.all(4.0),
                    onPressed: () { _askReportAnswer(context); },
                    child: new Text(
                      'Report Question',
                      style: new TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
        new Flexible(
          flex: 1,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.check),
                  color: Colors.white,
                  iconSize: 32.0,
                  splashColor: Colors.white,
                  onPressed: () { _answerQuestion(context, this.value, true); }
              ),
              new IconButton(
                  icon: new Icon(Icons.skip_next),
                  color: Colors.white,
                  iconSize: 32.0,
                  splashColor: Colors.white,
                  onPressed: () { _answerQuestion(context, 0, true); }
                  ),
              new IconButton(
                  icon: new Icon(Icons.close),
                  color: Colors.white,
                  iconSize: 32.0,
                  splashColor: Colors.white,
                  onPressed: () { _answerQuestion(context, this.value, false); }
              ),
            ],
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
        //constraints: new BoxConstraints.expand(),
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