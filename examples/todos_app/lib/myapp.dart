import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todos_app/screens/todos/todos_screen_store_hook.dart';
import 'package:todos_app/settings/routes.dart';
import 'redux/app_state.dart';

class MyApp extends StatelessWidget {
  final Store store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store as Store<AppState>,
      child: MaterialApp(
        title: 'Redux Example',
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('zh', ''), // Chinese, no country code
        ],
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.home: (context) => TodosScreenWidgetStoreContentHook(),
        },
      ),
    );
  }
}
