import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quizapp_redux/presentation/category_list_display.dart';
import 'package:quizapp_redux/selectors/selectors.dart';
import 'package:redux/redux.dart';
import 'package:quizapp_redux/model/app_state.dart';
import 'package:quizapp_redux/actions/actions.dart';

class CategoryList extends StatelessWidget {
  CategoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new CategoryListDisplay(
          vm.categories,
          vm.onCategoryClickFunction,
        );
      },
    );
  }
}

class _ViewModel {
  final List<String> categories;
  final Function(String) onCategoryClickFunction;

  _ViewModel({
    @required this.categories,
    @required this.onCategoryClickFunction,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    //Set<String> cats = Set.from(store.state.questions.map((q) => q.category.toUpperCase()));
    return _ViewModel(
      categories: categoriesSelector(store.state),// cats.toList(),
      onCategoryClickFunction: (category) {
        store.dispatch(new SelectCategoryAction(category));
      },
    );
  }
}