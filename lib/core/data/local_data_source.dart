import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';
import 'package:flutter_bloc_starter_project/core/modules/storage/objectbox_storage.dart';

import '../../futures/app/models/paginated_model.dart';
import 'data_source.dart';

class LocalDataSource<T> implements DataSource<T> {
  final ObjectBoxStorage _storage;
  LocalDataSource() : _storage = di<ObjectBoxStorage>();

  @override
  Future<T> get(int id) async {
    return await _storage.get<T>(id);
  }

  @override
  Future<void> save(T item) async {
    await _storage.save<T>(item);
  }

  @override
  Future<PaginatedModel<T>> list({
    required int skip,
    required int limit,
  }) async {
    return await _storage.list<T>(skip, limit);
  }
}
