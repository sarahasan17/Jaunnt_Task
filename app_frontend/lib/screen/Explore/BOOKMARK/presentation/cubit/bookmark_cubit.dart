import 'package:bloc/bloc.dart';
import '../../domain/bookmark_repo.dart';
part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());
  final BookmarkRepo _BookmarkRepo = BookmarkRepo();
  void bookmark() async {
    emit(BookmarkLoading());
    var res = await _BookmarkRepo.bookmark();
    res.fold(
        (l) => emit(BookmarkError(l.message)), (r) => emit(BookmarkSuccess()));
  }
}
