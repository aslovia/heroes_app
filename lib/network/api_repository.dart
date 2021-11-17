import 'dart:convert';

import '../model/heroes_model.dart';

import 'network_utils.dart';
import 'app_data_manager.dart';

class ApiRepository {
  late List data;

  Future getHeroesList() async {
    var response = await appDataManager.apiHelper.getHeroesList();
    if (NetworkUtils.isReqSuccess(response)) {
      data = json.decode(response.body);
      return data.map((value) {
        return HeroesModel.fromJson(value);
      }).toList();
    } else {
      throw Exception('error getting heroes');
    }
  }

  Future getSearchHeroesByKeyword(String keyword) async {
    var response =
        await appDataManager.apiHelper.getSearchHeroesByKeyword(keyword);
    if (NetworkUtils.isReqSuccess(response)) {
      data = json.decode(response.body);
      return data.map((value) {
        return HeroesModel.fromJson(value);
      }).toList();
    } else {
      throw Exception('error getting heroes');
    }
  }

  Future getSearchHeroesByAlive(String startYear, String endYear) async {
    var response = await appDataManager.apiHelper
        .getSearchHeroesByAlive(startYear, endYear);
    if (NetworkUtils.isReqSuccess(response)) {
      data = json.decode(response.body);
      return data.map((value) {
        return HeroesModel.fromJson(value);
      }).toList();
    } else {
      throw Exception('error getting heroes');
    }
  }
}
