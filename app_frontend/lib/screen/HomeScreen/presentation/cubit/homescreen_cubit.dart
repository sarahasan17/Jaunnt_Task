import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/homescreen_response.dart';
import '../../domain/HomeScreen_repo.dart';
part 'homescreen_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final HomeScreenRepo _exploreScreenRepo = HomeScreenRepo();
  void home(Float lat, Float long, int queryPage, int queryLimit) async {
    emit(HomeLoading());

    var res = await _exploreScreenRepo.home(lat, long, queryPage, queryLimit);
    res.fold((l) => emit(HomeError(l.message)), (r) async {
      //SharedPreferences pref = await SharedPreferences.getInstance();
      //pref.setString(USER_ID_KEY, "");
      emit(HomeSuccess(r));
    });
  }
}
