import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../data/experienceofplace_response.dart';
import '../domain/experienceofplace_repo.dart';
part 'experienceofplace_state.dart';

class ExperienceOfPlaceCubit extends Cubit<ExperienceOfPlaceState> {
  ExperienceOfPlaceCubit() : super(ExperienceOfPlaceInitial());
  final ExperienceOfPlaceRepo _ExperienceOfPlaceRepo = ExperienceOfPlaceRepo();
  void ExperienceOfPlace() async {
    emit(ExperienceOfPlaceLoading());
    var res = await _ExperienceOfPlaceRepo.follower();
    res.fold((l) => emit(ExperienceOfPlaceError(l.message)), (r) async {
      emit(ExperienceOfPlaceSuccess(r));
    });
  }
}
