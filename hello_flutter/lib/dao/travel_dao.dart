import 'dart:async';
import 'dart:convert';
import 'package:hello_flutter/model/travel_model.dart';
import 'package:hello_flutter/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
const TravelTab_Url = 'https://www.devio.org/io/flutter_app/json/travel_page.json';
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(TravelTab_Url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('111');
    }
  }
}

var params = {
  "districtId": -1,
    "groupChannelCode": "tourphoto_global1",
    "type": null,
    "lat": -180,
    "lon": -180,
    "locatedDistrictId": 0,
    "pagePara": {
      "pageIndex": 1,
      "pageSize": 10,
      "sortType": 9,
      "sortDirection": 0
    },
    "imageCutType": 1,
    "head": {},
    "contentType": "json"
};

class TravelItemDao {
  static Future<TravelModel> fetch(String url, String groupChannelCode,int sizePage,int sizeIndex) async {
    Map paramsMap = params['pagePara'];
    params['groupChannelCode']=groupChannelCode;
    paramsMap['sizePage']=sizePage;
    paramsMap['sizeIndex']=sizeIndex;
    final response = await http.post(url,body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    } else {
      throw Exception('111');
    }
  }
}