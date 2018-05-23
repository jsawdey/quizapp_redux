import 'package:quizapp_redux/model/quiz.dart';

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

class NextQuestionAction {}

class QuestionLoadedAction{
  final Question currentQuestion;

  QuestionLoadedAction(this.currentQuestion);

  @override
  String toString() {
    return 'QuestionLoadedAction{currentQuestion:$currentQuestion}';
  }
}

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