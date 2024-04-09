import 'package:bloc/bloc.dart';
import 'package:cat_api_prueba_pragma_jeant/domain/models/cat_model.dart';
import 'package:cat_api_prueba_pragma_jeant/infraestructure/resource/cat_api_repositoy.dart';
import 'package:equatable/equatable.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatApiRepository _catRepository;

  CatBloc(this._catRepository) : super(CatLoadingState()) {
    on<LoadCatEvent>((event, emit) async {
      emit(CatLoadingState());
      try {
        final cats = await _catRepository.fetchCatBreeds();
        emit(CatLoadedState(cats));
      } catch (e) {
        final errorMessage =
            e != null ? e.toString() : "Unknown error occurred";
        emit(CatErrorState(errorMessage));
      }
    });

    on<SearchCatEvent>((event, emit) async {
      emit(CatLoadingState());
      try {
        final cats = await _catRepository.searchCatBreeds(event.query);
        emit(CatLoadedState(cats));
      } catch (e) {
        emit(CatErrorState(e.toString()));
      }
    });
  }
}
