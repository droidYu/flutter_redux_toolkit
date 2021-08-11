import 'package:get_it/get_it.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action_creator.dart';
import 'package:flutter_redux_toolkit/library/base/redux/base_async_action_handler.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_model.dart';
import 'package:flutter_redux_toolkit/services/todos/todos_service.dart';

//--------------------- Constants
typedef RemoveTodosPendingAction = BasePendingAction;
typedef RemoveTodosRejectedAction = BaseRejectedAction;
typedef RemoveTodosFulfilledAction = BaseFulfilledAction<String>;

//--------------------- Actions
//ASYNC
final serviceLocator = GetIt.instance;
final todosService = serviceLocator.get<TodosService>();
final removeActionCreator = BaseAsyncActionCreator<String, String>(
  pendingAction: () => RemoveTodosPendingAction(),
  fulfilledAction: (id) => RemoveTodosFulfilledAction(id),
  rejectedAction: (ex) => RemoveTodosRejectedAction(ex),
  action: (id) async {
    await todosService.remove(id);
    return id;
  },
);

final removeActionHandler = BaseAsyncActionHandler<
    List<TodoModel>,
    RemoveTodosFulfilledAction,
    RemoveTodosRejectedAction,
    RemoveTodosPendingAction>(fulfiledFunc: (model, action) {
  model!.removeWhere((todo) => todo.title == action.data);
  return model;
});
