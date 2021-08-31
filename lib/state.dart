import 'package:meta/meta.dart';

@immutable
class State<Model> {
  final Model? model;
  final bool? isLoading;

  const State({
    this.model,
    this.isLoading,
  });

  factory State.init(Model intialModel) {
    return State<Model>(
      isLoading: false,
      model: intialModel,
    );
  }
  State<Model> copyWith({
    Model? model,
    bool? isLoading,
  }) {
    return State(
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
