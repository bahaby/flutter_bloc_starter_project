import 'package:flutter_bloc_starter_project/core/data/local_data_source.dart';
import 'package:flutter_bloc_starter_project/futures/app/models/alert_model.dart';
import 'package:flutter_bloc_starter_project/futures/posts/clients/posts_client.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/remote_data_source.dart';
import '../../../core/data/repository.dart';
import '../../../core/exception/exception_handler.dart';
import '../../app/models/paginated_model.dart';
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
  final PostsClient client;
  PostsRepository({
    required super.networkInfo,
    required this.client,
  }) : super(
          localDataSource: LocalDataSource<PostModel>(),
          remoteDataSource: RemoteDataSource(
            getHandler: client.get,
            listHandler: client.list,
          ),
        );

  // Example: Implement specific functionality if needed
  /* Future<Either<AlertModel, void>> specificMethod(PostModel post) async {
    return exceptionHandler(() async {
      final data = await client.specificMethod(post);
      await localDataSource.save(post);
      return right(null);
    });
  } */
}
