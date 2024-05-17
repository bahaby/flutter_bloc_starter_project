import '../../../app/presentation/blocs/generic_fetch_bloc/generic_fetch_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/repository.dart';
import '../../models/post_model.dart';

@injectable
class PostDetailsBloc extends GenericFetchBloc<PostModel> {
  PostDetailsBloc(Repository<PostModel> repository)
      : super(repository: repository);
}
