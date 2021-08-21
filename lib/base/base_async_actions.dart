import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'base_sync_actions.dart';
import 'base_state.dart';

export 'base_state.dart';
export 'base_sync_actions.dart';

abstract class BaseFulfilledAction {}

class BaseFulfilledActionWithResult<Result> extends BaseFulfilledAction {
  Result result;
  BaseFulfilledActionWithResult(this.result);
}

class BaseFulfilledActionWithResultParam<Result, Param>
    extends BaseFulfilledActionWithResult<Result> {
  Param param;
  BaseFulfilledActionWithResultParam(Result result, this.param) : super(result);
}

class BasePendingAction {
  bool isLoading = true;
  BasePendingAction({this.isLoading = true});
}

class BaseRejectedAction {
  Exception ex;
  BaseRejectedAction(this.ex);
}

////////////////////////////////////////////////////////////////
class BaseAsyncActionHandler<
    Model,
    FulfilledAction extends BaseFulfilledAction,
    RejectedAction extends BaseRejectedAction,
    PendingAction extends BasePendingAction> {
  Model? Function(Model?, FulfilledAction)? fulfiledFunc;

  BaseAsyncActionHandler({this.fulfiledFunc});

  BaseState<Model> fulfilledActionHandler(
      BaseState<Model> state, FulfilledAction action) {
    return state.copyWith(
        model: fulfiledFunc != null
            ? fulfiledFunc!(state.model, action)
            : state.model);
  }

  BaseState<Model> rejectedActionHandler(
      BaseState<Model> state, BaseRejectedAction action) {
    return state.copyWith(isLoading: false);
  }

  BaseState<Model> pendingActionHandler(
      BaseState<Model> state, BasePendingAction action) {
    return state.copyWith(isLoading: true);
  }

  TypedReducer<BaseState<Model>, FulfilledAction> fulfilledActionReducer() =>
      TypedReducer<BaseState<Model>, FulfilledAction>(fulfilledActionHandler);

  TypedReducer<BaseState<Model>, RejectedAction> rejectedActionReducer() =>
      TypedReducer<BaseState<Model>, RejectedAction>(rejectedActionHandler);

  TypedReducer<BaseState<Model>, PendingAction> pendingActionReducer() =>
      TypedReducer<BaseState<Model>, PendingAction>(pendingActionHandler);
}

class BaseAsyncActionCreatorWithParam<AppState, Result, Param> {
  BasePendingAction Function() pendingAction;
  BaseFulfilledActionWithResultParam<Result, Param> Function(Result, Param)
      fulfilledAction;
  BaseRejectedAction Function(Exception) rejectedAction;

  Future<Result> Function(Param) action;

  BaseAsyncActionCreatorWithParam({
    required this.pendingAction,
    required this.rejectedAction,
    required this.fulfilledAction,
    required this.action,
  });

  void Function(Param) doActionCreator(Store<AppState> store) =>
      (Param param) => store.dispatch(doAction(param));

  ThunkAction<AppState> doAction(Param param) => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        try {
          Result result = await action(param);
          store.dispatch(fulfilledAction(result, param));
        } on Exception catch (_) {
          store.dispatch(rejectedAction(_));
        }
      };
}

class BaseAsyncActionCreator<AppState, Result> {
  BasePendingAction Function() pendingAction;
  BaseFulfilledActionWithResult<Result> Function(Result) fulfilledAction;
  BaseRejectedAction Function(Exception) rejectedAction;
  Future<Result> Function() action;

  BaseAsyncActionCreator(
      {required this.pendingAction,
      required this.rejectedAction,
      required this.fulfilledAction,
      required this.action});

  void Function() doActionCreator(Store<AppState> store) =>
      () => store.dispatch(doAction());

  ThunkAction<AppState> doAction() => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        try {
          Result result = await action();
          store.dispatch(fulfilledAction(result));
        } on Exception catch (_) {
          store.dispatch(rejectedAction(_));
        }
      };
}

////////////////////////////////////////////////////////////////

