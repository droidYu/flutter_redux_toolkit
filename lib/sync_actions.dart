import 'package:flutter_redux_toolkit/state.dart';
import 'package:redux/redux.dart';

class Action<Data> {
  Data data;
  Action(this.data);
}

////////////////////////////////////////////////////////////////
class ActionHandler<Model, CustomAction> {
  Model? Function(Model?, CustomAction)? actionFunc;

  ActionHandler({this.actionFunc});

  State<Model> actionHandler(State<Model> state, CustomAction action) {
    return state.copyWith(
        model: actionFunc != null
            ? actionFunc!(state.model, action)
            : (action as Action<Model>).data);
  }

  TypedReducer<State<Model>, CustomAction> actionReducer() =>
      TypedReducer<State<Model>, CustomAction>(actionHandler);
}

class ActionCreator<AppState, Model, Param> {
  Action Function(Param) action;

  ActionCreator({
    required this.action,
  });

  void Function(Param) doActionCreator(Store<AppState> store) =>
      (Param param) => store.dispatch(action(param));
}

class ActionCreatorNoParam<AppState, Model> {
  Action<Model> Function() action;

  ActionCreatorNoParam({
    required this.action,
  });

  void Function() doAction(Store<AppState> store) =>
      () => store.dispatch(action());
}

////////////////////////////////////////////////////////////////

//BaseActionHelper = BaseActionHandler + BaseActionCreatorNoParam
class ActionHelper<AppState, CustomAction, Model> {
  Model? Function(Model?, CustomAction)? actionHandlerFunc;

  Action<Model> Function() action;

  ActionHelper({this.actionHandlerFunc, required this.action});

  State<Model> actionHandler(State<Model> state, CustomAction action) {
    return state.copyWith(
        model: actionHandlerFunc != null
            ? actionHandlerFunc!(state.model, action)
            : (action as Action<Model>).data);
  }

  TypedReducer<State<Model>, CustomAction> actionReducer() =>
      TypedReducer<State<Model>, CustomAction>(actionHandler);

  void Function() doAction(Store<AppState> store) =>
      () => store.dispatch(action());
}

//BaseActionHelperWithParam = BaseActionHandler + BaseActionCreator
class ActionHelperWithParam<AppState, CustomAction, Param, Model> {
  Model? Function(Model?, CustomAction)? actionHandlerFunc;

  Action Function(Param) action;

  ActionHelperWithParam({this.actionHandlerFunc, required this.action});

  State<Model> actionHandler(State<Model> state, CustomAction action) {
    return state.copyWith(
        model: actionHandlerFunc != null
            ? actionHandlerFunc!(state.model, action)
            : (action as Action<Model>).data);
  }

  TypedReducer<State<Model>, CustomAction> actionReducer() =>
      TypedReducer<State<Model>, CustomAction>(actionHandler);

  void Function(Param) doAction(Store<AppState> store) =>
      (Param param) => store.dispatch(action(param));
}
