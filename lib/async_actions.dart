import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'base_sync_actions.dart';
import 'base_state.dart';

export 'base_state.dart';
export 'base_sync_actions.dart';

abstract class FulfilledAction {}

class FulfilledActionWithResult<ResultWrapper> extends FulfilledAction {
  ResultWrapper wrapper;
  FulfilledActionWithResult(this.wrapper);
}

class FulfilledActionWithResultParam<ResultWrapper, Param>
    extends FulfilledActionWithResult<ResultWrapper> {
  Param param;
  FulfilledActionWithResultParam(ResultWrapper wrapper, this.param)
      : super(wrapper);
}

class PendingAction<ResultWrapper> {
  bool isLoading = true;
  PendingAction({this.isLoading = true});
}

class RejectedAction<ResultWrapper> {
  Exception ex;
  RejectedAction(this.ex);
}

////////////////////////////////////////////////////////////////

//BaseAsyncHelper = BaseAsyncActionHandler + BaseAsyncActionCreator
class AsyncActionHelper<AppState, ResultWrapper, Model> {
  Model? Function(Model?, FulfilledActionWithResult<ResultWrapper>)?
      fulfiledFunc;

  AsyncActionHelper({required this.action, this.fulfiledFunc});

  BaseState<Model> fulfilledActionHandler(
      BaseState<Model> state, FulfilledActionWithResult<ResultWrapper> action) {
    return state.copyWith(
        model: fulfiledFunc != null
            ? fulfiledFunc!(state.model, action)
            : state.model);
  }

  BaseState<Model> rejectedActionHandler(
      BaseState<Model> state, RejectedAction<ResultWrapper> action) {
    return state.copyWith(isLoading: false);
  }

  BaseState<Model> pendingActionHandler(
      BaseState<Model> state, PendingAction<ResultWrapper> action) {
    return state.copyWith(isLoading: true);
  }

  TypedReducer<BaseState<Model>, FulfilledActionWithResult<ResultWrapper>>
      fulfilledActionReducer() => TypedReducer<BaseState<Model>,
          FulfilledActionWithResult<ResultWrapper>>(fulfilledActionHandler);

  TypedReducer<BaseState<Model>, RejectedAction<ResultWrapper>>
      rejectedActionReducer() =>
          TypedReducer<BaseState<Model>, RejectedAction<ResultWrapper>>(
              rejectedActionHandler);

  TypedReducer<BaseState<Model>, PendingAction<ResultWrapper>>
      pendingActionReducer() =>
          TypedReducer<BaseState<Model>, PendingAction<ResultWrapper>>(
              pendingActionHandler);

  Iterable<dynamic> reducers() => [
        fulfilledActionReducer(),
        rejectedActionReducer(),
        pendingActionReducer()
      ];

  // ignore: prefer_function_declarations_over_variables
  PendingAction<ResultWrapper> Function() pendingAction =
      () => PendingAction<ResultWrapper>(isLoading: true);
  // ignore: prefer_function_declarations_over_variables
  FulfilledActionWithResult<ResultWrapper> Function(ResultWrapper)
      // ignore: prefer_function_declarations_over_variables
      fulfilledAction = (r) => FulfilledActionWithResult<ResultWrapper>(r);
  // ignore: prefer_function_declarations_over_variables
  RejectedAction<ResultWrapper> Function(Exception) rejectedAction =
      (ex) => RejectedAction<ResultWrapper>(ex);
  Future<ResultWrapper> Function() action;

  void Function() doActionCreator(Store<AppState> store) =>
      () => store.dispatch(doAction());

  ThunkAction<AppState> doAction() => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        try {
          ResultWrapper result = await action();
          store.dispatch(fulfilledAction(result));
        } on Exception catch (_) {
          store.dispatch(rejectedAction(_));
        }
      };
}

//BaseAsyncHelperWithParam = BaseAsyncActionHandler + BaseAsyncActionCreatorWithParam
class AsyncActionHelperWithParam<AppState, ResultWrapper, Param, Model> {
  Model? Function(Model?, FulfilledActionWithResultParam<ResultWrapper, Param>)?
      fulfiledFunc;

  AsyncActionHelperWithParam({required this.action, this.fulfiledFunc});

  BaseState<Model> fulfilledActionHandler(BaseState<Model> state,
      FulfilledActionWithResultParam<ResultWrapper, Param> action) {
    return state.copyWith(
        model: fulfiledFunc != null
            ? fulfiledFunc!(state.model, action)
            : state.model);
  }

  BaseState<Model> rejectedActionHandler(
      BaseState<Model> state, RejectedAction<ResultWrapper> action) {
    return state.copyWith(isLoading: false);
  }

  BaseState<Model> pendingActionHandler(
      BaseState<Model> state, PendingAction<ResultWrapper> action) {
    return state.copyWith(isLoading: true);
  }

  TypedReducer<BaseState<Model>,
          FulfilledActionWithResultParam<ResultWrapper, Param>>
      fulfilledActionReducer() => TypedReducer<BaseState<Model>,
              FulfilledActionWithResultParam<ResultWrapper, Param>>(
          fulfilledActionHandler);

  TypedReducer<BaseState<Model>, RejectedAction<ResultWrapper>>
      rejectedActionReducer() =>
          TypedReducer<BaseState<Model>, RejectedAction<ResultWrapper>>(
              rejectedActionHandler);

  TypedReducer<BaseState<Model>, PendingAction<ResultWrapper>>
      pendingActionReducer() =>
          TypedReducer<BaseState<Model>, PendingAction<ResultWrapper>>(
              pendingActionHandler);

  Iterable<TypedReducer<BaseState<Model>, dynamic>> reducers() => [
        fulfilledActionReducer(),
        rejectedActionReducer(),
        pendingActionReducer()
      ];

  // ignore: prefer_function_declarations_over_variables
  PendingAction<ResultWrapper> Function() pendingAction =
      () => PendingAction<ResultWrapper>();
  FulfilledActionWithResultParam<ResultWrapper, Param> Function(
          ResultWrapper, Param)
      // ignore: prefer_function_declarations_over_variables
      fulfilledAction =
      (r, p) => FulfilledActionWithResultParam<ResultWrapper, Param>(r, p);
  // ignore: prefer_function_declarations_over_variables
  RejectedAction<ResultWrapper> Function(Exception) rejectedAction =
      (ex) => RejectedAction<ResultWrapper>(ex);
  Future<ResultWrapper> Function(Param) action;

  Future Function(Param) doActionCreator(Store<AppState> store) =>
      (Param param) => store.dispatch(doAction(param));

  ThunkAction<AppState> doAction(Param param) => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        try {
          ResultWrapper result = await action(param);
          store.dispatch(fulfilledAction(result, param));
        } on Exception catch (_) {
          store.dispatch(rejectedAction(_));
        }
      };
}
