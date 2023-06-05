part of 'experienceofplace_cubit.dart';

abstract class ExperienceOfPlaceState {
  const ExperienceOfPlaceState();
}

class ExperienceOfPlaceInitial extends ExperienceOfPlaceState {}

class ExperienceOfPlaceLoading extends ExperienceOfPlaceState {}

class ExperienceOfPlaceSuccess extends ExperienceOfPlaceState {
  final ExperienceOfPlaceResponse response;
  const ExperienceOfPlaceSuccess(this.response);
}

class ExperienceOfPlaceError extends ExperienceOfPlaceState {
  final String msg;
  const ExperienceOfPlaceError(this.msg);
}
