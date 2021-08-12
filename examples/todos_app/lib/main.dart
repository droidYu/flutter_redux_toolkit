import 'package:flutter/material.dart';
import 'package:todos_app/library/base/base_repository.dart';
import 'package:todos_app/myapp.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_app/redux/app_store.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';
import 'package:todos_app/services/todos/todos_map_repository.dart';
import 'package:todos_app/services/todos/todos_service.dart';

final serviceLocator = GetIt.instance;
Future<void> configureDependencies() async {
  serviceLocator
      .registerSingleton<BaseRepository<TodoModel>>(TodosMapRepository());
  serviceLocator.registerSingleton<TodosService>(TodosService());
}

void main() async {
  await configureDependencies();
  runApp(MyApp(store: configureStore()));
}
