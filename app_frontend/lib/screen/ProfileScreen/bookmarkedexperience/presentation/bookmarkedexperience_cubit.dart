import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../data/bookmarkedexperience_response.dart';
import '../domain/bookmarkedexperience_repo.dart';
part 'bookmarkedexperience_state.dart';
class BookmarkedExperienceCubit extends Cubit<BookmarkedExperienceState> {
  final BookmarkedExperienceRepo _BookmarkedExperienceRepo = BookmarkedExperienceRepo();

  BookmarkedExperienceCubit() : super(BookmarkedExperienceInitial()) {
    BookmarkedExperience();
  }

  void BookmarkedExperience() async {
    try {
      print("friends detail cubit");
      emit(BookmarkedExperienceLoading());
      var res = await _BookmarkedExperienceRepo.BookmarkedExperience();
      res.fold((l) => emit(BookmarkedExperienceError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(BookmarkedExperienceSuccess(r));
      });
    } catch (e) {
      emit(BookmarkedExperienceError(e.toString()));
    }
  }
}