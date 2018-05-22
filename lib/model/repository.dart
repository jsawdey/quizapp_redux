import 'dart:async';
import 'package:quizapp_redux/model/networking/api.dart';
import 'package:quizapp_redux/model/quiz.dart';


class Repository {

  static Future<Question> getRandomQuestion() async {
    int invalidCount = 0;
    var jsonResponse;
    do {
      jsonResponse = await JServiceAPI.getRandomJServiceAPIQuestions(1);
      try {
        invalidCount = int.parse(jsonResponse[0]['invalid_count'] ?? '0');
      } catch (e) {
        print(e.toString());
        print(jsonResponse[0]['invalid_count']);
        invalidCount = 1;
      }
    } while (invalidCount >= 1);
    Map qJson = jsonResponse[0];
    return Question(
        id: qJson['id'],
        question: qJson['question'],
        answer: qJson['answer'],
        category: qJson['category']['title'],
        value: qJson['value'],
        airDate: DateTime.parse(qJson['airdate']).millisecondsSinceEpoch,
    );
  }

  static Future<Null> markQuestionInvalid(int id) async {
    var response = await JServiceAPI.markJServiceQuestionInvalid(id);
  }
}