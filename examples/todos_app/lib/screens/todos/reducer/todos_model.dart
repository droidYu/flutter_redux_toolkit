import "package:built_value/built_value.dart";
import 'package:built_value/serializer.dart';
import 'package:todos_app/library/serializers.dart';
import 'package:uuid/uuid.dart';
part 'todos_model.g.dart';

abstract class TodoModel implements Built<TodoModel, TodoModelBuilder> {
  String get id;
  String get title;
  String get description;
  bool get marked;
  TodoModel._();

  static TodoModel create(String title, String description) {
    final newModel = TodoModel((vm) => vm
      ..id = const Uuid().v4()
      ..title = title
      ..description = description
      ..marked = false);
    return newModel;
  }

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(TodoModel.serializer, this)
        as Map<String, dynamic>;
  }

  static TodoModel fromMap(Map<String, dynamic> json) {
    return serializers.deserializeWith(TodoModel.serializer, json) as TodoModel;
  }

  // to serialize WineInfoModel, please add WineInfoModel into SerializersFor notation of lib/library/serializers.dart
  static Serializer<TodoModel> get serializer => _$todoModelSerializer;

  factory TodoModel([void Function(TodoModelBuilder) updates]) = _$TodoModel;
}
