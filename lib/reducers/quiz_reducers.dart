import 'package:quizapp_redux/model/question.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';

final questionListReducer = combineReducers<List<Question>>([
  TypedReducer<List<Question>, QuestionsLoadedAction>(_newQuestionsLoaded),
  TypedReducer<List<Question>, MarkQuestionAnsweredAction>(_markQuestionAnswered),
]);

List<Question> _newQuestionsLoaded(List<Question> questions, action) {
  return action.questions;
}

List<Question> _markQuestionAnswered(List<Question> questions, action) {
  return questions
      .map<Question>((question) => question.id == action.questionId ? action.updatedQuestion : question)
      .toList();
}

final currentQuestionIdReducer = combineReducers<int>([
  TypedReducer<int, LoadQuestionByIdAction>(_loadQuestionById),
]);

int _loadQuestionById(int state, action) {
  return action.questionId;
}

final currentCategoryReducer = combineReducers<String>([
  TypedReducer<String, SelectCategoryAction>(_newCategorySelected),
]);

String _newCategorySelected(String state, action) {
  return action.selectedCategory;
}

final qaFilterReducer = combineReducers<QAVisibilityFilter>([
  TypedReducer<QAVisibilityFilter, ToggleQAScreenAction>(_toggleQAVisibility),
  TypedReducer<QAVisibilityFilter, MarkQuestionAnsweredAction>(_questionAnsweredVis),
]);

QAVisibilityFilter _toggleQAVisibility(QAVisibilityFilter state, action) {
  if (state == QAVisibilityFilter.ShowQuestion) {
    return QAVisibilityFilter.ShowAnswer;
  } else {
    return QAVisibilityFilter.ShowQuestion;
  }
}

QAVisibilityFilter _questionAnsweredVis(QAVisibilityFilter state, action) {
  return QAVisibilityFilter.ShowQuestion;
}

final scoreReducer = combineReducers<int>([
  TypedReducer<int, UpdateScoreAction>(_updateScore),
  TypedReducer<int, StartFirstRoundAction>(_newGame),
]);

int _updateScore(int state, action) {
  if (action.correct) {
    return state + action.questionValue;
  } else {
    return state - action.questionValue;
  }
}

int _newGame(int state, action) {
  return 0;
}

AppState quizAppReducer(AppState state, action) {
  return AppState(
    questions: questionListReducer(state.questions, action),
    currentQuestionId: currentQuestionIdReducer(state.currentQuestionId, action),
    currentCategory: currentCategoryReducer(state.currentCategory, action),
    qaFilter: qaFilterReducer(state.qaFilter, action),
    score: scoreReducer(state.score, action),
  );
}