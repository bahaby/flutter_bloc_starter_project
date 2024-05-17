import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';
import 'package:flutter_bloc_starter_project/core/modules/storage/objectbox_storage.dart';

import '../../futures/app/models/paginated_model.dart';

class LocalDataSource<T> {
  final ObjectBoxStorage _storage;
  LocalDataSource() : _storage = di<ObjectBoxStorage>();

  Future<T> get(int id) async {
    return await _storage.get<T>(id);
  }

  Future<void> save(T item) async {
    await _storage.save<T>(item);
  }

  Future<PaginatedModel<T>> list({
    required int skip,
    required int limit,
  }) async {
    return await _storage.list<T>(skip, limit);
  }

  Future<void> saveAll(List<T> items) async {
    await _storage.putAll<T>(items);
  }
}
