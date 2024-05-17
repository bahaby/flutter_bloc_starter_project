import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';

import '../exception/exception_handler.dart';
import '../../futures/app/models/paginated_model.dart';
import 'repository.dart';

class RemoteDataSource<T> {
  final Dio _client;
  final String _basePath;
  final ModelBindings<T> _bindings;
  RemoteDataSource({
    required String basePath,
  })  : _basePath = basePath,
        _client = di<Dio>(),
        _bindings = di<ModelBindings<T>>();

  Future<T> get(int id) async {
    final response = await _client.get('$_basePath/$id');

    return fromJsonHandler(
      () => _bindings.fromJson(response.data),
      payload: response.data,
    );
  }

  Future<PaginatedModel<T>> list({
    required int skip,
    required int limit,
  }) async {
    final response = await _client.get('$_basePath?skip=$skip&limit=$limit');

    final posts = fromJsonHandler(() {
      // This is a hack to convert the response to PaginatedModel
      // Paginated models should have a key 'items' or similar generic name that contains the list of items
      // This is not the case for the response from the dummjson API
      var dataMap = response.data as Map<String, dynamic>;
      var firstKey = dataMap.keys.first;
      var firstValue = dataMap.remove(firstKey);
      dataMap['items'] = firstValue;

      return PaginatedModel<T>.fromJson(
        response.data,
        (json) => _bindings.fromJson(json as Map<String, dynamic>),
      );
    }, payload: response.data);
    return posts;
  }
}
