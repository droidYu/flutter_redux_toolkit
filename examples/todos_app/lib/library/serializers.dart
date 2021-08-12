import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:todos_app/screens/todos/reducer/todos_model.dart';

part 'serializers.g.dart';

@SerializersFor([TodoModel])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
