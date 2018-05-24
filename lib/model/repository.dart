import 'dart:async';
import 'package:quizapp_redux/model/networking/api.dart';
import 'package:quizapp_redux/model/question.dart';
import 'dart:math';

enum Round {
  First, Final
}

class Repository {

  static final _RndNbrGen = new Random(new DateTime.now().millisecondsSinceEpoch);

  static Future<List<Question>> getRandomQuestions(int count) async {
    int goodQuestionCount = 0;
    List<Question> result = [];
    var jsonResponse;
    do {
      jsonResponse = await JServiceAPI.getRandomQuestions(
          count-goodQuestionCount);
      for (Map q in jsonResponse) {
        if (q['invalid_count'] == null &&
            q['question'].toString().trim().isNotEmpty &&
            q['answer'].toString().trim().isNotEmpty
        ) {
          goodQuestionCount++;
          result.add(Question.fromJson(q));
        }
      }
    } while (goodQuestionCount < count);
    return result;
  }

  static Future<List<Question>> getFirstRoundQuestions({int count = 6}) async {
    List<Question> testQuestions = [];
    List<Question> result = [];
    for (int i = 0; i < count; i++) {
      int random = _RndNbrGen.nextInt(9744);
      var jsonResponse = await JServiceAPI.getQuestion(100, random);
      testQuestions.add(Question.fromJson(jsonResponse));
    }
    for (int i = 0; i < testQuestions.length; i++) {
      var jsonResponse = await JServiceAPI.getCategoryQuestions(
          testQuestions[i].categoryId);
      result..addAll(_createRoundFromCategoryJson(jsonResponse, Round.First));
    }
    return result;
  }

  static Future<List<Question>> getFinalRoundQuestions({int count = 6}) async {
    List<Question> testQuestions = [];
    List<Question> result = [];
    for (int i = 0; i < count; i++) {
      int random = _RndNbrGen.nextInt(9744);
      var jsonResponse = await JServiceAPI.getQuestion(1000, random);
      testQuestions.add(Question.fromJson(jsonResponse));
    }
    for (int i = 0; i < testQuestions.length; i++) {
      var jsonResponse = await JServiceAPI.getCategoryQuestions(
          testQuestions[i].categoryId);
      result.addAll(_createRoundFromCategoryJson(jsonResponse, Round.Final));
    }
    return result;
  }

  static List<Question> _createRoundFromCategoryJson(Map categoryJson,
      Round roundType) {
    String categoryName = categoryJson['title'];
    List<Question> result = [];
    List clues = categoryJson['clues'];
    List firstLevel = clues.where((l) => l['value'] == (roundType == Round.First ? 100 : 200)).toList();
    List secondLevel = clues.where((l) => l['value'] == (roundType == Round.First ? 200 : 400)).toList();
    List thirdLevel = clues.where((l) => l['value'] == (roundType == Round.First ? 300 : 600)).toList();
    List fourthLevel = clues.where((l) => l['value'] == (roundType == Round.First ? 400 : 800)).toList();
    List fifthLevel = clues.where((l) => l['value'] == (roundType == Round.First ? 500 : 1000)).toList();
    try {
      int firstLevelRndIndex = firstLevel.length == 1 ? 0 : _RndNbrGen.nextInt(
          firstLevel.length);
      int secondLevelRndIndex = secondLevel.length == 1 ? 0 : _RndNbrGen
          .nextInt(secondLevel.length);
      int thirdLevelRndIndex = thirdLevel.length == 1 ? 0 : _RndNbrGen.nextInt(
          thirdLevel.length);
      int fourthLevelRndIndex = fourthLevel.length == 1 ? 0 : _RndNbrGen
          .nextInt(fourthLevel.length);
      int fifthLevelRndIndex = fifthLevel.length == 1 ? 0 : _RndNbrGen.nextInt(
          fifthLevel.length);
      result.add(Question.fromCategoryJson(
          firstLevel[firstLevelRndIndex], categoryName));
      result.add(Question.fromCategoryJson(
          secondLevel[secondLevelRndIndex], categoryName));
      result.add(Question.fromCategoryJson(
          thirdLevel[thirdLevelRndIndex], categoryName));
      result.add(Question.fromCategoryJson(
          fourthLevel[fourthLevelRndIndex], categoryName));
      result.add(Question.fromCategoryJson(
          fifthLevel[fifthLevelRndIndex], categoryName));
    } catch(e) {
      print('firstLevel: $firstLevel');
      print('secondLevel: $secondLevel');
      print('thirdLevel: $thirdLevel');
      print('fourthLevel: $fourthLevel');
      print('fifthLevel: $fifthLevel');
    }
    return result;
  }

  static Future<Null> markQuestionInvalid(int id) async {
    var response = await JServiceAPI.markJServiceQuestionInvalid(id);
  }
}