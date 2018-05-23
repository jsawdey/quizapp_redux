import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/selectors/quiz_selectors.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/actions/actions.dart';
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
            cvText: vm.catValVisibilityFilter == CatValVisibilityFilter.ShowCategory ?
              q.category : '\$' + '${q.value.toString()}',
            qaText: vm.visibilityFilter == QAVisibilityFilter.ShowQuestion ?
              q.question : q.answer,
            onClickQA: vm.changeQAVisibilityCallback,
            onClickCV: vm.changedCVVisibilityCallback,
            onReportAnswer: vm.reportQuestionCallback
        );
      },
    );
  }
}

class _ViewModel {
  final Question currentQuestion;
  final QAVisibilityFilter visibilityFilter;
  final CatValVisibilityFilter catValVisibilityFilter;
  final VoidCallback changeQAVisibilityCallback;
  final VoidCallback changedCVVisibilityCallback;
  final Function(ReportQuestionDialogResult) reportQuestionCallback;

  _ViewModel({
    this.currentQuestion,
    this.visibilityFilter,
    this.catValVisibilityFilter,
    this.changeQAVisibilityCallback,
    this.changedCVVisibilityCallback,
    this.reportQuestionCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    Question q = currentQuestionSelector(store.state);
    return _ViewModel(
      currentQuestion: q,
      visibilityFilter: store.state.qaFilter,
      catValVisibilityFilter: store.state.cvFilter,
      changeQAVisibilityCallback: () {
        store.dispatch(new ToggleQAScreenAction());
      },
      changedCVVisibilityCallback: () {
        store.dispatch(new ToggleCVScreenAction());
      },
      reportQuestionCallback: (result) {
        if (result == ReportQuestionDialogResult.Yes) {
          store.dispatch(new ReportQuestionAction(q.id,));
        }
      },
    );
  }
}