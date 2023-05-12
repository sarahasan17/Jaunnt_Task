part of 'followercubit.dart';

@immutable
abstract class FollowerState {
  const FollowerState();
}

class FollowerInitial extends FollowerState {}

class FollowerLoading extends FollowerState {}

class FollowerSuccess extends FollowerState {
  final FollowerResponse response;
  const FollowerSuccess(this.response);
}

class FollowerError extends FollowerState {
  final String msg;
  const FollowerError(this.msg);
}
