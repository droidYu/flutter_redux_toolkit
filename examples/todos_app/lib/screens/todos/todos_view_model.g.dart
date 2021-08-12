// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TodosViewModel extends TodosViewModel {
  @override
  final BuiltList<TodoModel> todos;
  @override
  final void Function() findTodos;
  @override
  final void Function(TodoModel) insertTodo;
  @override
  final void Function(String) removeTodo;

  factory _$TodosViewModel([void Function(TodosViewModelBuilder)? updates]) =>
      (new TodosViewModelBuilder()..update(updates)).build();

  _$TodosViewModel._(
      {required this.todos,
      required this.findTodos,
      required this.insertTodo,
      required this.removeTodo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(todos, 'TodosViewModel', 'todos');
    BuiltValueNullFieldError.checkNotNull(
        findTodos, 'TodosViewModel', 'findTodos');
    BuiltValueNullFieldError.checkNotNull(
        insertTodo, 'TodosViewModel', 'insertTodo');
    BuiltValueNullFieldError.checkNotNull(
        removeTodo, 'TodosViewModel', 'removeTodo');
  }

  @override
  TodosViewModel rebuild(void Function(TodosViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodosViewModelBuilder toBuilder() =>
      new TodosViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodosViewModel && todos == other.todos;
  }

  @override
  int get hashCode {
    return $jf($jc(0, todos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodosViewModel')
          ..add('todos', todos)
          ..add('findTodos', findTodos)
          ..add('insertTodo', insertTodo)
          ..add('removeTodo', removeTodo))
        .toString();
  }
}

class TodosViewModelBuilder
    implements Builder<TodosViewModel, TodosViewModelBuilder> {
  _$TodosViewModel? _$v;

  ListBuilder<TodoModel>? _todos;
  ListBuilder<TodoModel> get todos =>
      _$this._todos ??= new ListBuilder<TodoModel>();
  set todos(ListBuilder<TodoModel>? todos) => _$this._todos = todos;

  void Function()? _findTodos;
  void Function()? get findTodos => _$this._findTodos;
  set findTodos(void Function()? findTodos) => _$this._findTodos = findTodos;

  void Function(TodoModel)? _insertTodo;
  void Function(TodoModel)? get insertTodo => _$this._insertTodo;
  set insertTodo(void Function(TodoModel)? insertTodo) =>
      _$this._insertTodo = insertTodo;

  void Function(String)? _removeTodo;
  void Function(String)? get removeTodo => _$this._removeTodo;
  set removeTodo(void Function(String)? removeTodo) =>
      _$this._removeTodo = removeTodo;

  TodosViewModelBuilder();

  TodosViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _todos = $v.todos.toBuilder();
      _findTodos = $v.findTodos;
      _insertTodo = $v.insertTodo;
      _removeTodo = $v.removeTodo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodosViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TodosViewModel;
  }

  @override
  void update(void Function(TodosViewModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TodosViewModel build() {
    _$TodosViewModel _$result;
    try {
      _$result = _$v ??
          new _$TodosViewModel._(
              todos: todos.build(),
              findTodos: BuiltValueNullFieldError.checkNotNull(
                  findTodos, 'TodosViewModel', 'findTodos'),
              insertTodo: BuiltValueNullFieldError.checkNotNull(
                  insertTodo, 'TodosViewModel', 'insertTodo'),
              removeTodo: BuiltValueNullFieldError.checkNotNull(
                  removeTodo, 'TodosViewModel', 'removeTodo'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'todos';
        todos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodosViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
