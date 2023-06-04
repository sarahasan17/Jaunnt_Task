import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/sharedpref_keys.dart';
import '../domain/unfriend_repo.dart';
part 'unfriend_state.dart';

class UnFriendCubit extends Cubit<UnFriendState> {
  UnFriendCubit() : super(UnFriendInitial());
  final UnFriendRepo _UnFriendRepo = UnFriendRepo();
  void unfriend(String id) async {
    emit(UnFriendLoading());

    var res = await _UnFriendRepo.unfriend(id);
    res.fold((l) => emit(UnFriendError(l.message)), (r) async {
      emit(UnFriendSuccess());
    });
  }
}
