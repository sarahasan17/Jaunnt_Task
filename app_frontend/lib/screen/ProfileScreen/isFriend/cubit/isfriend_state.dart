part of 'isfriend_cubit.dart';

abstract class IsFriendState {}

class IsFriendInitial extends IsFriendState {}

class IsFriendLoading extends IsFriendState {}

class IsFriendSuccess extends IsFriendState {
  IsFriendSuccess();
}

class IsFriendError extends IsFriendState {
  final String message;

  IsFriendError(this.message);
}
