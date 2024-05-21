import 'package:flutter_bloc_starter_project/core/data/local_data_source.dart';
import 'package:flutter_bloc_starter_project/core/data/remote_data_source.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../exception/exception_handler.dart';
import '../../futures/app/models/alert_model.dart';
import '../../futures/app/models/paginated_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ModelBindings<T> {
  const ModelBindings();

  int? getId(T obj);

  Map<String, Object?> toJson(T obj);

  T fromJson(Map<String, Object?> json);

  int sortDesc(T a, T b);
}

// Modify and use this generic data structure
// if you have similar data repositories that have same methods
// Example: posts_repository.dart
abstract class DataRepository<T> {
  final RemoteDataSource<T> remoteDataSource;
  final LocalDataSource<T> localDataSource;
  final InternetConnection networkInfo;

  DataRepository({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<AlertModel, PaginatedModel<T>>> list(
      {required int limit, required int skip}) async {
    return exceptionHandler(() async {
      if (await networkInfo.hasInternetAccess) {
        final items = await remoteDataSource.list(skip: skip, limit: limit);
        await localDataSource.saveAll(items.items);
        return right(items);
      } else {
        final cachedItems =
            await localDataSource.list(skip: skip, limit: limit);
        return right(cachedItems);
      }
    });
  }

  Future<Either<AlertModel, T>> get(int id) async {
    return exceptionHandler(() async {
      if (await networkInfo.hasInternetAccess) {
        final item = await remoteDataSource.get(id);
        await localDataSource.save(item);
        return right(item);
      } else {
        final cachedItem = await localDataSource.get(id);
        return right(cachedItem);
      }
    });
  }
}
