part of 'Signup_cubit.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final SignupResponse response;
  SignUpSuccess(this.response);
}

class SignUpError extends SignUpState {
  final String msg;
  const SignUpError(this.msg);
}
