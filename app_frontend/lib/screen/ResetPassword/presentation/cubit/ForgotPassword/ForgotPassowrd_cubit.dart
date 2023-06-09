import 'package:bloc/bloc.dart';
import '../../../domain/ForgotPassword_repo.dart';
part 'ForgotPassword_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  final ForgotPasswordRepo _ForgotPasswordRepo = ForgotPasswordRepo();
  void login(String phoneNumber) async {
    emit(ForgotPasswordLoading());
    var res = await _ForgotPasswordRepo.forgotpassword(phoneNumber);
    res.fold((l) => emit(ForgotPasswordError(l.message)),
        (r) => emit(ForgotPasswordSuccess(r)));
  }
}
