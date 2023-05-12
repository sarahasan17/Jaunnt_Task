import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/following_response.dart';
import '../../domain/following_repo.dart';
part 'followingstate.dart';

class FollowingCubit extends Cubit<FollowingState> {
  FollowingCubit() : super(FollowingInitial());
  final FollowingRepo _followingRepo = FollowingRepo();
  void following() async {
    emit(FollowingLoading());
    var res = await _followingRepo.following();
    res.fold((l) => emit(FollowingError(l.message)), (r) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(USER_ID_KEY, r.id);
      emit(FollowingSuccess(r));
    });
  }
}
