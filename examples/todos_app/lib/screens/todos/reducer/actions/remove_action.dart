import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

//--------------------- Constants
typedef RemoveTodosPendingAction = BasePendingAction;
typedef RemoveTodosRejectedAction = BaseRejectedAction;
typedef RemoveTodosFulfilledAction = BaseFulfilledAction<String>;

//--------------------- Actions
//ASYNC
final serviceLocator = GetIt.instance;
final todosService = serviceLocator.get<TodosService>();
final removeActionCreator = BaseAsyncActionCreator<AppState, String, String>(
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
