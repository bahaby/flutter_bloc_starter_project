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
}
