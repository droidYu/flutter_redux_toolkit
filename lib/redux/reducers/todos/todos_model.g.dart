// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TodoModel> _$todoModelSerializer = new _$TodoModelSerializer();

class _$TodoModelSerializer implements StructuredSerializer<TodoModel> {
  @override
  final Iterable<Type> types = const [TodoModel, _$TodoModel];
  @override
  final String wireName = 'TodoModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TodoModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'marked',
      serializers.serialize(object.marked, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  TodoModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TodoModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'marked':
          result.marked = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$TodoModel extends TodoModel {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final bool marked;

  factory _$TodoModel([void Function(TodoModelBuilder)? updates]) =>
      (new TodoModelBuilder()..update(updates)).build();

  _$TodoModel._(
      {required this.id,
      required this.title,
      required this.description,
      required this.marked})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'TodoModel', 'id');
    BuiltValueNullFieldError.checkNotNull(title, 'TodoModel', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, 'TodoModel', 'description');
    BuiltValueNullFieldError.checkNotNull(marked, 'TodoModel', 'marked');
  }

  @override
  TodoModel rebuild(void Function(TodoModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoModelBuilder toBuilder() => new TodoModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoModel &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        marked == other.marked;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), title.hashCode), description.hashCode),
        marked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoModel')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('marked', marked))
        .toString();
  }
}

class TodoModelBuilder implements Builder<TodoModel, TodoModelBuilder> {
  _$TodoModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _marked;
  bool? get marked => _$this._marked;
  set marked(bool? marked) => _$this._marked = marked;

  TodoModelBuilder();

  TodoModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _marked = $v.marked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TodoModel;
  }

  @override
  void update(void Function(TodoModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoModel build() {
    final _$result = _$v ??
        new _$TodoModel._(
            id: BuiltValueNullFieldError.checkNotNull(id, 'TodoModel', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, 'TodoModel', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, 'TodoModel', 'description'),
            marked: BuiltValueNullFieldError.checkNotNull(
                marked, 'TodoModel', 'marked'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
