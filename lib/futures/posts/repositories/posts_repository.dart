import 'package:flutter_bloc_starter_project/core/data/local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../core/data/remote_data_source.dart';
import '../../../core/data/repository.dart';
import '../models/post_model.dart';

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

@LazySingleton(as: Repository<PostModel>)
class PostsRepository extends Repository<PostModel> {
  PostsRepository({
    required InternetConnection super.networkInfo,
  }) : super(
          localDataSource: LocalDataSource<PostModel>(),
          remoteDataSource: RemoteDataSource<PostModel>(
            basePath: 'posts',
          ),
        );
}
