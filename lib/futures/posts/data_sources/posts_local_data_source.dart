import 'package:flutter_bloc_starter_project/core/modules/storage/objectbox_storage.dart';
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
  final ObjectBoxStorage _objectBoxStorage;

  PostsLocalDataSourceImpl({required ObjectBoxStorage objectBoxStorage})
      : _objectBoxStorage = objectBoxStorage;

  @override
  Future<void> savePosts(List<PostModel> posts, int skip) async {
    await _objectBoxStorage.putAll(posts);
  }

  @override
  Future<PaginatedModel<PostModel>> getPosts(int skip, int limit) async {
    final posts = await _objectBoxStorage.list<PostModel>(skip, limit);
    return posts;
  }

  @override
  Future<void> saveSinglePost(PostModel post) async {
    await _objectBoxStorage.save(post);
  }

  @override
  Future<PostModel> getSinglePost(int id) async {
    final post = await _objectBoxStorage.get<PostModel>(id);

    return post;
  }

  @override
  Future<void> clear() async {
    await _objectBoxStorage.clear();
  }
}
