part of 'experiencebyuser_cubit.dart';

abstract class ExperienceByUserState {}

class ExperienceByUserInitial extends ExperienceByUserState {}

class ExperienceByUserLoading extends ExperienceByUserState {}

class ExperienceByUserSuccess extends ExperienceByUserState {
  final ExperienceByUserResponse response;
  ExperienceByUserSuccess(this.response);
}

class ExperienceByUserError extends ExperienceByUserState {
  final String message;
  ExperienceByUserError(this.message);
}
