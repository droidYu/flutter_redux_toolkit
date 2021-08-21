import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

class InsertActionResultWrapper {
  final bool result;

  InsertActionResultWrapper(this.result);
}

//--------------------- Action Handlers + Action  Creators
final insertActionHelper = AsyncActionHelperWithParam<
    //////Creator
    AppState,
    InsertActionResultWrapper,
    TodoModel,
    //////Handler
    List<TodoModel>>(
  ////////////////////Creator
  action: (i) async => InsertActionResultWrapper(
      await GetIt.instance.get<TodosService>().insert(i)),
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    if (action.wrapper.result) {
      model!.add(action.param);
    }
    return model;
  },
);
