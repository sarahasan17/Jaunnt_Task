import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/experiencescreen_response.dart';
import '../../domain/ExperienceScreen_repo.dart';
part 'Experiencescreen_state.dart';

class HomeCubit extends Cubit<ExperienceState> {
  HomeCubit() : super(ExperienceInitial());
  final ExperienceScreenRepo _experienceScreenRepo = ExperienceScreenRepo();
  void getProfile() async {
    emit(ExperienceLoading());

    var res = await _experienceScreenRepo.getProfile();
    res.fold((l) => emit(ExperienceError(l.message)), (r) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(USER_ID_KEY, "");
      emit(ExperienceSuccess(r));
    });
  }
}
