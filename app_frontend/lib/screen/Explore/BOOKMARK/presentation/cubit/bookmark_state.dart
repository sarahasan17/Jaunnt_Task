part of 'bookmark_cubit.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {
  BookmarkSuccess();
}

class BookmarkError extends BookmarkState {
  final String msg;

  BookmarkError(this.msg);
}
