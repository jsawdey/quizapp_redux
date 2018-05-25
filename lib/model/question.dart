import 'package:meta/meta.dart';

@immutable
class Question {
  final int id;
  final String question;
  final String answer;
  final int categoryId;
  final String category;
  final int value;
  final int airDate;
  final bool answered;

  Question({id, question, answer, categoryId, category, value, airDate, answered}) :
    id = id ?? 0,
    question = question ?? '',
    answer = answer ?? '',
    categoryId = categoryId ?? 0,
    category = category ?? '',
    value = value ?? 0,
    airDate = airDate ?? 0,
    answered = answered ?? 0;

  Question copyWith({id, question, answer, categoryId, category, value, airDate, answered}) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      value: value ?? this.value,
      airDate: airDate ?? this.airDate,
      answered: answered ?? this.answered,
    );
  }

  static Question fromJson(Map json) {
    return Question(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      categoryId: json['category_id'],
      category: json['category']['title'],
      value: json['value'],
      airDate: DateTime
          .parse(json['airdate'])
          .millisecondsSinceEpoch,
      answered: false,
    );
  }

  static Question fromCategoryJson(Map json, String category, {int value}) {
    return Question(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      categoryId: json['category_id'],
      category: category,
      value: value ?? json['value'],
      airDate: DateTime
          .parse(json['airdate'])
          .millisecondsSinceEpoch,
      answered: false,
    );
  }

  @override
  String toString() {
    return 'Question{id: $id, question: $question, answer: $answer, '
        'category: $category, value: $value, airDate: $airDate, '
        'answered: $answered}';
  }

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answer.hashCode ^
    category.hashCode ^ value.hashCode ^ airDate.hashCode ^ answered.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Question &&
    id == other.id &&
    question == other.question &&
    answer == other.answer &&
    category == other.category &&
    value == other.value &&
    airDate == other.airDate &&
    answered == other.answered;

}

enum ReportQuestionDialogResult {
  Yes, No
}

enum QAVisibilityFilter {
  ShowQuestion,
  ShowAnswer,
}