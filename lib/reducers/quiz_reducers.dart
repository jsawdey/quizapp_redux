import 'package:quizapp_redux/model/quiz.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';

final questionListReducer = combineReducers<List<Question>>([
  TypedReducer<List<Question>, QuestionsLoadedAction>(_newQuestionsLoaded),
]);

List<Question> _newQuestionsLoaded(List<Question> state, action) {
  return action.questions;
}

final questionIndexReducer = combineReducers<int>([
  TypedReducer<int, QuestionLoadedAction>(_fetchNewQuestions),
  TypedReducer<int, NextQuestionAction>(_nextQuestion),
]);

int _fetchNewQuestions(int state, action) {
  return 0;
}

int _nextQuestion(int state, action) {
  return ++state;
}

final qaFilterReducer = combineReducers<QAVisibilityFilter>([
  TypedReducer<QAVisibilityFilter, QuestionLoadedAction>(_newQuestionQA),
  TypedReducer<QAVisibilityFilter, ToggleQAScreenAction>(_toggleQAVisibility),
]);

QAVisibilityFilter _newQuestionQA(QAVisibilityFilter state, action) {
  return QAVisibilityFilter.ShowQuestion;
}

QAVisibilityFilter _toggleQAVisibility(QAVisibilityFilter state, action) {
  if (state == QAVisibilityFilter.ShowQuestion) {
    return QAVisibilityFilter.ShowAnswer;
  } else {
    return QAVisibilityFilter.ShowQuestion;
  }
}

final cvFilterReducer = combineReducers<CatValVisibilityFilter>([
  TypedReducer<CatValVisibilityFilter, QuestionLoadedAction>(_newQuestionCV),
  TypedReducer<CatValVisibilityFilter, ToggleCVScreenAction>(_toggleCVVisibility),
]);

CatValVisibilityFilter _newQuestionCV(CatValVisibilityFilter state, action) {
  return CatValVisibilityFilter.ShowCategory;
}

CatValVisibilityFilter _toggleCVVisibility(CatValVisibilityFilter state, action) {
  if (state == CatValVisibilityFilter.ShowCategory) {
    return CatValVisibilityFilter.ShowValue;
  } else {
    return CatValVisibilityFilter.ShowCategory;
  }
}

AppState quizAppReducer(AppState state, action) {
  return AppState(
    questions: questionListReducer(state.questions, action),
    currentQuestionIndex: questionIndexReducer(state.currentQuestionIndex, action),
    qaFilter: qaFilterReducer(state.qaFilter, action),
    cvFilter: cvFilterReducer(state.cvFilter, action),
  );
}