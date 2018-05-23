class Question {
  final int id;
  final String question;
  final String answer;
  final int categoryId;
  final String category;
  final int value;
  final int airDate;

  Question({id, question, answer, categoryId, category, value, airDate}) :
    id = id ?? 0,
    question = question ?? '',
    answer = answer ?? '',
    categoryId = categoryId ?? 0,
    category = category ?? '',
    value = value ?? 0,
    airDate = airDate ?? 0;

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
    );
  }

  static Question fromCategoryJson(Map json, String category) {
    return Question(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      categoryId: json['category_id'],
      category: category,
      value: json['value'],
      airDate: DateTime
          .parse(json['airdate'])
          .millisecondsSinceEpoch,
    );
  }

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

enum QAVisibilityFilter {
  ShowQuestion,
  ShowAnswer,
}

enum CatValVisibilityFilter {
  ShowCategory,
  ShowValue,
}