import 'package:quizapp_redux/model/question.dart';

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

class MarkQuestionAnsweredAction {
  final int questionId;
  final Question updatedQuestion;
  MarkQuestionAnsweredAction(this.questionId, this.updatedQuestion);

  @override
  String toString() {
    return 'MarkQuestionAnsweredAction{questionId: $questionId, updatedQuestion: $updatedQuestion}';
  }
}

class ToggleQAScreenAction {}

class ReportQuestionAction {}

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

class UpdateScoreAction {
  final int questionValue;
  final bool correct;
  UpdateScoreAction(this.questionValue, this.correct);

  @override
  String toString() {
    return 'UpdateScoreAction{questionValue: $questionValue, correct: $correct}';
  }
}