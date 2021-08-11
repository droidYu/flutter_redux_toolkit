import 'package:get_it/get_it.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action_creator.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action_handler.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_model.dart';
import 'package:flutter_redux_toolkit/services/todos/todos_service.dart';

//--------------------- Constants
typedef FindTodosPendingAction = BasePendingAction;
typedef FindTodosRejectedAction = BaseRejectedAction;
typedef FindTodosFulfilledAction = BaseFulfilledAction<List<TodoModel>>;

//--------------------- Actions
//ASYNC
final serviceLocator = GetIt.instance;
final todosService = serviceLocator.get<TodosService>();
final findActionCreator = BaseAsyncActionCreatorNoParam<List<TodoModel>>(
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
