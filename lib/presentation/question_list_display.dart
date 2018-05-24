import 'package:flutter/material.dart';
import 'package:quizapp_redux/model/question.dart';
import 'package:quizapp_redux/themes/quiz_theme.dart';
import 'package:quizapp_redux/presentation/quiz_question_page.dart';

class QuestionListDisplay extends StatelessWidget {
  final String category;
  final List<Question> questions;
  final Function(int) questionOnClickFunction;
  QuestionListDisplay(
      @required this.category,
      @required this.questions,
      @required this.questionOnClickFunction,
      );

  void _onCategoryTap(BuildContext context, int questionId,
      String value) {
    questionOnClickFunction(questionId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => QuizQuestionPage(
          title: '${this.category.toUpperCase()} - $value'
        )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new _QuizDecorationWrapper(
          new Text(
            category,
            style: QuizQuestionTheme.categoryTextTheme(),
          )
        ),
        new Expanded(
          child: new ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () => _onCategoryTap(context, questions[index].id, '\$' + questions[index].value.toString()),
                  child: new _QuizDecorationWrapper(
                      new Text(
                        '\$' + questions[index].value.toString(),
                        style: QuizQuestionTheme.categoryTextTheme(),
                      )
                  ),
                );
              }
          ),
        ),
      ],
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
