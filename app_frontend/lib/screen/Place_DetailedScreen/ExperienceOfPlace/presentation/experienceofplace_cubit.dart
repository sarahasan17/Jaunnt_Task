import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../data/experienceofplace_response.dart';
import '../domain/experienceofplace_repo.dart';
part 'experienceofplace_state.dart';

class ExperienceOfPlaceCubit extends Cubit<ExperienceOfPlaceState> {
  ExperienceOfPlaceCubit() : super(ExperienceOfPlaceInitial()) {
    expnew();
  }
  void expnew() async {
    try {
      print("place detail cubit");
      emit(ExperienceOfPlaceLoading());
      var res = await _ExperienceOfPlaceRepo.resp();
      res.fold((l) => emit(ExperienceOfPlaceError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(ExperienceOfPlaceSuccess(r));
      });
    } catch (e) {
      emit(ExperienceOfPlaceError(e.toString()));
    }
  }

  final ExperienceOfPlaceRepo _ExperienceOfPlaceRepo = ExperienceOfPlaceRepo();
}
