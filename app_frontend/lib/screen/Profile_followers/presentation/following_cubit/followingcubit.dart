import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/following_response.dart';
import '../../domain/following_repo.dart';
part 'followingstate.dart';

class FollowingCubit extends Cubit<FollowingState> {
  final FollowingRepo _FollowingRepo = FollowingRepo();

  FollowingCubit() : super(FollowingInitial()) {
    following();
  }

  void following() async {
    try {
      print("friends detail cubit");
      emit(FollowingLoading());
      var res = await _FollowingRepo.following();
      res.fold((l) => emit(FollowingError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(FollowingSuccess(r));
      });
      print("loading friends");
    } catch (e) {
      emit(FollowingError(e.toString()));
      print("friends error");
    }
  }
}
