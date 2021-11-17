import 'package:http/http.dart' as http;

class ApiHelper {
  final String baseUrl = "https://indonesia-public-static-api.vercel.app/api";

  Future getHeroesList() async {
    var response = await http.get(Uri.parse("$baseUrl/heroes"));
    return response;
  }

  Future getSearchHeroesByKeyword(String keyword) async {
    var response = await http.get(Uri.parse("$baseUrl/heroes?q=$keyword"));
    return response;
  }

  Future getSearchHeroesByAlive(String startYear, String endYear) async {
    var response = await http.get(Uri.parse(
        "$baseUrl/heroes?alive_in_start=$startYear&alive_in_end=$endYear"));
    return response;
  }

  Future getSearchHeroesByBirth(String startYear, String endYear) async {
    var response = await http.get(Uri.parse(
        "$baseUrl/heroes?birth_year_start=$startYear&birth_year_end=$endYear"));
    return response;
  }
}
