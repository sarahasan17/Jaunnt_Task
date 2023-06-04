import 'package:bloc/bloc.dart';
import '../../domain/bookmark_repo.dart';
part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());
  final BookmarkRepo _addexpRepo = BookmarkRepo();
  void bookmark() async {
    emit(BookmarkLoading());
    var res = await _addexpRepo.bookmark();
    res.fold((l) => emit(BookmarkError(l.message)),
            (r) => emit(BookmarkSuccess()));
  }
}
