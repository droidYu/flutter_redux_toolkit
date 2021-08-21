import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

abstract class StoreConnectorWidget<State, ViewModel> extends StatelessWidget {
  StoreConnectorWidget({
    Key? key,
    required this.fromStore,
  }) : super(key: key);

  final ViewModel Function(Store<State>) fromStore;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<State, ViewModel>(
      converter: fromStore,
      builder: (context, vm) => buildWithVM(context, vm),
    );
  }

  Widget buildWithVM(BuildContext context, ViewModel vm) => Container();
}
