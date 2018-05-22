import 'package:meta/meta.dart';
import 'package:quizapp_redux/model/quiz.dart';

@immutable
class AppState {
  final Question currentQuestion;
  final bool showAnswer;

  AppState({this.currentQuestion, this.showAnswer});

  AppState copyWith({Question currentQuestion}) {
    return AppState(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      showAnswer: showAnswer ?? this.showAnswer,
    );
  }
}
