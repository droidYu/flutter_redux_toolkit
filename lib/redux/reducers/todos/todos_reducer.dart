import 'package:flutter_redux_toolkit/library/base/redux/base_state.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/actions/find_action.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/actions/insert_action.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/actions/remove_action.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_model.dart';
import 'package:redux/redux.dart';

Reducer<BaseState<List<TodoModel>>> todoReducer =
    combineReducers<BaseState<List<TodoModel>>>([
  insertActionHandler.fulfilledActionReducer(),
  insertActionHandler.pendingActionReducer(),
  insertActionHandler.rejectedActionReducer(),

  removeActionHandler.fulfilledActionReducer(),
  removeActionHandler.pendingActionReducer(),
  removeActionHandler.rejectedActionReducer(),

  findActionHandler.fulfilledActionReducer(),
  findActionHandler.pendingActionReducer(),
  findActionHandler.rejectedActionReducer(),

  // ...removeActionHandler.reducers2,
  // ...findActionHandler.reducers
]);
