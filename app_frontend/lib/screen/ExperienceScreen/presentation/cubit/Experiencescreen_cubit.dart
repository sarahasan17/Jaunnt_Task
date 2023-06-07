import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/experiencescreen_response.dart';
import '../../domain/ExperienceScreen_repo.dart';
part 'Experiencescreen_state.dart';

class ExperienceCubit extends Cubit<ExperienceState> {
  final ExperienceScreenRepo _ExperienceRepo = ExperienceScreenRepo();
  ExperienceCubit() : super(ExperienceInitial()) {
    expnew();
  }
  void expnew() async {
    try {
      print("place detail cubit");
      emit(ExperienceLoading());
      var res = await _ExperienceRepo.getexp();
      res.fold((l) => emit(ExperienceError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(ExperienceSuccess(r));
      });
      print("loading place");
    } catch (e) {
      emit(ExperienceError(e.toString()));
      print("place error");
    }
  }
}
