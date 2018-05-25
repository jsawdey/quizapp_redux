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
      .map((question) => question.id == action.questionId ? action.updatedQuestion : question)
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
]);

QAVisibilityFilter _toggleQAVisibility(QAVisibilityFilter state, action) {
  if (state == QAVisibilityFilter.ShowQuestion) {
    return QAVisibilityFilter.ShowAnswer;
  } else {
    return QAVisibilityFilter.ShowQuestion;
  }
}

final cvFilterReducer = combineReducers<CatValVisibilityFilter>([
  TypedReducer<CatValVisibilityFilter, ToggleCVScreenAction>(_toggleCVVisibility),
]);

CatValVisibilityFilter _toggleCVVisibility(CatValVisibilityFilter state, action) {
  if (state == CatValVisibilityFilter.ShowCategory) {
    return CatValVisibilityFilter.ShowValue;
  } else {
    return CatValVisibilityFilter.ShowCategory;
  }
}

final scoreReducer = combineReducers<int>([
  TypedReducer<int, UpdateScoreAction>(_updateScore),
]);

int _updateScore(int state, action) {
  if (action.correct) {
    return state + action.questionValue;
  } else {
    return state - action.questionValue;
  }
}

AppState quizAppReducer(AppState state, action) {
  return AppState(
    questions: questionListReducer(state.questions, action),
    currentQuestionId: currentQuestionIdReducer(state.currentQuestionId, action),
    currentCategory: currentCategoryReducer(state.currentCategory, action),
    qaFilter: qaFilterReducer(state.qaFilter, action),
    cvFilter: cvFilterReducer(state.cvFilter, action),
    score: scoreReducer(state.score, action),
  );
}