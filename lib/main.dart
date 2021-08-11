import 'package:flutter/material.dart';
import './redux/app_store.dart';
import './app.dart';
import './library/base/base_repository.dart';
import './redux/reducers/todos/todos_model.dart';
import './services/todos/todos_map_repository.dart';
import './services/todos/todos_service.dart';
import 'package:get_it/get_it.dart';

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
