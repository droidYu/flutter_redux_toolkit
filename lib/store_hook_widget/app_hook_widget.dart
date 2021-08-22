import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppHookWidget<ViewModel> extends HookWidget {
  AppHookWidget({Key? key, required this.buildFunc, required this.vm})
      : super(key: key);

  final Widget Function(BuildContext) buildFunc;
  final ViewModel vm;

  @override
  Widget build(BuildContext context) => buildFunc(context);
}
