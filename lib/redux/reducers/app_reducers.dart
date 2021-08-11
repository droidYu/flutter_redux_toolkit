import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_reducer.dart';

import '../app_state.dart';

AppState appStateReducer(AppState state, action) => new AppState(
      todoState: todoReducer(state.todoState!, action),
    );
