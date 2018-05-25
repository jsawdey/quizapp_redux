import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/model/question.dart';

Question currentQuestionSelector(AppState state) =>
    state.questions.firstWhere((q) => q.id == state.currentQuestionId);

List<String> unansweredCategorySelector(AppState state) {
  Set<String> cats = Set.from(state.questions.where((q) => !q.answered).map((q) => q.category.toUpperCase()));
  return cats.toList(growable: false);
}

String currentCategorySelector(AppState state) => state.currentCategory.toUpperCase();

List<Question> currCatQuestionsSelector(AppState state) =>
    state.questions.where((q) => q.category.toUpperCase() ==
    state.currentCategory.toUpperCase() && !q.answered).toList();