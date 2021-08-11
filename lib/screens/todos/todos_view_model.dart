import 'package:flutter_redux_toolkit/redux/reducers/todos/actions/find_action.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/actions/insert_action.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/actions/remove_action.dart';

import '../../redux/reducers/todos/todos_model.dart';
import "package:built_collection/built_collection.dart";
import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';
import '../../redux/app_state.dart';
part 'todos_view_model.g.dart';

abstract class TodosViewModel
    implements Built<TodosViewModel, TodosViewModelBuilder> {
  BuiltList<TodoModel> get todos;

  @BuiltValueField(compare: false)
  void Function() get findTodos;

  @BuiltValueField(compare: false)
  void Function(TodoModel) get insertTodo;

  @BuiltValueField(compare: false)
  void Function(String) get removeTodo;

  TodosViewModel._();
  factory TodosViewModel([void Function(TodosViewModelBuilder) updates]) =
      _$TodosViewModel;

  static TodosViewModel fromStore(Store<AppState> store) {
    return TodosViewModel((viewModel) => viewModel
      ..insertTodo = insertActionCreator.doActionCreator(store)
      ..removeTodo = removeActionCreator.doActionCreator(store)
      ..findTodos = findActionCreator.doActionCreator(store)
      ..todos = ListBuilder(store.state.todoState as Iterable<dynamic>));
  }
}
