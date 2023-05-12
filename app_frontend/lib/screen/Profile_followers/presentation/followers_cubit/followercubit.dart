import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../data/follower_response.dart';
import '../../domain/follower_repo.dart';
part 'followerstate.dart';

class FollowerCubit extends Cubit<FollowerState> {
  FollowerCubit() : super(FollowerInitial());
  final FollowerRepo _followerRepo = FollowerRepo();
  void follower() async {
    emit(FollowerLoading());
    var res = await _followerRepo.follower();
    res.fold((l) => emit(FollowerError(l.message)), (r) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(USER_ID_KEY, r.id);
      emit(FollowerSuccess(r));
    });
  }
}
