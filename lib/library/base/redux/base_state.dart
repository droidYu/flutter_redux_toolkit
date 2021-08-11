import "package:meta/meta.dart";

@immutable
class BaseState<Model> {
  final Model? model;
  final bool? isLoading;

  BaseState({
    this.model,
    this.isLoading,
  });

  factory BaseState.initial(Model intialModel) {
    return BaseState<Model>(
      isLoading: false,
      model: intialModel,
    );
  }
  BaseState<Model> copyWith({
    Model? model,
    bool? isLoading,
  }) {
    return BaseState(
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
