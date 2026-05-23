import '../../../../futures/posts/models/post_model.dart';
import 'package:hive/hive.dart';

class PostAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 0;

  @override
  PostModel read(BinaryReader reader) {
    return PostModel(
      id: reader.read(),
      body: reader.read(),
      title: reader.read(),
      userId: reader.read(),
      tags: reader.read(),
      reactions: ReactionsModel(likes: reader.read(), dislikes: reader.read()),
      views: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer.write(obj.id);
    writer.write(obj.body);
    writer.write(obj.title);
    writer.write(obj.userId);
    writer.write(obj.tags);
    writer.write(obj.reactions.likes);
    writer.write(obj.reactions.dislikes);
    writer.write(obj.views);
  }
}
