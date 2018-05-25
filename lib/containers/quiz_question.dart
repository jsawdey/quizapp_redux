import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/selectors/selectors.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:quizapp_redux/presentation/quiz_question_display.dart';
import 'package:quizapp_redux/model/question.dart';

class QuizQuestion extends StatelessWidget {
  QuizQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        final q = vm.currentQuestion;
        return new QuizQuestionDisplay(
            cvText: q.category,
            qaText: vm.visibilityFilter == QAVisibilityFilter.ShowQuestion ?
              q.question : q.answer,
            value: q.value,
            onClickQA: vm.changeQAVisibilityCallback,
            onReportAnswer: vm.reportQuestionCallback,
            onAnswerQuestion: vm.answerQuestionCallback,
        );
      },
    );
  }
}

class _ViewModel {
  final Question currentQuestion;
  final QAVisibilityFilter visibilityFilter;
  final VoidCallback changeQAVisibilityCallback;
  final Function(ReportQuestionDialogResult) reportQuestionCallback;
  final Function(int, bool) answerQuestionCallback;

  _ViewModel({
    this.currentQuestion,
    this.visibilityFilter,
    this.changeQAVisibilityCallback,
    this.reportQuestionCallback,
    this.answerQuestionCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentQuestion: currentQuestionSelector(store.state),
      visibilityFilter: store.state.qaFilter,
      changeQAVisibilityCallback: () {
        store.dispatch(new ToggleQAScreenAction());
      },
      reportQuestionCallback: (result) {
        if (result == ReportQuestionDialogResult.Yes) {
          store.dispatch(new ReportQuestionAction());
        }
      },
      answerQuestionCallback: (value, correct) {
        store.dispatch(new MarkQuestionAnsweredAction(
            store.state.currentQuestionId,
            currentQuestionSelector(store.state).copyWith(answered: true))
        );
        store.dispatch(new UpdateScoreAction(value, correct));
      },
    );
  }
}