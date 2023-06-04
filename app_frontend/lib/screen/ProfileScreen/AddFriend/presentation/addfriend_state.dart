part of 'addfriend_cubit.dart';

abstract class AddFriendState {}

class AddFriendInitial extends AddFriendState {}

class AddFriendLoading extends AddFriendState {}

class AddFriendSuccess extends AddFriendState {
  AddFriendSuccess();
}

class AddFriendError extends AddFriendState {
  final String message;

  AddFriendError(this.message);
}
