part of 'cat_bloc.dart';

sealed class CatState extends Equatable {
  const CatState();

  @override
  List<Object> get props => [];
}

final class CatInitial extends CatState {}

final class CatLoadingState extends CatState {}

final class CatLoadedState extends CatState {
  final List<CatModel> cats;
  const CatLoadedState(this.cats);
  @override
  List<Object> get props => [];
}

final class CatErrorState extends CatState {
  final String error;
  CatErrorState(this.error);
  @override
  List<Object> get props => [];
}
