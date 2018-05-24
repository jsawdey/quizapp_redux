import 'package:flutter/material.dart';
import 'package:quizapp_redux/containers/question_list.dart';

class QuestionListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select a question value'),
      ),
      body: new QuestionList(),
    );
  }
}