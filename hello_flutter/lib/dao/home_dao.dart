import 'dart:async';
import 'dart:convert';
import 'package:hello_flutter/model/home_model.dart';
import 'package:http/http.dart' as http;
const Home_Url = 'https://www.devio.org/io/flutter_app/json/home_page.json';
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_Url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('111');
    }
  }
}