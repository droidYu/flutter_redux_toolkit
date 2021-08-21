import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_service.dart';

class FindActionResultWrapper {
  final List<TodoModel> result;

  FindActionResultWrapper(this.result);
}

//--------------------- Action Handlers + Action  Creators
final findActionHelper = AsyncActionHelper<
    //////Creator
    AppState,
    FindActionResultWrapper,
    //////Handler
    List<TodoModel>>(
  ////////////////////Creator

  action: () async =>
      FindActionResultWrapper(await GetIt.instance.get<TodosService>().find()),
  ////////////////////Handler
  fulfiledFunc: (model, action) {
    model = action.wrapper.result;
    return model;
  },
);
