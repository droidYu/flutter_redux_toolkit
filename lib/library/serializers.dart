import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_redux_toolkit/redux/reducers/todos/todos_model.dart';

part 'serializers.g.dart';

//@SerializersFor([WineDetailsModel])
@SerializersFor([TodoModel])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
