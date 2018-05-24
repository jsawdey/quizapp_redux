import 'package:meta/meta.dart';
import 'package:quizapp_redux/model/question.dart';

@immutable
class AppState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int currentQuestionId;
  final String currentCategory;
  final QAVisibilityFilter qaFilter;
  final CatValVisibilityFilter cvFilter;
  final int fetchQuestionCount;

  AppState({
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.currentQuestionId = 0,
    this.currentCategory = '',
    this.qaFilter = QAVisibilityFilter.ShowQuestion,
    this.cvFilter = CatValVisibilityFilter.ShowCategory,
    this.fetchQuestionCount = 20,
  });

  AppState copyWith({
    List<Question> questions,
    int currentQuestionIndex,
    int currentQuestionId,
    String currentCategory,
    QAVisibilityFilter qaFilter,
    CatValVisibilityFilter cvFilter,
    int fetchQuestionCount,
  }) {
    return AppState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentQuestionId: currentQuestionId ?? this.currentQuestionId,
      currentCategory: currentCategory ?? this.currentCategory,
      qaFilter: qaFilter ?? this.qaFilter,
      cvFilter: cvFilter ?? this.cvFilter,
      fetchQuestionCount: fetchQuestionCount ?? this.fetchQuestionCount,
    );
  }

  @override
  int get hashCode =>
    questions.hashCode ^
    currentQuestionIndex.hashCode ^
    currentQuestionId.hashCode ^
    currentCategory.hashCode ^
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
      currentQuestionId == other.currentQuestionId &&
      currentCategory == other.currentCategory &&
      qaFilter == other.qaFilter &&
      cvFilter == other.cvFilter &&
      fetchQuestionCount == other.fetchQuestionCount;

  @override
  String toString() {
    return 'AppState{questions: $questions, '
        'currentQuestionIndex: $currentQuestionIndex, '
        'currentQuestionId: $currentQuestionId, '
        'currentCategory: $currentCategory, '
        'qaFilter: $qaFilter, cvFilter: $cvFilter, '
        'fetchQuestionCount: $fetchQuestionCount}';
  }
}
