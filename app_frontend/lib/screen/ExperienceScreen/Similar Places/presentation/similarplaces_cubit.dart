import 'package:bloc/bloc.dart';
import '../data/similarplaces_response.dart';
import '../domain/similarplaces_repo.dart';
part 'similarplaces_state.dart';

class SimilarPlacesCubit extends Cubit<SimilarPlaceState> {
  final SimilarPlacesRepo _SimilarPlacesRepo = SimilarPlacesRepo();

  SimilarPlacesCubit() : super(SimilarPlaceInitial()) {
    similarplace();
  }

  void similarplace() async {
    try {
      print("place detail cubit");
      emit(SimilarPlacesLoading());
      var res = await _SimilarPlacesRepo.similarplaces();
      res.fold((l) => emit(SimilarPlacesError(l.message)), (r) async {
        //SharedPreferences pref = await SharedPreferences.getInstance();
        //pref.setString(USER_ID_KEY, "");
        emit(SimilarPlaceSuccess(r));
      });
      print("loading place");
    } catch (e) {
      emit(SimilarPlacesError(e.toString()));
      print("place error");
    }
  }
}
