import 'package:app_frontend/constant/sharedpreferences/constants.dart';
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
      emit(ExperienceLoading());
      print("exp loading");
      var res = await _ExperienceRepo.getexp();
      res.fold((l) => emit(ExperienceError(l.message)), (r) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(place_id, r.place.id);
        emit(ExperienceSuccess(r));
        print('exp success');
      });
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }
}
