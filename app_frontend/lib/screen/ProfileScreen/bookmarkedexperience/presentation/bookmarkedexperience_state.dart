part of 'bookmarkedexperience_cubit.dart';

abstract class BookmarkedExperienceState {}

class BookmarkedExperienceInitial extends BookmarkedExperienceState {}

class BookmarkedExperienceLoading extends BookmarkedExperienceState {}

class BookmarkedExperienceSuccess extends BookmarkedExperienceState {
  final BookmarkedPlaceResponse response;
  BookmarkedExperienceSuccess(this.response);
}

class BookmarkedExperienceError extends BookmarkedExperienceState {
  final String message;
  BookmarkedExperienceError(this.message);
}
