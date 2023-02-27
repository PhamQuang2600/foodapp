part of 'authenticated_bloc.dart';

abstract class AuthenticatedEvent extends Equatable {
  const AuthenticatedEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignInEvent extends AuthenticatedEvent {
  final String email;
  final String password;
  const AuthSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUpEvent extends AuthenticatedEvent {
  final User user;
  const AuthSignUpEvent(this.user);

  @override
  List<Object> get props => [user];
}


class GoogleSignInEvent extends AuthenticatedEvent {}

class SignOutEvent extends AuthenticatedEvent {}
