import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/data/remote_data_source.dart';
import 'package:flutter_bloc_starter_project/futures/posts/models/post_model.dart';

// Example: Implement specific functionality if needed
class PostsRemoteDataSource extends RemoteDataSource<PostModel> {
  PostsRemoteDataSource({
    required this.somethingElseHandler,
    required super.getHandler,
    required super.listHandler,
  });

  final Future<Response> Function() somethingElseHandler;

  Future<void> somethingElse() async {
    // bindings.fromJson(await somethingElseHandler());
    await somethingElseHandler();
  }
}
