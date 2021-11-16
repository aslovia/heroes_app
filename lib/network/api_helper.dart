import 'package:http/http.dart' as http;

class ApiHelper {
  final String baseUrl = "https://indonesia-public-static-api.vercel.app/api";

  Future getHeroesList() async {
    var response = await http.get(Uri.parse("$baseUrl/heroes"));
    return response;
  }

  Future getSearchHeroesByKeyword(String keyword) async {
    var response = await http.get(Uri.parse("$baseUrl/heroes?q=$keyword"));
    print("ini keyword " + response.body);
    return response;
  }
}
