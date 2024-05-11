import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/alert_model.dart';
import '../../../repositories/base_repository.dart';

part 'generic_fetch_event.dart';
part 'generic_fetch_state.dart';
part 'generic_fetch_bloc.freezed.dart';

class GenericFetchBloc<T>
    extends Bloc<GenericFetchEvent<T>, GenericFetchState<T>> {
  final BaseRepository<T> _repository;
  GenericFetchBloc({
    required BaseRepository<T> repository,
  })  : _repository = repository,
        super(const GenericFetchState.initial()) {
    on<GenericFetchEvent<T>>((event, emit) async {
      switch (event) {
        case _Refresh():
          emit(const GenericFetchState.loading());
          final result = await _repository.getSingle(event.id);
          result.fold(
            (left) => emit(GenericFetchState.failed(left)),
            (right) => emit(GenericFetchState.loaded(right)),
          );
          break;
      }
    });
  }
}
