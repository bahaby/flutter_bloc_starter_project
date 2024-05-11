import 'package:dio/dio.dart';
import '../../../core/exception/exception_handler.dart';
import '../../app/models/paginated_model.dart';
import '../models/post_model.dart';
import 'package:injectable/injectable.dart';

abstract interface class PostsRemoteDataSource {
  Future<PaginatedModel<PostModel>> getPosts({
    required int skip,
    required int limit,
  });

  Future<PostModel> getSinglePost({
    required int id,
  });
}

@LazySingleton(as: PostsRemoteDataSource)
class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  static const String _postsPath = 'posts';

  final Dio _client;
  PostsRemoteDataSourceImpl({required Dio client}) : _client = client;

  @override
  Future<PaginatedModel<PostModel>> getPosts({
    required int skip,
    required int limit,
  }) async {
    final response = await _client.get('$_postsPath?skip=$skip&limit=$limit');

    final posts = fromJsonHandler(() {
      return PaginatedModel<PostModel>.fromJson(
        response.data,
        (json) => PostModel.fromJson(json as Map<String, dynamic>),
      );
    }, payload: response.data);
    return posts;
  }

  @override
  Future<PostModel> getSinglePost({
    required int id,
  }) async {
    final response = await _client.get('$_postsPath/$id');

    return fromJsonHandler(
      () => PostModel.fromJson(response.data),
      payload: response.data,
    );
  }
}
