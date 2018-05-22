import 'package:quizapp_redux/model/quiz.dart';
import 'package:quizapp_redux/actions/quiz_question_actions.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';

final quizReducer = combineReducers<Question>([
  TypedReducer<Question, QuestionLoadedAction>(_setLoadedQuestion),
]);

Question _setLoadedQuestion(Question question, QuestionLoadedAction action) {
  return action.currentQuestion;
}

final showQAReducer = combineReducers<bool>([
  TypedReducer<bool, QuestionLoadedAction>(_showCurrentQuestion),
  TypedReducer<bool, ShowCurrentQuestionAction>(_showCurrentQuestion),
  TypedReducer<bool, ShowCurrentAnswerAction>(_showCurrentAnswer),
]);

bool _showCurrentQuestion(bool state, action) {
  return false;
}

bool _showCurrentAnswer(bool state, action) {
  return true;
}

AppState quizAppReducer(AppState state, action) {
  return AppState(
    currentQuestion: quizReducer(state.currentQuestion, action),
    showAnswer: showQAReducer(state.showAnswer, action),
  );
}