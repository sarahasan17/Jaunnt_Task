import 'package:bloc/bloc.dart';
import '../../domain/bookmark_repo.dart';
part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final BookmarkRepo _BookmarkRepo = BookmarkRepo();
  BookmarkCubit() : super(BookmarkInitial()) {
    bookmark();
  }
  void bookmark() async {
    try {
      emit(BookmarkLoading());
      var res = await _BookmarkRepo.bookmark();
      res.fold((l) => emit(BookmarkError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(BookmarkSuccess());
      });
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }
}
