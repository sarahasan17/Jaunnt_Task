import 'package:bloc/bloc.dart';
import '../domain/isfriend_repo.dart';
part 'isfriend_state.dart';

class IsFriendCubit extends Cubit<IsFriendState> {
  IsFriendCubit() : super(IsFriendInitial());
  final IsFriendRepo _IsFriendRepo = IsFriendRepo();
  void isfriend(String id) async {
    emit(IsFriendLoading());

    var res = await _IsFriendRepo.isfriend(id);
    res.fold(
        (l) => emit(IsFriendError(l.message)), (r) => emit(IsFriendSuccess(r)));
  }
}
