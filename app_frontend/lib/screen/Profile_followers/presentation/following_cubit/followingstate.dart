part of 'followingcubit.dart';

@immutable
abstract class FollowingState {
  const FollowingState();
}

class FollowingInitial extends FollowingState {}

class FollowingLoading extends FollowingState {}

class FollowingSuccess extends FollowingState {
  final FollowingResponse response;
  FollowingSuccess(this.response);
}

class FollowingError extends FollowingState {
  final String msg;
  const FollowingError(this.msg);
}
