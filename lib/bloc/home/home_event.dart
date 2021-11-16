part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeList extends HomeEvent {}

class GetHomeRefresh extends HomeEvent {}

class GetSearchByKeywordList extends HomeEvent {
  final String keyword;

  const GetSearchByKeywordList({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
