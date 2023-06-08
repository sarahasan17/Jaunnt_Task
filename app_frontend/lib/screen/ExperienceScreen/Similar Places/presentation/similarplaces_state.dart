part of 'similarplaces_cubit.dart';

abstract class SimilarPlaceState {}

class SimilarPlaceInitial extends SimilarPlaceState {}

class SimilarPlacesLoading extends SimilarPlaceState {}

class SimilarPlaceSuccess extends SimilarPlaceState {
  final SimilarPlaceResponse response;
  SimilarPlaceSuccess(this.response);
}

class SimilarPlacesError extends SimilarPlaceState {
  final String message;
  SimilarPlacesError(this.message);
}
