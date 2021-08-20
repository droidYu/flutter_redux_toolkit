import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

//--------------------- Constants
class InsertTodosPendingAction extends BasePendingAction {}

class InsertTodosRejectedAction extends BaseRejectedAction {
  InsertTodosRejectedAction(Exception ex) : super(ex);
}

class InsertTodosFulfilledAction
    extends BaseFulfilledActionWithResultParam<bool, TodoModel> {
  InsertTodosFulfilledAction(bool result, TodoModel param)
      : super(result, param);
}

// //--------------------- Actions
// //ASYNC
// final serviceLocator = GetIt.instance;
// final todosService = serviceLocator.get<TodosService>();
// final insertActionCreator =
//     BaseAsyncActionCreatorWithParam<AppState, bool, TodoModel>(
//         pendingAction: () => InsertTodosPendingAction(),
//         fulfilledAction: (result, param) =>
//             InsertTodosFulfilledAction(result, param),
//         rejectedAction: (ex) => InsertTodosRejectedAction(ex),
//         action: todosService.insert);

// //--------------------- Action handlers
// final insertActionHandler = BaseAsyncActionHandler<
//     List<TodoModel>,
//     InsertTodosFulfilledAction,
//     InsertTodosRejectedAction,
//     InsertTodosPendingAction>(fulfiledFunc: (model, action) {
//   if (action.result) {
//     model!.add(action.param);
//   }
//   return model;
// });
//--------------------- Action Handlers + Action  Creators
final insertActionHelper = BaseAsyncActionHelperWithParam<
    //////Creator
    AppState,
    bool,
    TodoModel,
    //////Handler
    List<TodoModel>,
    InsertTodosFulfilledAction,
    InsertTodosRejectedAction,
    InsertTodosPendingAction>(
  ////////////////////Creator
  pendingAction: () => InsertTodosPendingAction(),
  fulfilledAction: (result, param) => InsertTodosFulfilledAction(result, param),
  rejectedAction: (ex) => InsertTodosRejectedAction(ex),
  action: GetIt.instance.get<TodosService>().insert,
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    if (action.result) {
      model!.add(action.param);
    }
    return model;
  },
);


//TodoModel
//BOOL 

//INSERT TodoModel
//TRUE/FALSE

//REQUEST TO SERVER
//UPDATE REDUX STATE