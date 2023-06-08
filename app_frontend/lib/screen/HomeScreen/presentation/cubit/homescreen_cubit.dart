import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/homescreen_response.dart';
import '../../domain/HomeScreen_repo.dart';
part 'homescreen_state.dart';

class ExploreCubit extends Cubit<HomeState> {
  final HomeScreenRepo _HomeScreenRepo = HomeScreenRepo();
  ExploreCubit() : super(HomeInitial()) {
    home();
  }
  void home() async {
    try {
      emit(HomeLoading());
      var res = await _HomeScreenRepo.home();
      res.fold((l) => emit(HomeError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(HomeSuccess(r));
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
