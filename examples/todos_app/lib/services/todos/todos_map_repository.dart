import 'package:todos_app/library/base/base_repository.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

class TodosMapRepository implements BaseRepository<TodoModel>{
  static List<Map> dbMaps = [
    {
      "id": "1",
      "title": "Red wine from Rioja, Spain",
      "description": "Hello Description",
      "marked": false
    },
    {
      "id": "2",
      "title": "Red wine from Rioja, Spain",
      "description": "Hello Description",
      "marked": false
    },
    {
      "id": "3", 
      "title": "Red wine from Rioja, Spain",
      "description": "Hello Description",
      "marked": false
    }
  ];

  @override
  Future<List<TodoModel>> find() async {
    List<TodoModel> result = dbMaps.map<TodoModel>((map) {
      final todo = TodoModel.fromMap(Map<String, dynamic>.from(map));
      return todo;
    }).toList();
    return result;
  }

  @override
  Future insert(TodoModel model) async {
    dbMaps.add(model.toMap());
  }

  @override
  Future<TodoModel> findOne(String id) async {
    final entity = dbMaps.singleWhere((element) => element["id"] == id);
    return TodoModel.fromMap(Map<String,dynamic>.from(entity));
  }

  @override
  void remove(String id) async {
    dbMaps.removeWhere((item) => item["id"] == id);
  }

  @override
  Future update(TodoModel newModel) async {
    String modelId = newModel.id;
    for (var element in dbMaps) {
      if (element["id"] == modelId) {
        element = newModel.toMap();
      }
    }
  }
}
