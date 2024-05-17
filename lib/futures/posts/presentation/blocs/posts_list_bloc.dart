import 'package:injectable/injectable.dart';

import '../../../app/presentation/blocs/generic_list_bloc/generic_list_bloc.dart';
import '../../../../core/data/repository.dart';
import '../../models/post_model.dart';

@injectable
class PostsListBloc extends GenericListBloc<PostModel> {
  PostsListBloc(Repository<PostModel> repository)
      : super(repository: repository);
}
