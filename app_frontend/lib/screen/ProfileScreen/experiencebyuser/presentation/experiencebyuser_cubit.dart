import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/sharedpref_keys.dart';
import '../data/experiencebyuser_response.dart';
import '../domain/experiencebyuser_repo.dart';
part 'experiencebyuser_state.dart';

class ExperienceByUserCubit extends Cubit<ExperienceByUserState> {
  final ExperienceByUserRepo _ExperienceByUserRepo = ExperienceByUserRepo();

  ExperienceByUserCubit() : super(ExperienceByUserInitial()) {
    ExperienceByUser();
  }

  void ExperienceByUser() async {
    try {
      emit(ExperienceByUserLoading());
      var res = await _ExperienceByUserRepo.ExperienceByUser();
      res.fold((l) => emit(ExperienceByUserError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(ExperienceByUserSuccess(r));
      });
    } catch (e) {
      emit(ExperienceByUserError(e.toString()));
    }
  }
}
