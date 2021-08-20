import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

//--------------------- Constants
class FindTodosPendingAction extends BasePendingAction {}

class FindTodosRejectedAction extends BaseRejectedAction {
  FindTodosRejectedAction(Exception ex) : super(ex);
}

class FindTodosFulfilledAction
    extends BaseFulfilledActionWithResult<List<TodoModel>> {
  FindTodosFulfilledAction(List<TodoModel> result) : super(result);
}

//--------------------- Action Handlers + Action  Creators
final findActionHelper = BaseAsyncActionHelper<
    //////Creator
    AppState,
    List<TodoModel>,
    //////Handler
    List<TodoModel>,
    FindTodosFulfilledAction,
    FindTodosRejectedAction,
    FindTodosPendingAction>(
  ////////////////////Creator
  pendingAction: () => FindTodosPendingAction(),
  fulfilledAction: (todos) => FindTodosFulfilledAction(todos),
  rejectedAction: (ex) => FindTodosRejectedAction(ex),
  action: GetIt.instance.get<TodosService>().find,
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    model = action.result;
    return model;
  },
);
