library flutter_redux_toolkit;

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import "package:meta/meta.dart";

@immutable
class BaseState<Model> {
  final Model? model;
  final bool? isLoading;

  const BaseState({
    this.model,
    this.isLoading,
  });

  factory BaseState.initial(Model intialModel) {
    return BaseState<Model>(
      isLoading: false,
      model: intialModel,
    );
  }
  BaseState<Model> copyWith({
    Model? model,
    bool? isLoading,
  }) {
    return BaseState(
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}


abstract class BaseListAction<T> {
  List<T> items;
  BaseListAction(this.items);
}


abstract class BaseFulfilledAction {}

class BaseFulfilledActionWithResult<Result> extends BaseFulfilledAction {
  Result result;
  BaseFulfilledActionWithResult(this.result);
}

class BaseFulfilledActionWithResultParam<Result, Param> extends BaseFulfilledActionWithResult<Result> {
  Param param;
  BaseFulfilledActionWithResultParam(Result result, this.param): super(result);
}

class BasePendingAction {
  bool isLoading = true;
  BasePendingAction({this.isLoading = true}){}
}

class BaseRejectedAction {
  Exception ex;
  BaseRejectedAction(this.ex);
}


class BaseAction<Data> {
  Data data;
  BaseAction(this.data);
}

class BaseActionHandler<Model, Action> {
  Model? Function(Model?, Action)? actionFunc;

  BaseActionHandler({this.actionFunc});

  BaseState<Model> actionHandler(
      BaseState<Model> state, Action action) {
    return state.copyWith(
        model: actionFunc != null
            ? actionFunc!(state.model, action)
            : (action as BaseAction<Model>).data);
  }

  TypedReducer<BaseState<Model>, Action> actionReducer() => TypedReducer<BaseState<Model>, Action>(actionHandler);
}

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


class BaseActionCreator<AppState, Model, Param> {
  BaseAction Function(Param) action;
  
  BaseActionCreator({
    required this.action,
  });

  void Function(Param) doActionCreator(Store<AppState> store) => (Param param) => store.dispatch(action(param));
}

class BaseActionCreatorNoParam<AppState,Model> {
  BaseAction<Model> Function() action;
  

  BaseActionCreatorNoParam({
    required this.action,
  });

  void Function() doAction(Store<AppState> store) => () => store.dispatch(action());
}

class BaseAsyncActionCreatorWithParam<AppState, Result, Param> {
  BasePendingAction Function() pendingAction;
  BaseFulfilledActionWithResultParam<Result, Param> Function(Result, Param) fulfilledAction;
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
abstract class BaseRepository<T> {
  Future<List<T>> find();
  Future insert(T t);
  Future<T> findOne(String id);
  void remove(String id);
  Future update(T t);
}
