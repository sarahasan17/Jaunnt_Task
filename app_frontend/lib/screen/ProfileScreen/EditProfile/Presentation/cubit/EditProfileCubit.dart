import 'dart:io';
import 'package:bloc/bloc.dart';
import '../../Domain/EditProfileRepo.dart';

part 'EditProfileState.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  final EditProfileRepo _editProfileRepo = EditProfileRepo();
  void editexp(File files, String bio) async {
    emit(EditProfileLoading());
    var res = await _editProfileRepo.editprofile(bio, files);
    res.fold((l) => emit(EditProfileError(l.message)),
        (r) => emit(EditProfileSuccess()));
  }
}
