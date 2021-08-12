import 'package:get_it/get_it.dart';
import 'package:todos_app/library/base/base_repository.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

final serviceLocator = GetIt.instance;

class TodosService {
  late BaseRepository<TodoModel> todosRepository;
  TodosService() {
    todosRepository = serviceLocator.get<BaseRepository<TodoModel>>();
  }

  Future<bool> insert(TodoModel model) async {
    try {
      await todosRepository.insert(model);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<TodoModel>> find() async {
    return todosRepository.find();
  }

  Future<TodoModel> findOne(int id) async {
    return todosRepository.findOne(id as String);
  }

  Future<bool> update(TodoModel newModel) async {
    String modelId = newModel.id;
    final TodoModel? model = await todosRepository.findOne(modelId);
    if (model == null) {
      return false;
    }
    try {
      await todosRepository.update(newModel);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> remove(String id) async {
    final TodoModel? model = await todosRepository.findOne(id);
    if (model == null) {
      return false;
    }
    try {
      todosRepository.remove(id);
    } catch (e) {
      return false;
    }
    return true;
  }
}
