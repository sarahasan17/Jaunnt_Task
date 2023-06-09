import 'package:bloc/bloc.dart';
import '../../data/Signup_Response.dart';
import '../../domain/Signup_repo.dart';
part 'Signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final SignUpRepo _SignUpRepo = SignUpRepo();
  void signup(String fullName, String email, String phoneNumber,
      String password, String confirm) async {
    emit(SignUpLoading());
    var res = await _SignUpRepo.signup(
        fullName, email, phoneNumber, password, confirm);
    res.fold(
        (l) => emit(SignUpError(l.message)), (r) => emit(SignUpSuccess(r)));
  }
}
