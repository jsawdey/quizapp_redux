import 'package:flutter/material.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:quizapp_redux/containers/quiz_question.dart';

class QuizQuestionPage extends StatelessWidget {
  final String title;
  QuizQuestionPage({this.title});

  @override
  Widget build(BuildContext context) {
    return //new StoreBuilder(
      //onInit: (store) => store.dispatch(new FetchQuestionsAction(20)),
      //builder: (context, Store<AppState> store) =>
    new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new QuizQuestion(),
        //floatingActionButton: new FloatingActionButton(
        //  onPressed: () { store.dispatch(new NextQuestionAction()); },
        //  tooltip: 'Get New Question',
        //  child: new Icon(Icons.refresh),
        //),
      //),
    );
  }
}

