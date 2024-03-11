sealed class BaseState {
  const BaseState();
}

final class InitialState extends BaseState {
  const InitialState();
}

final class LoadingState extends BaseState {
  const LoadingState();
}

final class ErrorState extends BaseState {
  final String message;
  const ErrorState({required this.message});
}

final class EmptyListState extends BaseState {
  const EmptyListState();
}

final class SuccessState<T> extends BaseState {
  final T data;
  const SuccessState({required this.data});
}
