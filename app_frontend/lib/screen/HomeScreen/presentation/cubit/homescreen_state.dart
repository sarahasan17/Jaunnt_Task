part of 'homescreen_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeResponse response;
  HomeSuccess(this.response);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