//BaseAsyncHelper = BaseAsyncActionHandler + BaseAsyncActionCreator
class BaseAsyncActionHelper<
    AppState,
    Result,
    Model,
    FulfilledAction extends BaseFulfilledAction,
    RejectedAction extends BaseRejectedAction,
    PendingAction extends BasePendingAction> {
  Model? Function(Model?, FulfilledAction)? fulfiledFunc;

  BaseAsyncActionHelper(
      {required this.pendingAction,
      required this.rejectedAction,
      required this.fulfilledAction,
      required this.action,
      this.fulfiledFunc});

  BaseState<Model> fulfilledActionHandler(
      BaseState<Model> state, FulfilledAction action) {
    return state.copyWith(
        model: fulfiledFunc != null
            ? fulfiledFunc!(state.model, action)
            : state.model);
  }

  BaseState<Model> rejectedActionHandler(
      BaseState<Model> state, RejectedAction action) {
    return state.copyWith(isLoading: false);
  }

  BaseState<Model> pendingActionHandler(
      BaseState<Model> state, PendingAction action) {
    return state.copyWith(isLoading: true);
  }

  TypedReducer<BaseState<Model>, FulfilledAction> fulfilledActionReducer() =>
      TypedReducer<BaseState<Model>, FulfilledAction>(fulfilledActionHandler);

  TypedReducer<BaseState<Model>, RejectedAction> rejectedActionReducer() =>
      TypedReducer<BaseState<Model>, RejectedAction>(rejectedActionHandler);

  TypedReducer<BaseState<Model>, PendingAction> pendingActionReducer() =>
      TypedReducer<BaseState<Model>, PendingAction>(pendingActionHandler);

  Iterable<dynamic> reducers() => [
        fulfilledActionReducer(),
        rejectedActionReducer(),
        pendingActionReducer()
      ];

  BasePendingAction Function() pendingAction;
  BaseFulfilledActionWithResult<Result> Function(Result) fulfilledAction;
  BaseRejectedAction Function(Exception) rejectedAction;
  Future<Result> Function() action;

  void Function() doActionCreator(Store<AppState> store) =>
      () => store.dispatch(doAction());

  ThunkAction<AppState> doAction() => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        try {
          Result result = await action();
          store.dispatch(fulfilledAction(result));
        } on Exception catch (_) {
          store.dispatch(rejectedAction(_));
        }
      };
}

//BaseAsyncHelperWithParam = BaseAsyncActionHandler + BaseAsyncActionCreatorWithParam
class BaseAsyncActionHelperWithParam<
    AppState,
    Result,
    Param,
    Model,
    FulfilledAction extends BaseFulfilledAction,
    RejectedAction extends BaseRejectedAction,
    PendingAction extends BasePendingAction> {
  Model? Function(Model?, FulfilledAction)? fulfiledFunc;

  BaseAsyncActionHelperWithParam(
      {required this.pendingAction,
      required this.rejectedAction,
      required this.fulfilledAction,
      required this.action,
      this.fulfiledFunc});

  BaseState<Model> fulfilledActionHandler(
      BaseState<Model> state, FulfilledAction action) {
    return state.copyWith(
        model: fulfiledFunc != null
            ? fulfiledFunc!(state.model, action)
            : state.model);
  }

  BaseState<Model> rejectedActionHandler(
      BaseState<Model> state, RejectedAction action) {
    return state.copyWith(isLoading: false);
  }

  BaseState<Model> pendingActionHandler(
      BaseState<Model> state, PendingAction action) {
    return state.copyWith(isLoading: true);
  }

  TypedReducer<BaseState<Model>, FulfilledAction> fulfilledActionReducer() =>
      TypedReducer<BaseState<Model>, FulfilledAction>(fulfilledActionHandler);

  TypedReducer<BaseState<Model>, RejectedAction> rejectedActionReducer() =>
      TypedReducer<BaseState<Model>, RejectedAction>(rejectedActionHandler);

  TypedReducer<BaseState<Model>, PendingAction> pendingActionReducer() =>
      TypedReducer<BaseState<Model>, PendingAction>(pendingActionHandler);

  Iterable<TypedReducer<BaseState<Model>, dynamic>> reducers() => [
        fulfilledActionReducer(),
        rejectedActionReducer(),
        pendingActionReducer()
      ];

  BasePendingAction Function() pendingAction;
  BaseFulfilledActionWithResultParam<Result, Param> Function(Result, Param)
      fulfilledAction;
  BaseRejectedAction Function(Exception) rejectedAction;
  Future<Result> Function(Param) action;

  void Function(Param) doActionCreator(Store<AppState> store) =>
      (Param param) => store.dispatch(doAction(param));

  ThunkAction<AppState> doAction(Param param) => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        try {
          Result result = await action(param);
          store.dispatch(fulfilledAction(result, param));
        } on Exception catch (_) {
          store.dispatch(rejectedAction(_));
        }
      };
}
