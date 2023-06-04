part of 'unfriend_cubit.dart';

abstract class UnFriendState {}

class UnFriendInitial extends UnFriendState {}

class UnFriendLoading extends UnFriendState {}

class UnFriendSuccess extends UnFriendState {
  UnFriendSuccess();
}

class UnFriendError extends UnFriendState {
  final String message;

  UnFriendError(this.message);
}
