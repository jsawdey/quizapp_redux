import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/presentation/quiz_question_list_display.dart';
import 'package:quizapp_redux/selectors/quiz_selectors.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:quizapp_redux/model/quiz.dart';

class QuizQuestionList extends StatelessWidget {
  QuizQuestionList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new QuizQuestionListDisplay(
          vm.categories
        );
      },
    );
  }
}

class _ViewModel {
  final List<String> categories;

  _ViewModel({
    @required this.categories
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      categories: categoryListSelector(store.state),
    );
  }
}