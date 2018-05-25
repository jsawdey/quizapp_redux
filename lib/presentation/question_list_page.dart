import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/containers/question_list.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:redux/redux.dart';

class QuestionListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
      builder: (context, Store<AppState> store) => new Scaffold(
        appBar: new AppBar(
          centerTitle: false,
          title: new Text('Score: \$' + store.state.score.toString()),
        ),
        body: new QuestionList(),
      ),
    );
  }
}