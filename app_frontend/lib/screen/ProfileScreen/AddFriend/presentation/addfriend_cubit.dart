import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/sharedpref_keys.dart';
import '../domain/addfriend_repo.dart';
part 'addfriend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(AddFriendInitial());
  final AddFriendRepo _AddFriendRepo = AddFriendRepo();
  void addfriend(String id) async {
    emit(AddFriendLoading());

    var res = await _AddFriendRepo.addfriend(id);
    res.fold((l) => emit(AddFriendError(l.message)), (r) async {
      emit(AddFriendSuccess());
    });
  }
}
