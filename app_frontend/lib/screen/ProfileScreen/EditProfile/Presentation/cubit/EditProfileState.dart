part of 'EditProfileCubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  EditProfileSuccess();
}

class EditProfileError extends EditProfileState {
  final String msg;

  EditProfileError(this.msg);
}
