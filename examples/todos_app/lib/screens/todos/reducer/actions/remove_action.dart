import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

//--------------------- Constants
class RemoveTodosPendingAction extends BasePendingAction {}

class RemoveTodosRejectedAction extends BaseRejectedAction {
  RemoveTodosRejectedAction(Exception ex) : super(ex);
}

class RemoveTodosFulfilledAction
    extends BaseFulfilledActionWithResultParam<bool, String> {
  RemoveTodosFulfilledAction(bool result, String param) : super(result, param);
}

// //--------------------- Actions
// //ASYNC
// final serviceLocator = GetIt.instance;
// final todosService = serviceLocator.get<TodosService>();
// final removeActionCreator =
//     BaseAsyncActionCreatorWithParam<AppState, bool, String>(
//   pendingAction: () => RemoveTodosPendingAction(),
//   fulfilledAction: (result, param) => RemoveTodosFulfilledAction(result, param),
//   rejectedAction: (ex) => RemoveTodosRejectedAction(ex),
//   action: todosService.remove,
// );

// final removeActionHandler = BaseAsyncActionHandler<
//     List<TodoModel>,
//     RemoveTodosFulfilledAction,
//     RemoveTodosRejectedAction,
//     RemoveTodosPendingAction>(fulfiledFunc: (model, action) {
//   if (action.result) {
//     model = model!.where((element) => element.id != action.param).toList();
//   }
//   return model;
// });

final removeActionHelper = BaseAsyncActionHelperWithParam<
    //////Creator
    AppState,
    bool,
    String,
    List<TodoModel>,
    //////Handler
    RemoveTodosFulfilledAction,
    RemoveTodosRejectedAction,
    RemoveTodosPendingAction>(
  ////////////////////Creator
  pendingAction: () => RemoveTodosPendingAction(),
  fulfilledAction: (result, param) => RemoveTodosFulfilledAction(result, param),
  rejectedAction: (ex) => RemoveTodosRejectedAction(ex),
  action: GetIt.instance.get<TodosService>().remove,
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    if (action.result) {
      model = model!.where((element) => element.id != action.param).toList();
    }
    return model;
  },
);
