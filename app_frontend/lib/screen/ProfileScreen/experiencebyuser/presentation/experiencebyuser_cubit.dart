import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/sharedpref_keys.dart';
import '../data/experiencebyuser_response.dart';
import '../domain/experiencebyuser_repo.dart';
part 'experiencebyuser_state.dart';

class ExperienceByUserCubit extends Cubit<ExperienceByUserState> {
  ExperienceByUserCubit() : super(ExperienceByUserInitial());
  final ExperienceByUserRepo _ExperienceByUserRepo = ExperienceByUserRepo();
  void getProfile() async {
    emit(ExperienceByUserLoading());

    var res = await _ExperienceByUserRepo.ExperienceByUser();
    res.fold((l) => emit(ExperienceByUserError(l.message)), (r) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(USER_ID_KEY, "");
      emit(ExperienceByUserSuccess(r));
    });
  }
}
