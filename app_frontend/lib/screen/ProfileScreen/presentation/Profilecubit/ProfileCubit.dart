import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/sharedpref_keys.dart';
import '../../data/profileresponse.dart';
import '../../domain/profilescreenrepo.dart';
part 'ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final ProfileScreenRepo _ProfileRepo = ProfileScreenRepo();
  void getProfile() async {
    emit(ProfileLoading());

    var res = await _ProfileRepo.getProfile();
    res.fold((l) => emit(ProfileError(l.message)), (r) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(USER_ID_KEY, r.id);
      emit(ProfileSuccess(r));
    });
  }
}
