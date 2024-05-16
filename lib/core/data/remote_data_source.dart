import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';
import 'package:flutter_bloc_starter_project/core/data/data_source.dart';
import 'package:flutter_bloc_starter_project/core/data/model_binding.dart';

import '../exception/exception_handler.dart';
import '../../futures/app/models/paginated_model.dart';

class RemoteDataSource<T> implements DataSource<T> {
  final Dio _client;
  final String _basePath;
  final ModelBindings<T> _bindings;
  RemoteDataSource({
    required String basePath,
  })  : _basePath = basePath,
        _client = di<Dio>(),
        _bindings = di<ModelBindings<T>>();

  @override
  Future<T> get(int id) async {
    final response = await _client.get('$_basePath/$id');

    return fromJsonHandler(
      () => _bindings.fromJson(response.data),
      payload: response.data,
    );
  }

  @override
  Future<PaginatedModel<T>> list({
    required int skip,
    required int limit,
  }) async {
    final response = await _client.get('$_basePath?skip=$skip&limit=$limit');

    final posts = fromJsonHandler(() {
      return PaginatedModel<T>.fromJson(
        response.data,
        (json) => _bindings.fromJson(json as Map<String, dynamic>),
      );
    }, payload: response.data);
    return posts;
  }

  @override
  Future<void> save(T item) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
