import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../redux/app_state.dart';
import 'todos_view_model.dart';
import 'todos_screen_content_hook.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodosViewModel>(
        converter: TodosViewModel.fromStore,
        builder: (BuildContext context, TodosViewModel viewModel) {
          return TodosScreenWidgetContentHook(viewModel: viewModel);
        });
  }
}
