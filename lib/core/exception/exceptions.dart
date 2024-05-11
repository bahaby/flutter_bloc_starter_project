enum CacheExceptionType {
  notFound,
  expired,
  invalid,
  unknown;

  String get translateKey {
    switch (this) {
      case CacheExceptionType.notFound:
        return 'core.errors.cache.notFound';
      case CacheExceptionType.expired:
        return 'core.errors.cache.expired';
      case CacheExceptionType.invalid:
        return 'core.errors.cache.invalid';
      case CacheExceptionType.unknown:
        return 'core.errors.cache.unknown';
    }
  }
}

enum JsonSerializationExceptionType {
  invalidData,
  invalidJson;

  String get translateKey {
    switch (this) {
      case JsonSerializationExceptionType.invalidData:
        return 'core.errors.others.somethingWentWrong';
      case JsonSerializationExceptionType.invalidJson:
        return 'core.errors.others.somethingWentWrong';
    }
  }
}

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
