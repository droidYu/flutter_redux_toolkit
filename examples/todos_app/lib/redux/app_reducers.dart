
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_reducer.dart';

AppState appStateReducer(AppState state, action) => AppState(
      todoState: todoReducer(state.todoState!, action),
    );
