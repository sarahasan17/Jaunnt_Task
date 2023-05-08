import 'package:bloc/bloc.dart';
import '../../../Domain/EditExperience_repo.dart';
part 'EditExperience_state.dart';

class EditExperienceCubit extends Cubit<EditExperienceState> {
  EditExperienceCubit() : super(EditExperienceInitial());
  final EditExperienceRepo _editExperienceRepo = EditExperienceRepo();
  void editexp(String files) async {
    emit(EditExperienceLoading());
    var res = await _editExperienceRepo.editexperience(files);
    res.fold((l) => emit(EditExperienceError(l.message)),
        (r) => emit(EditExperienceSuccess()));
  }
}
