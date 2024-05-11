import '../../app/models/paginated_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../core/exception/exception_handler.dart';
import '../../app/models/alert_model.dart';
import '../../app/repositories/base_repository.dart';
import '../data_sources/posts_local_data_source.dart';
import '../data_sources/posts_remote_data_source.dart';
import '../models/post_model.dart';

abstract interface class PostsRepository implements BaseRepository<PostModel> {
  @override
  Future<Either<AlertModel, PaginatedModel<PostModel>>> list({
    required int skip,
    required int limit,
  });

  @override
  Future<Either<AlertModel, PostModel>> getSingle(int id);
}

@LazySingleton(as: BaseRepository<PostModel>)
class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocalDataSource _localDataSource;
  final InternetConnection _networkInfo;

  PostsRepositoryImpl({
    required PostsRemoteDataSource remoteDataSource,
    required PostsLocalDataSource localDataSource,
    required InternetConnection networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<AlertModel, PaginatedModel<PostModel>>> list({
    required int skip,
    required int limit,
  }) async {
    return exceptionHandler(() async {
      if (await _networkInfo.hasInternetAccess) {
        final posts =
            await _remoteDataSource.getPosts(skip: skip, limit: limit);
        await _localDataSource.savePosts(posts.posts, skip);
        return right(posts);
      } else {
        final cachedPosts = await _localDataSource.getPosts(skip, limit);
        return right(cachedPosts);
      }
    });
  }

  @override
  Future<Either<AlertModel, PostModel>> getSingle(
    int id,
  ) async {
    return exceptionHandler(() async {
      if (await _networkInfo.hasInternetAccess) {
        final post = await _remoteDataSource.getSinglePost(id: id);
        await _localDataSource.saveSinglePost(post);
        return right(post);
      } else {
        final cachedPost = await _localDataSource.getSinglePost(id);

        return right(cachedPost);
      }
    });
  }
}
