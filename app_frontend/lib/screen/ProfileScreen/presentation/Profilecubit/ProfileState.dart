part of 'ProfileCubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileResponse response;

  ProfileSuccess(this.response);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
