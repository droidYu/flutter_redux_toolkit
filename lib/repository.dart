abstract class BaseRepository<T> {
  Future<List<T>?> find();
  Future insert(T t);
  Future<T?> findOne(String id);
  void remove(String id);
  Future update(T t);
}
