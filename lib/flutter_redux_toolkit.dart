library flutter_redux_toolkit;

export 'base/base_state.dart';
export 'base/base_sync_actions.dart';
export 'base/base_async_actions.dart';

export 'new/async_actions.dart';
export 'new/sync_actions.dart';
export 'new/async_actions.dart';
export 'new/state.dart';
export 'store_hook_widget.dart';

abstract class BaseRepository<T> {
  Future<List<T>> find();
  Future insert(T t);
  Future<T> findOne(String id);
  void remove(String id);
  Future update(T t);
}

abstract class BaseListAction<T> {
  List<T> items;
  BaseListAction(this.items);
}
