import 'package:flutter/widgets.dart';

import 'app_theme.dart';

class ThemedWidget extends InheritedWidget {
  ThemedWidget({required this.theme, required Widget child})
      : super(child: child);
  final AppTheme theme;

  @override
  bool updateShouldNotify(covariant ThemedWidget oldWidget) =>
      theme.appBackgroundColor() != oldWidget.theme.appBackgroundColor();

  static ThemedWidget of(BuildContext context) {
    var r = context.dependOnInheritedWidgetOfExactType<ThemedWidget>();
    if (r == null) throw NullThrownError();
    return r;
  }
}
