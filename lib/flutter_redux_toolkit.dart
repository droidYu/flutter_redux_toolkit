library flutter_redux_toolkit;

export 'async_actions.dart';
export 'sync_actions.dart';
export 'async_actions.dart';
export 'state.dart';
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
