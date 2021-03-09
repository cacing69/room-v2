import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthState(isAuthenticated: false));

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  void authenticated() => emit(state.copyWith(isAuthenticated: true));
  void unAuthenticated() => emit(state.copyWith(isAuthenticated: false));

  @override
  Map<String, dynamic> toJson(AuthState state) {
    return state.toMap();
  }
}
