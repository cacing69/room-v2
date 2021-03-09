part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isAuthenticated;

  AuthState({
    this.isAuthenticated,
  });

  @override
  List<Object> get props => [isAuthenticated];

  Map<String, dynamic> toMap() {
    return {
      'isAuthenticated': isAuthenticated,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AuthState(
      isAuthenticated: map['isAuthenticated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));

  AuthState copyWith({
    bool isAuthenticated,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  bool get stringify => true;
}
