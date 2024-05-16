import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';
import 'package:flutter_bloc_starter_project/core/data/local_data_source.dart';
import 'package:flutter_bloc_starter_project/core/data/remote_data_source.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../core/exception/exception_handler.dart';
import '../models/alert_model.dart';
import '../models/paginated_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class DataRepository<T> {
  final RemoteDataSource<T> _remoteDataSource;
  final LocalDataSource<T> _localDataSource;
  final InternetConnection _networkInfo;

  DataRepository({
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
        for (var element in items.posts) {
          await _localDataSource.save(element);
        }
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
