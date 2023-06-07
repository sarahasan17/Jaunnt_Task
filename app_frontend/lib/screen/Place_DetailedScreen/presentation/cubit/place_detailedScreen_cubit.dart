import 'package:app_frontend/screen/Explore/Domain/ExploreScreen_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/Place_Detailedscreen_response.dart';
import '../../domain/Place_DetailedScreen_repo.dart';
part 'place_detailedScreen_state.dart';

class Place_DetailedCubit extends Cubit<Place_DetailedState> {
  final Place_DetailedScreenRepo _placeScreenRepo = Place_DetailedScreenRepo();
  Place_DetailedCubit() : super(Place_DetailedInitial()) {
    placenew();
  }
  void placenew() async {
    try {
      print("place detail cubit");
      emit(Place_DetailedLoading());
      var res = await _placeScreenRepo.place();
      res.fold((l) => emit(Place_DetailedError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(Place_DetailedSuccess(r));
      });
      print("loading place");
    } catch (e) {
      emit(Place_DetailedError(e.toString()));
      print("place error");
    }
  }

  /**Place_DetailedCubit() : super(Place_DetailedInitial());
  final Place_DetailedScreenRepo _placeScreenRepo = Place_DetailedScreenRepo();
  void place() async {


    var res = await _placeScreenRepo.place();
    res.fold((l) => emit(Place_DetailedError(l.message)), (r) async {
      //SharedPreferences pref = await SharedPreferences.getInstance();
      //pref.setString(USER_ID_KEY, "");
      emit(Place_DetailedSuccess(r));
    });
  }**/
}
