import 'package:meta/meta.dart';
import 'package:quizapp_redux/model/question.dart';

@immutable
class AppState {
  final List<Question> questions;
  final int currentQuestionId;
  final String currentCategory;
  final QAVisibilityFilter qaFilter;
  final CatValVisibilityFilter cvFilter;
  final int score;

  AppState({
    this.questions = const [],
    this.currentQuestionId = 0,
    this.currentCategory = '',
    this.qaFilter = QAVisibilityFilter.ShowQuestion,
    this.cvFilter = CatValVisibilityFilter.ShowCategory,
    this.score,
  });

  AppState copyWith({
    List<Question> questions,
    int currentQuestionId,
    String currentCategory,
    QAVisibilityFilter qaFilter,
    CatValVisibilityFilter cvFilter,
    int score,
  }) {
    return AppState(
      questions: questions ?? this.questions,
      currentQuestionId: currentQuestionId ?? this.currentQuestionId,
      currentCategory: currentCategory ?? this.currentCategory,
      qaFilter: qaFilter ?? this.qaFilter,
      cvFilter: cvFilter ?? this.cvFilter,
      score: score ?? this.score,
    );
  }

  @override
  int get hashCode =>
    questions.hashCode ^
    currentQuestionId.hashCode ^
    currentCategory.hashCode ^
    qaFilter.hashCode ^
    cvFilter.hashCode ^
    score.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
      runtimeType == other.runtimeType &&
      questions == other.questions &&
      currentQuestionId == other.currentQuestionId &&
      currentCategory == other.currentCategory &&
      qaFilter == other.qaFilter &&
      cvFilter == other.cvFilter &&
      score == other.score;

  @override
  String toString() {
    return 'AppState{questions: $questions, '
        'currentQuestionId: $currentQuestionId, '
        'currentCategory: $currentCategory, '
        'qaFilter: $qaFilter, cvFilter: $cvFilter,'
        'score: $score}';
  }
}
