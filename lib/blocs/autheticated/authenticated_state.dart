part of 'authenticated_bloc.dart';

class AuthenticatedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthenticatedState {}

class AuthLoaded extends AuthenticatedState {}

class AuthError extends AuthenticatedState {
  final String? message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
