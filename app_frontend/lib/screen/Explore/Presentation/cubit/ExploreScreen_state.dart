part of 'ExploreScreen_cubit.dart';

abstract class ExploreState {}
class ExploreInitial extends ExploreState {}
class ExploreLoading extends ExploreState {}
class ExploreSuccess extends ExploreState {
  final ExploreResponse response;
  ExploreSuccess(this.response);
}
class ExploreError extends ExploreState {
  final String message;
  ExploreError(this.message);
}
