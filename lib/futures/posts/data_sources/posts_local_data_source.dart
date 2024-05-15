import '../../../core/exception/exception_types.dart';
import '../../../core/exception/exceptions.dart';
import '../../../core/modules/hive_storage/hive_storage.dart';
import '../../app/models/paginated_model.dart';
import 'package:injectable/injectable.dart';

import '../models/post_model.dart';

abstract interface class PostsLocalDataSource {
  Future<void> savePosts(List<PostModel> posts, int skip);
  Future<PaginatedModel<PostModel>> getPosts(int skip, int limit);
  Future<PostModel> getSinglePost(int id);
  Future<void> saveSinglePost(PostModel post);
  Future<void> clear();
}

@LazySingleton(as: PostsLocalDataSource)
class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final HiveStorage _hiveStorage;

  PostsLocalDataSourceImpl({required HiveStorage hiveStorage})
      : _hiveStorage = hiveStorage;

  @override
  Future<void> savePosts(List<PostModel> posts, int skip) async {
    await _hiveStorage.putAll(posts, skip);
  }

  @override
  Future<PaginatedModel<PostModel>> getPosts(int skip, int limit) async {
    final posts = await _hiveStorage.getAll<PostModel>();
    final paginatedPosts = PaginatedModel<PostModel>(
      total: posts.length,
      limit: limit,
      skip: skip,
      posts: posts.skip(skip).take(limit).toList(),
    );
    return paginatedPosts;
  }

  @override
  Future<void> saveSinglePost(PostModel post) async {
    await _hiveStorage.put(post.id.toString(), post);
  }

  @override
  Future<PostModel> getSinglePost(int id) async {
    final post = await _hiveStorage.get<PostModel>(id.toString());

    if (post != null) {
      return post;
    }

    throw CacheException(type: CacheExceptionType.notFound, payload: id);
  }

  @override
  Future<void> clear() async {
    await _hiveStorage.clear();
  }
}
