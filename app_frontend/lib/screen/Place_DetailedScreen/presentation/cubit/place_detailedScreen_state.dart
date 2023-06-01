part of 'place_detailedScreen_cubit.dart';

abstract class Place_DetailedState {}

class Place_DetailedInitial extends Place_DetailedState {}

class Place_DetailedLoading extends Place_DetailedState {}

class Place_DetailedSuccess extends Place_DetailedState {
  final Place_DetailedResponse response;
  Place_DetailedSuccess(this.response);
}

class Place_DetailedError extends Place_DetailedState {
  final String message;
  Place_DetailedError(this.message);
}
