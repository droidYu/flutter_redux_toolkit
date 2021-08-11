import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_model.dart';
import 'package:flutter_redux_toolkit/library/base/base_repository.dart';

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

  Future<List<TodoModel>> find() async {
    List<TodoModel> result = dbMaps.map<TodoModel>((map) {
      final todo = TodoModel.fromMap(new Map<String, dynamic>.from(map));
      return todo;
    }).toList();
    return result;
  }

  Future insert(TodoModel model) async {
    dbMaps.add(model.toMap());
  }

  Future<TodoModel> findOne(String id) async {
    final entity = dbMaps.singleWhere((element) => element["id"] == id);
    return TodoModel.fromMap(new Map<String,dynamic>.from(entity));
  }

  void remove(String id) async {
    dbMaps.removeWhere((item) => item["id"] == id);
  }

  Future update(TodoModel newModel) async {
    String modelId = newModel.id;
    dbMaps.forEach((element) {
      if (element["id"] == modelId) {
        element = newModel.toMap();
      }
    });
  }
}
