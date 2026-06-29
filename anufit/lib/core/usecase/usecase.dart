/// Base contract for all use cases.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Use when a use case requires no parameters.
class NoParams {
  const NoParams();
}
