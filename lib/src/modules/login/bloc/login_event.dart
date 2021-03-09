part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged({
    this.username,
  });

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({
    this.password,
  });

  @override
  List<Object> get props => [password];
}

class LoginReInitialize extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
