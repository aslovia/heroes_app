import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static isReqSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300 || response.body == null) {
      return false;
    } else {
      return true;
    }
  }

  static isReqSuccessBody(String responseBody){
    Map data = json.decode(responseBody);
    if (responseBody == null || !data['success']) {
      return false;
    } else {
      return true;
    }
  }
}