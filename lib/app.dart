import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_toolkit/screens/todos/todos_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_toolkit/theme/app_theme_data.dart';
import 'theme/light_theme.dart';
import 'theme/themed_widget.dart';
import 'settings/routes.dart';
import 'redux/app_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  final Store store;

  MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: store as Store<AppState>,
        child: ThemedWidget(
          theme: LightTheme(),
          child: MaterialApp(
            title: 'Redux Example',
            theme: AppThemeData.lightTheme,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''), // English, no country code
              Locale('zh', ''), // Chinese, no country code
            ],
            debugShowCheckedModeBanner: false,
            routes: {
              Routes.home: (context) => TodosScreen(),
            },
          ),
        ));
  }
}
