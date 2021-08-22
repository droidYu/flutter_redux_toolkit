import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'store_hook_widget/app_hook_widget.dart';
import 'store_hook_widget/store_connector_widget.dart';

abstract class StoreHookWidget<State, ViewModel>
    extends StoreConnectorWidget<State, ViewModel> {
  StoreHookWidget({
    Key? key,
    required ViewModel Function(Store<State>) fromStore,
  }) : super(key: key, fromStore: fromStore);

  @override
  Widget buildWithVM(BuildContext context, ViewModel vm) =>
      AppHookWidget(vm: vm, buildFunc: (ctx) => buildWithVMHook(ctx, vm));

  Widget buildWithVMHook(BuildContext context, ViewModel vm) => Container();
}
