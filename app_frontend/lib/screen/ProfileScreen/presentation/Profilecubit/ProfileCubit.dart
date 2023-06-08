import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/sharedpref_keys.dart';
import '../../data/profileresponse.dart';
import '../../domain/profilescreenrepo.dart';
part 'ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileScreenRepo _ProfileScreenRepo = ProfileScreenRepo();
  ProfileCubit() : super(ProfileInitial()) {
    getprofile();
  }
  void getprofile() async {
    try {
      print("loading profile");
      emit(ProfileLoading());
      var res = await _ProfileScreenRepo.getProfile();
      res.fold((l) => emit(ProfileError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(ProfileSuccess(r));
        print("success");
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  bool isLoggedinUserProfile(String id) {
    if (USER_ID_KEY == id) {
      return true;
    } else {
      return false;
    }
  }
}
