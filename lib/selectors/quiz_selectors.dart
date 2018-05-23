import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/model/quiz.dart';

List<Question> questionsSelector(AppState state) => state.questions;

Question currentQuestionSelector(AppState state) {
  if (state.questions.length > 0) {
    return state.questions[state.currentQuestionIndex];
  } else {
    return Question();
  }
}

List<String> categoryListSelector(AppState state) {
  List<String> result = [];
  for (Question q in state.questions) {
    if (!result.contains(q.category)) {
      result.add(q.category);
    }
  }
  return result;
}

int currentIndexSelector(AppState state) => state.currentQuestionIndex;

QAVisibilityFilter qaShownSelector(AppState state) => state.qaFilter;