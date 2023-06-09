/**part of 'ResetPassowrd_cubit.dart';

abstract class ResetPasswordState {
  const ResetPasswordState();
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final ResetPasswordResponse response;
  ResetPasswordSuccess(this.response);
}

class ResetPasswordError extends ResetPasswordState {
  final String msg;
  const ResetPasswordError(this.msg);
}**/
