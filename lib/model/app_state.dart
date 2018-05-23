import 'package:meta/meta.dart';
import 'package:quizapp_redux/model/quiz.dart';

@immutable
class AppState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final QAVisibilityFilter qaFilter;
  final CatValVisibilityFilter cvFilter;
  final int fetchQuestionCount;

  AppState({
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.qaFilter = QAVisibilityFilter.ShowQuestion,
    this.cvFilter = CatValVisibilityFilter.ShowCategory,
    this.fetchQuestionCount = 20,
  });

  AppState copyWith({
    List<Question> questions,
    int currentQuestionIndex,
    QAVisibilityFilter qaFilter,
    CatValVisibilityFilter cvFilter,
    int fetchQuestionCount,
  }) {
    return AppState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      qaFilter: qaFilter ?? this.qaFilter,
      cvFilter: cvFilter ?? this.cvFilter,
      fetchQuestionCount: fetchQuestionCount ?? this.fetchQuestionCount,
    );
  }

  @override
  int get hashCode =>
    questions.hashCode ^
    currentQuestionIndex.hashCode ^
    qaFilter.hashCode ^
    cvFilter.hashCode ^
    fetchQuestionCount;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
      runtimeType == other.runtimeType &&
      questions == other.questions &&
      currentQuestionIndex == other.currentQuestionIndex &&
      qaFilter == other.qaFilter &&
      cvFilter == other.cvFilter &&
      fetchQuestionCount == other.fetchQuestionCount;

  @override
  String toString() {
    return 'AppState{questions: $questions, '
        'currentQuestionIndex: $currentQuestionIndex, '
        'qaFilter: $qaFilter, cvFilter: $cvFilter, '
        'fetchQuestionCount: $fetchQuestionCount}';
  }
}
