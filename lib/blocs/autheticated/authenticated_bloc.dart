import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:foodapp/repository/baseAuth_repository.dart';
import 'package:foodapp/repository/user_repository.dart';

import '../../models/users.dart';

part 'authenticated_event.dart';
part 'authenticated_state.dart';

class AuthenticatedBloc extends Bloc<AuthenticatedEvent, AuthenticatedState> {
  final AuthReporitory _authReporitory;
  final UserRepository _userRepository;
  StreamSubscription<auth.User?>? _authUserSub;
  StreamSubscription<User?>? _userSub;
  AuthenticatedBloc({
    required AuthReporitory authReporitory,
    required UserRepository userRepository,
  })  : _authReporitory = authReporitory,
        _userRepository = userRepository,
        super(AuthLoading()) {
    on<AuthSignInEvent>(_onSignIn);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  void _onSignIn(
      AuthSignInEvent event, Emitter<AuthenticatedState> emit) async {
    var signIn = await _authReporitory.signIn(
        email: event.email, password: event.password);
    if (signIn == 'success') {
      emit(AuthLoaded());
    } else {
      emit(AuthError(signIn));
    }
  }

  void _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<AuthenticatedState> emit) async {
    await _authReporitory
        .signInWithGoogle()
        .catchError((error, stackTrace) => emit(AuthError(error.toString())))
        .whenComplete(() => emit(AuthLoaded()));
  }

  void _onSignOut(SignOutEvent event, Emitter<AuthenticatedState> emit) async {
    await _authReporitory
        .signOut()
        .catchError((error, stackTrace) => emit(AuthError(error.toString())))
        .whenComplete(() => emit(AuthLoading()));
  }

  @override
  Future<void> close() {
    _authUserSub?.cancel();
    _userSub?.cancel();
    return super.close();
  }
}
