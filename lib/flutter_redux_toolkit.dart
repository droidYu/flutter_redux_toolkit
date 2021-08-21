library flutter_redux_toolkit;

export 'base_state.dart';
export 'base_sync_actions.dart';
export 'base_async_actions.dart';
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
