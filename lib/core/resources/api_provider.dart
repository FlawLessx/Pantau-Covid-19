import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;

import '../model/global_model.dart';
import '../model/global_total_model.dart';
import '../model/indo_model.dart';
import '../model/provinsi_model.dart';

class ApiProvider {
  Client client = Client();
  final _urlIndo = 'https://api.kawalcorona.com/indonesia';
  final _urlProvinsi = 'https://api.kawalcorona.com/indonesia/provinsi';
  final _urlGlobal =
      'http://api.coronatracker.com/v3/stats/worldometer/country';
  final _urlGlobalTotal = 'https://coronavirus-19-api.herokuapp.com/all';

  Future<List<Indo>> fetchDataIndo() async {
    final response = await client.get(_urlIndo);
    if (response.statusCode == 200)
      return compute(indoFromJson, response.body);
    else
      throw Exception();
  }

  Future<List<Provinsi>> fetchDataProvinsi() async {
    final response = await client.get(_urlProvinsi);
    if (response.statusCode == 200)
      return compute(provinsiFromJson, response.body);
    else
      throw Exception();
  }

  Future<List<Global>> fetchDataGlobal() async {
    try {
      final response = await client.get(_urlGlobal);
      return compute(globalFromJson, response.body);
    } catch (e) {
      throw Exception();
    }
  }

  Future<GlobalTotal> fetchDataGlobalTotal() async {
    final response = await client.get(_urlGlobalTotal);
    if (response.statusCode == 200)
      return compute(globalTotalFromJson, response.body);
    else
      throw Exception();
  }
}
