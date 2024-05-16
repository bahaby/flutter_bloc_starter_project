import '../models/alert_model.dart';
import '../models/paginated_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DataRepository<T> {
  Future<Either<AlertModel, PaginatedModel<T>>> list(
      {required int limit, required int skip});
  Future<Either<AlertModel, T>> getSingle(int id);
}
