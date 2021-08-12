import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

//--------------------- Constants
typedef FindTodosPendingAction = BasePendingAction;
typedef FindTodosRejectedAction = BaseRejectedAction;
typedef FindTodosFulfilledAction = BaseFulfilledAction<List<TodoModel>>;

//--------------------- Actions
//ASYNC
final serviceLocator = GetIt.instance;
final todosService = serviceLocator.get<TodosService>();
final findActionCreator = BaseAsyncActionCreatorNoParam<AppState, List<TodoModel>>(
  pendingAction: () => FindTodosPendingAction(),
  fulfilledAction: (todos) => FindTodosFulfilledAction(todos),
  rejectedAction: (ex) => FindTodosRejectedAction(ex),
  action: () => todosService.find(),
);

//--------------------- Action handlers
final findActionHandler = BaseAsyncActionHandler<
    List<TodoModel>,
    FindTodosFulfilledAction,
    FindTodosRejectedAction,
    FindTodosPendingAction>();
