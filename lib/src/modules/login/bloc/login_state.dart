part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final UsernameForm username;
  final PasswordForm password;
  final bool success;

  LoginState({
    this.status = FormzStatus.pure,
    this.username = const UsernameForm.pure(),
    this.password = const PasswordForm.pure(),
    this.success = false,
  });

  @override
  List<Object> get props => [status, username, password, success];

  LoginState copyWith({
    FormzStatus status,
    UsernameForm username,
    PasswordForm password,
    bool success,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      success: success ?? this.success,
    );
  }

  @override
  bool get stringify => true;
}
