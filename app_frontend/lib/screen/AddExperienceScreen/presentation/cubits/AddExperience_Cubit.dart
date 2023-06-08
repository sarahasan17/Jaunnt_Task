import 'package:app_frontend/screen/AddExperienceScreen/Data/AddExperience_repsonse,dart.dart';
import 'package:app_frontend/screen/AddExperienceScreen/Data/AddExperience_request.dart';
import 'package:bloc/bloc.dart';
import '../../Domain/AddExperience_repo.dart';
part 'AddExperience_State.dart';

class AddExperienceCubit extends Cubit<AddExperienceState> {
  AddExperienceCubit() : super(AddExperienceInitial());
  final AddExperienceRepo _addexpRepo = AddExperienceRepo();
  addexp(AddExperienceRequest request) async {
    emit(AddExperienceLoading());
    var res = await _addexpRepo.addexp(request);
    res.fold((l) => emit(AddExperienceError(l.message)),
        (r) => emit(AddExperienceSuccess(response: r)));
  }
}
