part of 'AddExperience_Cubit.dart';

abstract class AddExperienceState {}

class AddExperienceInitial extends AddExperienceState {}

class AddExperienceLoading extends AddExperienceState {}

class AddExperienceSuccess extends AddExperienceState {
  AddExperienceSuccess();
}

class AddExperienceError extends AddExperienceState {
  final String msg;

  AddExperienceError(this.msg);
}
