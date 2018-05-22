import 'package:quizapp_redux/model/quiz.dart';

class InitAppAction {}

class LoadQuestionAction {}

class ReportQuestionAction {
  final int questionId;
  ReportQuestionAction(this.questionId);

  @override
  String toString() {
    return 'ReportQuestionAction{questionId:$questionId}';
  }
}

class QuestionLoadedAction{
  final Question currentQuestion;

  QuestionLoadedAction(this.currentQuestion);

  @override
  String toString() {
    return 'QuestionLoadedAction{currentQuestion:$currentQuestion}';
  }
}

class ShowCurrentQuestionAction {}
class ShowCurrentAnswerAction {}