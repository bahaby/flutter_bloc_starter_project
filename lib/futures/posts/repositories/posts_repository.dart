import 'package:flutter_bloc_starter_project/core/data/local_data_source.dart';
import 'package:flutter_bloc_starter_project/futures/posts/clients/posts_client.dart';

import 'package:injectable/injectable.dart';
import '../../../core/data/data_repository.dart';
import '../models/post_model.dart';
import '../sources/posts_remote_data_source.dart';

@LazySingleton(as: ModelBindings<PostModel>)
class PostModelBinding implements ModelBindings<PostModel> {
  @override
  PostModel fromJson(Map<String, Object?> json) => PostModel.fromJson(json);

  @override
  int? getId(PostModel obj) => obj.id;

  @override
  int sortDesc(PostModel a, PostModel b) => a.title.compareTo(b.title);

  @override
  Map<String, Object?> toJson(PostModel obj) => obj.toJson();
}

@LazySingleton(as: DataRepository<PostModel>)
class PostsRepository extends DataRepository<PostModel> {
  final PostsClient client;
  PostsRepository({
    required super.networkInfo,
    required this.client,
  }) : super(
          localDataSource: LocalDataSource<PostModel>(),
          remoteDataSource: PostsRemoteDataSource(
            getHandler: client.get,
            listHandler: client.list,
            somethingElseHandler: client.somethingElse,
          ),
        );

  Future<void> somethingElse() async {
    /* localDataSource.get(1);
    await (remoteDataSource as PostsRemoteDataSource).somethingElse(); */
  }
}
