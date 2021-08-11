import 'package:flutter_redux_toolkit/library/base/redux/base_async_action.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_state.dart';
import 'package:redux/redux.dart';

class BaseAsyncActionHandler<
    Model,
    FulfilledAction,
    RejectedAction extends BaseRejectedAction,
    PendingAction extends BasePendingAction> {
  Model? Function(Model?, FulfilledAction)? fulfiledFunc;

  BaseAsyncActionHandler({this.fulfiledFunc});

  BaseState<Model> fulfilledActionHandler(
      BaseState<Model> state, FulfilledAction action) {
    print(action);
    return state.copyWith(
        model: this.fulfiledFunc != null
            ? this.fulfiledFunc!(state.model, action)
            : (action as BaseFulfilledAction<Model>).data);
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
