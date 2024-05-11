import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/exception/dio_exceptions.dart';
import '../../../core/exception/exceptions.dart';
import '../../../core/utils/methods/aliases.dart';

part 'alert_model.freezed.dart';

enum AlertType {
  constructive,
  destructive,
  error,
  notification,
  exception,
  quiet
}

@freezed
class AlertModel with _$AlertModel {
  const factory AlertModel({
    required String message,
    required AlertType type,
    @Default(false) bool translatable,
  }) = _AlertModel;

  factory AlertModel.alert({
    required String message,
    required AlertType type,
    bool translatable = false,
  }) {
    if (type == AlertType.error) {
      logIt.error(message);
    }

    return AlertModel(
      message: message,
      type: type,
      translatable: translatable,
    );
  }

  factory AlertModel.exception({
    required dynamic exception,
    StackTrace? stackTrace,
  }) {
    String message;
    var translatable = false;
    if (exception is TranslatableException) {
      message = exception.translationKey;
      translatable = true;
    } else if (exception is ApiMessageException) {
      message = exception.errorMessage;
    } else if (exception is DioException) {
      if (exception.message != null) {
        message = exception.message!;
      } else {
        translatable = true;
        message = 'core.errors.others.anUnknownError';
      }
    } else {
      message = exception.toString();
    }

    return AlertModel(
      message: message,
      type: AlertType.exception,
      translatable: translatable,
    );
  }

  factory AlertModel.initial() =>
      AlertModel.alert(message: '', type: AlertType.quiet);

  factory AlertModel.quiet() {
    return const AlertModel(
      message: '',
      type: AlertType.quiet,
    );
  }
}
