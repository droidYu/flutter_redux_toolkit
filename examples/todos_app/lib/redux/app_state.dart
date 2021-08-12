import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

@immutable
class AppState {
  final BaseState<List<TodoModel>>? todoState;
  const AppState({
    required this.todoState,
  });
  factory AppState.initial() => AppState(
        todoState: BaseState<List<TodoModel>>.initial(const []),
      );
}
