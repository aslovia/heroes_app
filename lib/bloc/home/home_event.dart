part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeList extends HomeEvent {}

class GetSearchByKeywordList extends HomeEvent {
  final String keyword;

  const GetSearchByKeywordList({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class GetSearchByAliveList extends HomeEvent {
  final String startYear, endYear;

  const GetSearchByAliveList({required this.startYear, required this.endYear});

  @override
  List<Object> get props => [startYear, endYear];
}

class GetSearchByBirthList extends HomeEvent {
  final String startYear, endYear;

  const GetSearchByBirthList({required this.startYear, required this.endYear});

  @override
  List<Object> get props => [startYear, endYear];
}

class GetSearchByDeathList extends HomeEvent {
  final String startYear, endYear;

  const GetSearchByDeathList({required this.startYear, required this.endYear});

  @override
  List<Object> get props => [startYear, endYear];
}
