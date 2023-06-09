/**import 'package:bloc/bloc.dart';
import '../../../domain/ForgotPassword_repo.dart';
part 'ResetPassword_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  final ResetPasswordRepo _ResetPasswordRepo = ResetPasswordRepo();
  void resetpassword(String phoneNumber) async {
    emit(ResetPasswordLoading());
    var res = await _ResetPasswordRepo.resetpassword(phoneNumber);
    res.fold((l) => emit(ResetPasswordError(l.message)),
            (r) => emit(ResetPasswordSuccess(r)));
  }
}**/
