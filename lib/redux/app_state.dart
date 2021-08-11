import 'package:meta/meta.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_state.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_model.dart';

@immutable
class AppState {
  final BaseState<List<TodoModel>>? todoState;
  AppState({
    required this.todoState,
  });
  factory AppState.initial() => AppState(
        todoState: BaseState<List<TodoModel>>.initial([]),
      );
}
