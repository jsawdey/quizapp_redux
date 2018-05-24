import 'package:quizapp_redux/model/question.dart';

class FetchQuestionsAction {
  final int requestCount;
  FetchQuestionsAction(this.requestCount);

  @override
  String toString() {
    return 'FetchQuestionsAction{requestCount: $requestCount}';
  }
}

class QuestionsLoadedAction {
  final List<Question> questions;
  QuestionsLoadedAction(this.questions);

  @override
  String toString() {
    return 'QuestionsLoadedAction{questions: $questions}';
  }
}

class LoadQuestionByIdAction {
  final int questionId;
  LoadQuestionByIdAction(this.questionId);

  @override
  String toString() {
    return 'LoadQuestionById{questionId: $questionId}';
  }
}

class NextQuestionAction {}

class ToggleQAScreenAction {}
class ToggleCVScreenAction {}

class ReportQuestionAction {
  final int questionId;
  ReportQuestionAction(this.questionId);

  @override
  String toString() {
    return 'ReportQuestionAction{questionId:$questionId}';
  }
}

class StartFirstRoundAction {}
class StartFinalRoundAction {}

class SelectCategoryAction {
  final String selectedCategory;
  SelectCategoryAction(this.selectedCategory);

  @override
  String toString() {
    return 'SelectCategoryAction{selectedCategory: $selectedCategory}';
  }
}