import 'package:todos_app/redux/app_state.dart';
import "package:built_collection/built_collection.dart";
import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';
import 'package:todos_app/screens/todos/reducer/actions/find_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/insert_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/remove_action.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

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
      ..insertTodo = insertActionHelper.doActionCreator(store)
      ..removeTodo = removeActionHelper.doActionCreator(store)
      ..findTodos = findActionHelper.doActionCreator(store)
      ..todos = ListBuilder(store.state.todoState?.model as Iterable<dynamic>));
  }
}
