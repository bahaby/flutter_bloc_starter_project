import '../../../app/presentation/blocs/generic_fetch_bloc/generic_fetch_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/repositories/base_repository.dart';
import '../../models/post_model.dart';

@injectable
class PostDetailsBloc extends GenericFetchBloc<PostModel> {
  PostDetailsBloc(DataRepository<PostModel> repository)
      : super(repository: repository);
}
