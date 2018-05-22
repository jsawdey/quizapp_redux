class Question {
  final int id;
  final String question;
  final String answer;
  final String category;
  final int value;
  final int airDate;

  Question({id, question, answer, category, value, airDate}) :
    id = id ?? 0,
    question = question ?? '',
    answer = answer ?? '',
    category = category ?? '',
    value = value ?? 0,
    airDate = airDate ?? 0;

  @override
  String toString() {
    return 'Question{id: $id, question:$question, answer:$answer, '
        'category:$category, value:$value, airDate:$airDate}';
  }

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answer.hashCode ^
    category.hashCode ^ value.hashCode ^ airDate.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Question &&
    id == other.id &&
    question == other.question &&
    answer == other.answer &&
    category == other.category &&
    value == other.value &&
    airDate == other.airDate;

}

enum ReportDialogState {
  Shown, Hidden
}

enum ReportDialogAnswer {
  Yes, No
}