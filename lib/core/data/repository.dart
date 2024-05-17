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

abstract class Repository<T> {
  final RemoteDataSource<T> _remoteDataSource;
  final LocalDataSource<T> _localDataSource;
  final InternetConnection _networkInfo;

  Repository({
    required networkInfo,
    required RemoteDataSource<T> remoteDataSource,
    required LocalDataSource<T> localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  Future<Either<AlertModel, PaginatedModel<T>>> list(
      {required int limit, required int skip}) async {
    return exceptionHandler(() async {
      if (await _networkInfo.hasInternetAccess) {
        final items = await _remoteDataSource.list(skip: skip, limit: limit);
        await _localDataSource.saveAll(items.items);
        return right(items);
      } else {
        final cachedItems =
            await _localDataSource.list(skip: skip, limit: limit);
        return right(cachedItems);
      }
    });
  }

  Future<Either<AlertModel, T>> get(int id) async {
    return exceptionHandler(() async {
      if (await _networkInfo.hasInternetAccess) {
        final item = await _remoteDataSource.get(id);
        await _localDataSource.save(item);
        return right(item);
      } else {
        final cachedItem = await _localDataSource.get(id);
        return right(cachedItem);
      }
    });
  }
}
