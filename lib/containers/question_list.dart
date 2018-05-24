import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/model/question.dart';
import 'package:quizapp_redux/presentation/question_list_display.dart';
import 'package:quizapp_redux/selectors/selectors.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/actions/actions.dart';

class QuestionList extends StatelessWidget {
  QuestionList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new QuestionListDisplay(
          vm.category,
          vm.questions,
          vm.onQuestionClickFunction,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Question> questions;
  final String category;
  final Function(int) onQuestionClickFunction;

  _ViewModel({
    @required this.questions,
    @required this.category,
    @required this.onQuestionClickFunction,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      questions: currCatQuestionsSelector(store.state),
      category: currentCategorySelector(store.state),
      onQuestionClickFunction: (id) {
        store.dispatch(new LoadQuestionByIdAction(id));
      },
    );
  }
}