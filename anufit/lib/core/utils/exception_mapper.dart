import 'package:anufit/core/errors/failures.dart';
import 'package:anufit/core/exceptions/app_exception.dart';

Failure mapExceptionToFailure(AppException exception) {
  return switch (exception) {
    ServerException() => ServerFailure(exception.message),
    CacheException() => CacheFailure(exception.message),
    NetworkException() => NetworkFailure(exception.message),
  };
}
