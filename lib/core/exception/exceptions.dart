import 'package:flutter_bloc_starter_project/core/exception/exception_types.dart';

mixin TranslatableException {
  String get translationKey;
}

abstract class AppException with TranslatableException implements Exception {
  final dynamic payload;

  AppException({
    this.payload,
  });
}

///for new AppExceptions you also need to create a new type Enum. Check [CacheExceptionType].
class CacheException extends AppException {
  CacheException({
    required this.type,
    super.payload,
  });

  final CacheExceptionType type;

  @override
  String get translationKey => type.translateKey;
}

class JsonSerializationException extends AppException {
  JsonSerializationException({
    required this.type,
    super.payload,
  });
  final JsonSerializationExceptionType type;

  @override
  String get translationKey => type.translateKey;
}
