import 'package:flutter_bloc_starter_project/core/modules/storage/objectbox_storage.dart';

import '../models/paginated_model.dart';

abstract class LocalDataSource<T> {
  final ObjectBoxStorage storage;
  LocalDataSource({required this.storage});

  Future<T> get(int id);
  Future<void> save(T item);
  Future<PaginatedModel<T>> list({
    required int skip,
    required int limit,
  });
}
