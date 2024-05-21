import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/data/data_repository.dart';
import 'package:flutter_bloc_starter_project/core/exception/exception_handler.dart';
import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';

import '../../futures/app/models/paginated_model.dart';

class RemoteDataSource<T> {
  final Future<Response> Function(int id) getHandler;
  final Future<Response> Function({
    required int skip,
    required int limit,
  }) listHandler;
  final ModelBindings<T> bindings;
  RemoteDataSource({
    required this.getHandler,
    required this.listHandler,
  }) : bindings = di<ModelBindings<T>>();

  Future<T> get(int id) async {
    return fromJsonHandler(() async {
      final response = await getHandler(id);
      return bindings.fromJson(response.data);
    });
  }

  Future<PaginatedModel<T>> list(
      {required int skip, required int limit}) async {
    return fromJsonHandler(() async {
      final response = await listHandler(skip: skip, limit: limit);

      // This is a hack to convert the response to PaginatedModel
      // Paginated models should have a key 'items' or similar generic name that contains the list of items
      // This is not the case for the response from the dummjson API
      var dataMap = response.data as Map<String, dynamic>;
      final firstKey = dataMap.keys.first;
      final firstValue = dataMap.remove(firstKey);
      dataMap['items'] = firstValue;
      return PaginatedModel.fromJson(
        response.data,
        (json) => bindings.fromJson(json as Map<String, dynamic>),
      );
    });
  }
}
