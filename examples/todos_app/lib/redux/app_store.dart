import 'app_state.dart';
import 'package:redux/redux.dart';
import 'app_reducers.dart';
import 'package:redux_thunk/redux_thunk.dart';

//ASYNC
//SYNC

Store<AppState> configureStore() {

  final store = Store<AppState>(
    appStateReducer,
  /* Function defined in the reducers file */
  initialState: AppState.initial(),
    middleware: [
      thunkMiddleware
    ],
  );

  //Write here if want to run some future function first
  // sagaMiddleware.run(rootSaga);
  return store;
}