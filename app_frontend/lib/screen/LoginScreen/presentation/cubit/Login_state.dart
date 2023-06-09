part of 'Login_cubit.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;
  LoginSuccess(this.response);
}

class LoginError extends LoginState {
  final String msg;
  const LoginError(this.msg);
}
