part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLogin extends AuthState {
  final String token;
  final String email;

  AuthLogin(this.token, this.email);

  @override
  List<Object> get props => [token, email];
}

class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure(this.message);

  @override
  List<Object> get props => [message];
}
