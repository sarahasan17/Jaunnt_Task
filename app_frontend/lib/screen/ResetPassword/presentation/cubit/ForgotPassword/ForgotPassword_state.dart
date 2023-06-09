part of 'ForgotPassowrd_cubit.dart';

abstract class ForgotPasswordState {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordResponse response;
  ForgotPasswordSuccess(this.response);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String msg;
  const ForgotPasswordError(this.msg);
}
