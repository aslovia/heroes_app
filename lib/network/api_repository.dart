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
}
