import 'package:quizapp_redux/model/repository.dart';
import 'package:quizapp_redux/actions/quiz_question_actions.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final loadQuestion = _fetchQuestion();
  final reportQuestion = _reportQuestion();
  return [
    TypedMiddleware<AppState, InitAppAction>(loadQuestion),
    TypedMiddleware<AppState, LoadQuestionAction>(loadQuestion),
    TypedMiddleware<AppState, ReportQuestionAction>(reportQuestion),
  ];
}

Middleware<AppState> _fetchQuestion() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Repository.getRandomQuestion().then((question) {
      store.dispatch(new QuestionLoadedAction(question));
    });
  };
}

Middleware<AppState> _reportQuestion() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Repository.markQuestionInvalid(action.questionId).then((i) {
      store.dispatch(new LoadQuestionAction());
    });
  };
}