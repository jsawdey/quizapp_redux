import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/actions/quiz_question_actions.dart';
import 'package:quizapp_redux/presentation/quiz_question_display.dart';
import 'package:quizapp_redux/model/quiz.dart';

class QuizQuestion extends StatelessWidget {
  QuizQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        final q = vm.currentQuestion;
        return new QuizQuestionDisplay(
            q.category,
            !vm.showAnswer ? q.question : q.answer,
            vm.changeQAVisibilityCallback,
            vm.reportQuestionCallback
        );
      },
    );
  }
}

class _ViewModel {
  final Question currentQuestion;
  final bool showAnswer;
  final VoidCallback changeQAVisibilityCallback;
  final VoidCallback reportQuestionCallback;

  _ViewModel({
    this.currentQuestion,
    this.showAnswer,
    this.changeQAVisibilityCallback,
    this.reportQuestionCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentQuestion: store.state.currentQuestion,
      showAnswer: store.state.showAnswer,
      changeQAVisibilityCallback: () {
        bool currentShowAnswer = store.state.showAnswer;
        store.dispatch(currentShowAnswer ? new ShowCurrentQuestionAction() :
          new ShowCurrentAnswerAction());
      },
      reportQuestionCallback: () {
        store.dispatch(new ReportQuestionAction(store.state.currentQuestion.id,));
      },
    );
  }
}