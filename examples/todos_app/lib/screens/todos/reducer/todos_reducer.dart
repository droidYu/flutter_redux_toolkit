import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:redux/redux.dart';
import 'package:todos_app/screens/todos/reducer/actions/find_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/insert_action.dart';
import 'package:todos_app/screens/todos/reducer/actions/remove_action.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

Reducer<BaseState<List<TodoModel>>> todoReducer =
    combineReducers<BaseState<List<TodoModel>>>([
  insertActionHelper.fulfilledActionReducer(),
  insertActionHelper.pendingActionReducer(),
  insertActionHelper.rejectedActionReducer(),
  removeActionHelper.fulfilledActionReducer(),
  removeActionHelper.pendingActionReducer(),
  removeActionHelper.rejectedActionReducer(),
  findActionHelper.fulfilledActionReducer(),
  findActionHelper.pendingActionReducer(),
  findActionHelper.rejectedActionReducer(),
  // ...findActionHelper.reducers(),
  // ...insertActionHelper.reducers(),
  // ...removeActionHelper.reducers()
]);
