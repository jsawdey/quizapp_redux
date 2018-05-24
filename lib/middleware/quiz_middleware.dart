import 'package:quizapp_redux/model/repository.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final reportQuestion = _reportQuestion();
  final fetchQuestions = _fetchQuestions();
  final checkQuestionIndex = _checkQuestionIndex();
  final firstRound = _getFirstRoundQuestions();
  final finalRound = _getFinalRoundQuestions();
  return [
    TypedMiddleware<AppState, FetchQuestionsAction>(fetchQuestions),
    TypedMiddleware<AppState, NextQuestionAction>(checkQuestionIndex),
    TypedMiddleware<AppState, ReportQuestionAction>(reportQuestion),
    TypedMiddleware<AppState, StartFirstRoundAction>(firstRound),
    TypedMiddleware<AppState, StartFinalRoundAction>(finalRound),
  ];
}

Middleware<AppState> _fetchQuestions() {
  return (Store<AppState> store, action, NextDispatcher next) {
    Repository.getRandomQuestions(action.requestCount).then((questions) {
      store.dispatch(new QuestionsLoadedAction(questions));
    });
  };
}

Middleware<AppState> _checkQuestionIndex() {
  return (Store<AppState> store, action, NextDispatcher next) {
    int currIndex = store.state.currentQuestionIndex;
    if (currIndex + 1 < store.state.questions.length) {
      next(action);
    } else {
      store.dispatch(new FetchQuestionsAction(store.state.fetchQuestionCount));
    }
  };
}

Middleware<AppState> _reportQuestion() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Repository.markQuestionInvalid(store.state.currentQuestionId).then((i) {
      store.dispatch(new FetchQuestionsAction(store.state.fetchQuestionCount));
    });
  };
}

Middleware<AppState> _getFirstRoundQuestions() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Repository.getFirstRoundQuestions().then((questions) {
      store.dispatch(new QuestionsLoadedAction(questions));
    });
  };
}

Middleware<AppState> _getFinalRoundQuestions() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Repository.getFinalRoundQuestions().then((questions) {
      store.dispatch(new QuestionsLoadedAction(questions));
    });
  };
}