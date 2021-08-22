import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

class UpdateActionResultWrapper {
  final bool result;

  UpdateActionResultWrapper(this.result);
}

//--------------------- Action Handlers + Action  Creators
final updateActionHelper = AsyncActionHelperWithParam<
    //////Creator
    AppState,
    UpdateActionResultWrapper,
    TodoModel,
    //////Handler
    List<TodoModel>>(
  ////////////////////Creator
  action: (i) async => UpdateActionResultWrapper(
      await GetIt.instance.get<TodosService>().update(i)),
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    if (action.wrapper.result) {
      final updated = action.param;
      var index = model!.indexWhere((itm) => itm.id == updated.id);
      model[index] = (model[index].toBuilder()
            ..title = updated.title
            ..description = updated.description
            ..marked = updated.marked)
          .build();
    }
    return model;
  },
);
