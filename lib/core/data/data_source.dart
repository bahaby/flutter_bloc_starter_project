import 'package:flutter_bloc_starter_project/futures/app/models/paginated_model.dart';

abstract interface class DataSource<T> {
  Future<T> get(int id);
  Future<void> save(T item);
  Future<PaginatedModel<T>> list({
    required int skip,
    required int limit,
  });
}
