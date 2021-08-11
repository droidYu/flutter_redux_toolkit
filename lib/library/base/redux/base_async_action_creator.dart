import 'package:redux/redux.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux_toolkit/redux/app_state.dart';

class BaseAsyncActionCreator<Model, Param> {
  BasePendingAction Function() pendingAction;
  BaseFulfilledAction<Model> Function(Model) fulfilledAction;
  BaseRejectedAction Function(Exception) rejectedAction;

  Future<Model> Function(Param) action;

  BaseAsyncActionCreator({
    required this.pendingAction,
    required this.rejectedAction,
    required this.fulfilledAction,
    required this.action,
  });

  void Function(Param) doActionCreator(Store<AppState> store) =>
      (Param param) => store.dispatch(doAction(param));

  ThunkAction<AppState> doAction(Param param) => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        //print("PENDING");
        try {
          final result = await this.action(param);
          store.dispatch(fulfilledAction(result));
          //print("FULFILLED");
        } on Exception catch (_) {
          //print("REJECTED");
          store.dispatch(rejectedAction(_));
        }
      };
}

class BaseAsyncActionCreatorNoParam<Model> {
  BasePendingAction Function() pendingAction;
  BaseFulfilledAction<Model> Function(Model) fulfilledAction;
  BaseRejectedAction Function(Exception) rejectedAction;
  Future<Model> Function() action;

  BaseAsyncActionCreatorNoParam(
      {required this.pendingAction,
      required this.rejectedAction,
      required this.fulfilledAction,
      required this.action});

  void Function() doActionCreator(Store<AppState> store) =>
      () => store.dispatch(doAction());

  ThunkAction<AppState> doAction() => (Store<AppState> store) async {
        store.dispatch(pendingAction());
        //print("PENDING");
        try {
          final result = await this.action();
          store.dispatch(fulfilledAction(result));
          //print("FULFILLED");
        } on Exception catch (_) {
          //print("REJECTED");
          store.dispatch(rejectedAction(_));
        }
      };
}
