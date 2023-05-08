part of 'EditExperience_cubit.dart';

abstract class EditExperienceState {}

class EditExperienceInitial extends EditExperienceState {}

class EditExperienceLoading extends EditExperienceState {}

class EditExperienceSuccess extends EditExperienceState {
  EditExperienceSuccess();
}

class EditExperienceError extends EditExperienceState {
  final String msg;

  EditExperienceError(this.msg);
}
