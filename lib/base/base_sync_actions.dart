import 'package:redux/redux.dart';

import 'base_sync_actions.dart';
import 'base_state.dart';

export 'base_state.dart';
export 'base_sync_actions.dart';

class BaseAction<Data> {
  Data data;
  BaseAction(this.data);
}

////////////////////////////////////////////////////////////////
class BaseActionHandler<Model, Action> {
  Model? Function(Model?, Action)? actionFunc;

  BaseActionHandler({this.actionFunc});

  BaseState<Model> actionHandler(BaseState<Model> state, Action action) {
    return state.copyWith(
        model: actionFunc != null
            ? actionFunc!(state.model, action)
            : (action as BaseAction<Model>).data);
  }

  TypedReducer<BaseState<Model>, Action> actionReducer() =>
      TypedReducer<BaseState<Model>, Action>(actionHandler);
}

class BaseActionCreator<AppState, Model, Param> {
  BaseAction Function(Param) action;

  BaseActionCreator({
    required this.action,
  });

  void Function(Param) doActionCreator(Store<AppState> store) =>
      (Param param) => store.dispatch(action(param));
}

class BaseActionCreatorNoParam<AppState, Model> {
  BaseAction<Model> Function() action;

  BaseActionCreatorNoParam({
    required this.action,
  });

  void Function() doAction(Store<AppState> store) =>
      () => store.dispatch(action());
}

////////////////////////////////////////////////////////////////

//BaseActionHelper = BaseActionHandler + BaseActionCreatorNoParam
class BaseActionHelper<AppState, Model, Action> {
  Model? Function(Model?, Action)? actionHandlerFunc;

  BaseAction<Model> Function() action;

  BaseActionHelper({this.actionHandlerFunc, required this.action});

  BaseState<Model> actionHandler(BaseState<Model> state, Action action) {
    return state.copyWith(
        model: actionHandlerFunc != null
            ? actionHandlerFunc!(state.model, action)
            : (action as BaseAction<Model>).data);
  }

  TypedReducer<BaseState<Model>, Action> actionReducer() =>
      TypedReducer<BaseState<Model>, Action>(actionHandler);

  void Function() doAction(Store<AppState> store) =>
      () => store.dispatch(action());
}

//BaseActionHelperWithParam = BaseActionHandler + BaseActionCreator
class BaseActionHelperWithParam<AppState, Model, Action, Param> {
  Model? Function(Model?, Action)? actionHandlerFunc;

  BaseAction Function(Param) action;

  BaseActionHelperWithParam({this.actionHandlerFunc, required this.action});

  BaseState<Model> actionHandler(BaseState<Model> state, Action action) {
    return state.copyWith(
        model: actionHandlerFunc != null
            ? actionHandlerFunc!(state.model, action)
            : (action as BaseAction<Model>).data);
  }

  TypedReducer<BaseState<Model>, Action> actionReducer() =>
      TypedReducer<BaseState<Model>, Action>(actionHandler);

  void Function(Param) doAction(Store<AppState> store) =>
      (Param param) => store.dispatch(action(param));
}
