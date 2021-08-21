import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/store_hook_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/redux/app_state.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:uuid/uuid.dart';
import 'widgets/todo_row.dart';
import 'todos_vm.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TodosScreenWidgetStoreContentHook
    extends StoreHookWidget<AppState, TodosViewModel> {
  TodosScreenWidgetStoreContentHook({Key? key})
      : super(key: key, fromStore: TodosViewModel.fromStore);

  @override
  Widget buildWithVMHook(BuildContext context, TodosViewModel vm) {
    useEffect(() {
      vm.findTodos();
    }, const []);
    final TextEditingController _tecTitle =
        useTextEditingController(text: 'initial text');
    final TextEditingController _tecDescription =
        useTextEditingController(text: 'initial text');
    // ignore: prefer_function_declarations_over_variables
    Function clearTextFields = () {
      _tecTitle.clear();
      _tecDescription.clear();
    };
    // ignore: prefer_function_declarations_over_variables
    Function(String, String) addTodoItem = (String title, String description) {
      clearTextFields();
      vm.insertTodo(TodoModel.create(title, description));
    };

    // ignore: prefer_function_declarations_over_variables
    Function(String, String, String) updateTodoItem = (
      String id,
      String title,
      String description,
    ) {
      //clearTextFields();
      final todo = (vm.todos.where((p0) => p0.id == id).first.toBuilder()
            ..title = title
            ..description = description)
          .build();
      vm.updateTodo(todo);
    };

    // ignore: prefer_function_declarations_over_variables
    Function removeTodoItem = (int index) {
      final todo = vm.todos[index];
      vm.removeTodo(todo.id);
    };

    // ignore: prefer_function_declarations_over_variables
    Function promptRemoveTodoItem = (int index) {
      final item = vm.todos[index];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Mark "${item.title}" as done?'),
                actions: <Widget>[
                  TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () => Navigator.of(context).pop()),
                  TextButton(
                      child: const Text('MARK AS DONE'),
                      onPressed: () {
                        removeTodoItem(index);
                        Navigator.of(context).pop();
                      })
                ]);
          });
    };

    // Generate a single item widget
    // ignore: prefer_function_declarations_over_variables
    Function addNewItemDialog = (BuildContext context) async {
      clearTextFields();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Add new todo item'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: _tecTitle,
                      decoration:
                          const InputDecoration(hintText: 'Enter task here'),
                    ),
                    TextField(
                      controller: _tecDescription,
                      decoration: const InputDecoration(
                          hintText: 'Enter description here'),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('ADD'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    addTodoItem(_tecTitle.text, _tecDescription.text);
                  },
                ),
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    };

    // ignore: prefer_function_declarations_over_variables
    Function modifyItemDialog = (BuildContext context, TodoModel item) async {
      clearTextFields();
      final titleCtrl = TextEditingController(text: item.title);
      final descCtrl = TextEditingController(text: item.description);
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Update todo item'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: titleCtrl,
                    ),
                    TextField(
                      controller: descCtrl,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    updateTodoItem(item.id, titleCtrl.text, descCtrl.text);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    };
    return MaterialApp(
      title: "Todo list",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Todo list"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => addNewItemDialog(context),
            tooltip: 'Add Item',
            child: const Icon(Icons.add)),
        body: ListView.builder(
            itemCount: vm.todos.length,
            itemBuilder: (context, index) {
              final todo = vm.todos[index];
              final todoRow = TodoRow(todo.title, todo.description);

              return Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    title: todoRow.buildTitle(context),
                    subtitle: todoRow.buildSubtitle(context),
                    onTap: () {
                      promptRemoveTodoItem(index);
                    },
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    //caption: 'Archive',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () {
                      modifyItemDialog(context, todo);
                    },
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    //caption: 'Delete',
                    color: Colors.green,
                    icon: Icons.check,
                    onTap: () {
                      promptRemoveTodoItem(index);
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
