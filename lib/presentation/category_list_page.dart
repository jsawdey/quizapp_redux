import 'package:flutter/material.dart';
import 'package:quizapp_redux/containers/category_list.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/actions/actions.dart';
import 'package:quizapp_redux/selectors/selectors.dart';

class CategoryListPage extends StatelessWidget {
  final String title;
  CategoryListPage({this.title});

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
      onInit: (store) => store.dispatch(new StartFirstRoundAction()),
      builder: (context, Store<AppState> store) => new Scaffold(
        appBar: new AppBar(
          centerTitle: false,
          title: new Text('Score: \$' + store.state.score.toString()),
          actions: <Widget>[
            new FlatButton(
                onPressed: () { store.dispatch(new StartFirstRoundAction()); },
                child: new Text(
                  'New Game',
                  style: Theme.of(context).textTheme.subhead,
                ),
            )
          ],
        ),
        body: new CategoryList(),
        floatingActionButton: unansweredCategorySelector(store.state).length == 0
          ? new FloatingActionButton(
          onPressed: () { store.dispatch(new StartFinalRoundAction()); },
          tooltip: 'Start Second Round',
          child: new Icon(Icons.fast_forward),
        ) : null,
      ),
    );
  }
}

