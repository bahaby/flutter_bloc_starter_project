import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/models/alert_model.dart';
import '../../../app/repositories/app_repository.dart';
import '../../repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final AppRepository _appRepository;

  late StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required AppRepository appRepository,
  })  : _authRepository = authRepository,
        _appRepository = appRepository,
        super(const AuthState.initial()) {
    _authStatusSubscription = _authRepository.authStatus.listen((event) async {
      add(AuthEvent.statusChanged(event));
    });
    on<AuthEvent>((event, emit) async {
      _appRepository.setGlobalState(
          state: GlobalState.loadingInteractionDisabled);
      switch (event) {
        case _Started():
          emit(const AuthState.initial());
          break;
        case _Login(:final email, :final password):
          emit(const AuthState.loading());
          final result =
              await _authRepository.login(email: email, password: password);
          result.fold(
            (l) => emit(AuthState.failed(alert: l)),
            (r) => emit(const AuthState.initial()),
          );
          break;
      }
      _appRepository.setGlobalState(state: GlobalState.loaded);
    });
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
