import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

//--------------------- Constants
class RemoveActionResultWrapper {
  final bool result;

  RemoveActionResultWrapper(this.result);
}

final removeActionHelper = AsyncActionHelperWithParam<
    //////Creator
    AppState,
    RemoveActionResultWrapper,
    String,
    List<TodoModel>>(
  ////////////////////Creator
  action: (id) async => RemoveActionResultWrapper(
      await GetIt.instance.get<TodosService>().remove(id)),
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    if (action.wrapper.result) {
      model = model!.where((element) => element.id != action.param).toList();
    }
    return model;
  },
);
