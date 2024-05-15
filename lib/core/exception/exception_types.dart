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
