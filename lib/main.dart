import 'package:flutter/material.dart';
import 'package:quizapp_redux/presentation/category_list_page.dart';
import 'package:quizapp_redux/presentation/quiz_question_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/reducers/quiz_reducers.dart';
import 'package:quizapp_redux/middleware/quiz_middleware.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final Store store = new Store<AppState>(
    quizAppReducer,
    initialState: new AppState(),
    middleware: createStoreMiddleware(),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Random Trivia Question',
        theme: new ThemeData(
          primarySwatch: Colors.green,
          canvasColor: Colors.black87,
        ),
        home: new CategoryListPage(title: 'Pick a category'),
      ),
    );
  }
}