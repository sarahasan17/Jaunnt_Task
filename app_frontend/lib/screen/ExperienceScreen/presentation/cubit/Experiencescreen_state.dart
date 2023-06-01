part of 'Experiencescreen_cubit.dart';

abstract class ExperienceState {}

class ExperienceInitial extends ExperienceState {}

class ExperienceLoading extends ExperienceState {}

class ExperienceSuccess extends ExperienceState {
  final ExperienceResponse response;
  ExperienceSuccess(this.response);
}

class ExperienceError extends ExperienceState {
  final String message;
  ExperienceError(this.message);
}
