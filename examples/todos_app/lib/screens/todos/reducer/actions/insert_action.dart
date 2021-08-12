import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';
//--------------------- Constants
typedef InsertTodosPendingAction = BasePendingAction;
typedef InsertTodosRejectedAction = BaseRejectedAction;
typedef InsertTodosFulfilledAction = BaseFulfilledActionWithParam<TodoModel, TodoModel>;

//--------------------- Actions
//ASYNC
final serviceLocator = GetIt.instance;
final todosService = serviceLocator.get<TodosService>();
final insertActionCreator = BaseAsyncActionCreatorWithParam<AppState, TodoModel, TodoModel>(
    pendingAction: () => InsertTodosPendingAction(),
    fulfilledAction: (result, param) => InsertTodosFulfilledAction(result, param),
    rejectedAction: (ex) => InsertTodosRejectedAction(ex),
    action: (todo) async {
      todosService.insert(todo);
      return todo;
    });

//--------------------- Action handlers
final insertActionHandler = BaseAsyncActionHandler<
    List<TodoModel>,
    InsertTodosFulfilledAction,
    InsertTodosRejectedAction,
    InsertTodosPendingAction>(fulfiledFunc: (model, action) {
  model!.add(action.data);
  return model;
});
