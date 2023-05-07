import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Domain/AddExperience_repo.dart';
part 'AddExperience_State.dart';

class AddExperienceCubit extends Cubit<AddExperienceState> {
  AddExperienceCubit() : super(AddExperienceInitial());
  final AddExperienceRepo _addexpRepo = AddExperienceRepo();
  void addexp(String email) async {
    emit(AddExperienceLoading());
    var res = await _addexpRepo.addexp(email);
    res.fold((l) => emit(AddExperienceError(l.message)),
        (r) => emit(AddExperienceSuccess()));
  }
}
