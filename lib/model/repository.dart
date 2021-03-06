import 'dart:async';
import 'package:quizapp_redux/model/networking/api.dart';
import 'package:quizapp_redux/model/question.dart';
import 'dart:math';

enum Round {
  First, Final
}

class Repository {

  static final _rndNbrGen = new Random(new DateTime.now().millisecondsSinceEpoch);

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
      int random = _rndNbrGen.nextInt(9744);
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
      int random = _rndNbrGen.nextInt(9744);
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
    if (firstLevel.length == 0) {
      firstLevel..addAll(clues.where((l) => l['value'] == null));
    } else if (secondLevel.length == 0) {
      secondLevel..addAll(clues.where((l) => l['value'] == null));
    } else if (thirdLevel.length == 0) {
      thirdLevel..addAll(clues.where((l) => l['value'] == null));
    } else if (fourthLevel.length == 0) {
      fourthLevel..addAll(clues.where((l) => l['value'] == null));
    } else if (fifthLevel.length == 0) {
      fifthLevel..addAll(clues.where((l) => l['value'] == null));
    }
    // Add the random first level question
    try {
      int firstLevelRndIndex = firstLevel.length == 1 ? 0 : _rndNbrGen.nextInt(
          firstLevel.length);
      result.add(Question.fromCategoryJson(
          firstLevel[firstLevelRndIndex], categoryName,
          value: roundType == Round.First ? 100 : 200));
    } catch (e) {
      print(e.toString());
      print('firstLevel: $firstLevel');
    }
    // Add the random second level question
    try {
      int secondLevelRndIndex = secondLevel.length == 1 ? 0 : _rndNbrGen
          .nextInt(secondLevel.length);
      result.add(Question.fromCategoryJson(
          secondLevel[secondLevelRndIndex], categoryName,
          value: roundType == Round.First ? 200 : 400));
    } catch (e) {
      print(e.toString());
      print('secondLevel: $secondLevel');
    }
    // Add the random third level question
    try {
      int thirdLevelRndIndex = thirdLevel.length == 1 ? 0 : _rndNbrGen.nextInt(
          thirdLevel.length);
      result.add(Question.fromCategoryJson(
          thirdLevel[thirdLevelRndIndex], categoryName,
          value: roundType == Round.First ? 300 : 600));
    } catch (e) {
      print(e.toString());
      print('thirdLevel: $thirdLevel');
    }
    // Add the random fourth level question
    try {
      int fourthLevelRndIndex = fourthLevel.length == 1 ? 0 : _rndNbrGen
          .nextInt(fourthLevel.length);
      result.add(Question.fromCategoryJson(
          fourthLevel[fourthLevelRndIndex], categoryName,
          value: roundType == Round.First ? 400 : 800));
    } catch (e) {
      print(e.toString());
      print('fourthLevel: $fourthLevel');
    }
    // Add the random fifth level question
    try {
      int fifthLevelRndIndex = fifthLevel.length == 1 ? 0 : _rndNbrGen.nextInt(
          fifthLevel.length);
      result.add(Question.fromCategoryJson(
          fifthLevel[fifthLevelRndIndex], categoryName,
          value: roundType == Round.First ? 500 : 1000));
    } catch (e) {
      print(e.toString());
      print('fifthLevel: $fifthLevel');
    }
    return result;
  }

  static Future<Null> markQuestionInvalid(int id) async {
    await JServiceAPI.markJServiceQuestionInvalid(id);
    return null;
  }
}