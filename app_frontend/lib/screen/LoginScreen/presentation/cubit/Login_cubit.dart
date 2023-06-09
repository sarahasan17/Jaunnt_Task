import 'package:app_frontend/screen/LoginScreen/data/Login_Response.dart';
import 'package:bloc/bloc.dart';
import '../../domain/Login_Repo.dart';
part 'Login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final LoginRepo _loginRepo = LoginRepo();
  void login(String email, String password) async {
    emit(LoginLoading());
    var res = await _loginRepo.login(email, password);
    res.fold((l) => emit(LoginError(l.message)), (r) => emit(LoginSuccess(r)));
  }
}
