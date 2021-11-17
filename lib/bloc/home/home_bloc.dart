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
    if (event is GetHomeList || event is GetHomeRefresh) {
      try {
        yield HomeLoadingState();
        final List<HeroesModel> heroesModel =
            await apiRepository.getHeroesList();
        if (heroesModel.isNotEmpty) {
          yield HomeSuccessState(heroes: heroesModel);
        } else {
          yield HomeEmptyState();
        }
      } catch (e) {
        yield HomeErrorState(errorMessage: e.toString());
      }
    } else if (event is GetSearchByKeywordList) {
      try {
        yield HomeLoadingState();
        final List<HeroesModel> heroesModel =
            await apiRepository.getSearchHeroesByKeyword(event.keyword);
        if (heroesModel.isNotEmpty) {
          yield HomeSuccessState(heroes: heroesModel);
        } else {
          yield HomeEmptyState();
        }
      } catch (e) {
        yield HomeErrorState(errorMessage: e.toString());
      }
    } else if (event is GetSearchByAliveList) {
      try {
        yield HomeLoadingState();
        final List<HeroesModel> heroesModel = await apiRepository
            .getSearchHeroesByAlive(event.startYear, event.endYear);
        if (heroesModel.isNotEmpty) {
          yield HomeSuccessState(heroes: heroesModel);
        } else {
          yield HomeEmptyState();
        }
      } catch (e) {
        yield HomeErrorState(errorMessage: e.toString());
      }
    } else if (event is GetSearchByBirthList) {
      try {
        yield HomeLoadingState();
        final List<HeroesModel> heroesModel = await apiRepository
            .getSearchHeroesByBirth(event.startYear, event.endYear);
        if (heroesModel.isNotEmpty) {
          yield HomeSuccessState(heroes: heroesModel);
        } else {
          yield HomeEmptyState();
        }
      } catch (e) {
        yield HomeErrorState(errorMessage: e.toString());
      }
    } else if (event is GetSearchByDeathList) {
      try {
        yield HomeLoadingState();
        final List<HeroesModel> heroesModel = await apiRepository
            .getSearchHeroesByDeath(event.startYear, event.endYear);
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
}
