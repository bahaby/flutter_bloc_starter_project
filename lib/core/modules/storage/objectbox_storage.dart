import 'package:flutter_bloc_starter_project/futures/app/models/paginated_model.dart';
import 'package:injectable/injectable.dart';

import '../../exception/exception_types.dart';
import '../../exception/exceptions.dart';
import '../../generated/objectbox.g.dart';

@singleton
class ObjectBoxStorage {
  ObjectBoxStorage(this._store);
  final Store _store;

  Future<T> get<T>(int id) async {
    final item = await _getBox<T>().getAsync(id);
    if (item == null) {
      throw CacheException(type: CacheExceptionType.notFound);
    }
    return item;
  }

  Future<void> save<T>(T item) async {
    await _getBox<T>().putAsync(item);
  }

  Future<void> remove<T>(int id) async {
    await _getBox<T>().removeAsync(id);
  }

  Future<void> clear<T>() async {
    await _getBox<T>().removeAllAsync();
  }

  Future<PaginatedModel<T>> list<T>(int skip, int limit) async {
    final query = _getBox<T>().query().build();
    final total = query.count();
    query
      ..limit = limit
      ..offset = skip;
    final items = query.find();
    return PaginatedModel<T>(
      total: total,
      limit: limit,
      skip: skip,
      items: items,
    );
  }

  Future<void> putAll<T>(List<T> items) async {
    await _getBox<T>().putManyAsync(items);
  }

  Box<T> _getBox<T>() {
    return _store.box<T>();
  }
}
