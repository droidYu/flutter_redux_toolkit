import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:redux/redux.dart';
import 'package:todos_app/screens/todos/reducer/actions/find_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/insert_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/remove_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/update_action.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

final todoReducer = combineReducers<State<List<TodoModel>>>([
  ...findActionHelper.reducers(),
  ...insertActionHelper.reducers(),
  ...removeActionHelper.reducers(),
  ...updateActionHelper.reducers(),
]);
