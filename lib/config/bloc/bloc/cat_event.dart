part of 'cat_bloc.dart';

sealed class CatEvent extends Equatable {
  const CatEvent();

  @override
  List<Object> get props => [];
}

class LoadCatEvent extends CatEvent {
  @override
  List<Object> get props => [];
}

class SearchCatEvent extends CatEvent {
  final String query;

  const SearchCatEvent(this.query);

  @override
  List<Object> get props => [query];
}
