import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsClient {
  PostsClient({
    required Dio client,
  }) : _client = client;

  final Dio _client;
  final String _basePath = 'posts';

  Future<Response> list({
    required int skip,
    required int limit,
  }) async {
    return await _client.get(
      _basePath,
      queryParameters: {
        'skip': skip,
        'limit': limit,
      },
    );
  }

  Future<Response> get(int id) async {
    return await _client.get('$_basePath/$id');
  }

  // Example: Implement specific functionality if needed
  Future<Response> somethingElse() async {
    return Future.value(Response(
      requestOptions: RequestOptions(path: '$_basePath/somethingElse'),
    ));
    //return await _client.get('$_basePath/somethingElse');
  }
}
