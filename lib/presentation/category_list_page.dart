import 'package:flutter/material.dart';
import 'package:quizapp_redux/containers/category_list.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/actions/actions.dart';

class CategoryListPage extends StatelessWidget {
  final String title;
  CategoryListPage({this.title});

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
      onInit: (store) => store.dispatch(new StartFirstRoundAction()),
      builder: (context, Store<AppState> store) => new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new CategoryList(),
        floatingActionButton: new FloatingActionButton(
          onPressed: () { store.dispatch(new StartFinalRoundAction()); },
          tooltip: 'Get New Question',
          child: new Icon(Icons.refresh),
        ),
      ),
    );
  }
}

