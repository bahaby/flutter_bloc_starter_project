import 'exception_types.dart';
import 'exceptions.dart';
import '../utils/methods/aliases.dart';
import '../utils/router.gr.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../futures/app/models/alert_model.dart';

typedef RepositoryFunction<T> = Future<Either<AlertModel, T>> Function();

Future<Either<AlertModel, T>> exceptionHandler<T>(
    RepositoryFunction<T> repositoryFunction) async {
  try {
    return await repositoryFunction();
  } catch (e) {
    AlertModel alert;

    alert = e is Exception
        ? AlertModel.exception(exception: e)
        : AlertModel.alert(
            message: e.toString(),
            type: AlertType.error,
          );
    if (e is RevokeTokenException) {
      appRouter.replaceAll([const AuthWrapper()]);
    }

    reportException(e);

    return Either.left(alert);
  }
}

T fromJsonHandler<T>(T Function() fromJsonFunction, {dynamic payload}) {
  try {
    return fromJsonFunction();
  } catch (e) {
    reportException(e);
    throw JsonSerializationException(
      type: JsonSerializationExceptionType.invalidJson,
      payload: payload,
    );
  }
}

void reportException(Object e) {
  Sentry.captureException(
    e,
  );
}
