part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeEmptyState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<HeroesModel> heroes;

  const HomeSuccessState({required this.heroes});
  @override
  List<Object> get props => [heroes];
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState({this.errorMessage = "Unknown Error"});

  @override
  String toString() => 'Error : $errorMessage';
}
