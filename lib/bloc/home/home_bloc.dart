import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heroes_app/model/heroes_model.dart';
import 'package:heroes_app/network/api_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository apiRepository = ApiRepository();

  HomeBloc() : super(HomeLoadingState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      yield HomeLoadingState();
      List<HeroesModel> heroesModel = <HeroesModel>[];

      if (event is GetHomeList) {
        heroesModel = await apiRepository.getHeroesList();
      } else if (event is GetSearchByKeywordList) {
        heroesModel =
            await apiRepository.getSearchHeroesByKeyword(event.keyword);
      } else if (event is GetSearchByAliveList) {
        heroesModel = await apiRepository.getSearchHeroesByAlive(
            event.startYear, event.endYear);
      } else if (event is GetSearchByBirthList) {
        heroesModel = await apiRepository.getSearchHeroesByBirth(
            event.startYear, event.endYear);
      } else if (event is GetSearchByDeathList) {
        heroesModel = await apiRepository.getSearchHeroesByDeath(
            event.startYear, event.endYear);
      }

      if (heroesModel.isNotEmpty) {
        yield HomeSuccessState(heroes: heroesModel);
      } else {
        yield HomeEmptyState();
      }
    } catch (e) {
      yield HomeErrorState(errorMessage: e.toString());
    }
  }
}
