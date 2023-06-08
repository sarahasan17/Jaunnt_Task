import 'package:app_frontend/screen/Explore/Domain/ExploreScreen_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../Data/ExploreScreen_response.dart';
part 'ExploreScreen_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreScreenRepo _ExploreScreenRepo = ExploreScreenRepo();
  ExploreCubit() : super(ExploreInitial()) {
    explore();
  }
  void explore() async {
    try {
      emit(ExploreLoading());
      var res = await _ExploreScreenRepo.explore();
      res.fold((l) => emit(ExploreError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(ExploreSuccess(r));
      });
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }
}
