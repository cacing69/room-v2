import 'dart:async';

import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/core/form/password_form.dart';
import 'package:room_v2/src/core/form/username_form.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BlocWithState<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield* runBlocProcess(() async* {
      if (event is LoginUsernameChanged) {
        yield _mapUsernameChangedToState(event, state);
      } else if (event is LoginPasswordChanged) {
        yield _mapPasswordChangedToState(event, state);
      } else if (event is LoginSubmitted) {
        yield* _mapLoginSubmittedToState(event, state);
      } else if (event is LoginReInitialize) {
        yield _mapLoginReInitializeToState(event, state);
      }
    });
  }

  LoginState _mapLoginReInitializeToState(
      LoginReInitialize event, LoginState state) {
    return state.copyWith(
        username: null, password: null, status: FormzStatus.invalid);
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = UsernameForm.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = PasswordForm.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress, success: false);

      try {
        // do request on API
        await Future.delayed(Duration(seconds: 2));
        yield state.copyWith(
            status: FormzStatus.submissionSuccess, success: true);
      } on Exception catch (_) {
        yield state.copyWith(
            status: FormzStatus.submissionFailure, success: false);
      }
    }
  }
}
