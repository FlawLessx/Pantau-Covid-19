import 'package:covid/model/globalTotal_model.dart';
import 'package:covid/model/global_model.dart';
import 'package:covid/model/indo_model.dart';
import 'package:covid/model/provinsi_model.dart';
import 'package:covid/resources/apiProvider.dart';

class Repository{
  final apiProvider = ApiProvider();

  Future<List<Indo>> fetchDataIndo() => apiProvider.fetchDataIndo();
  Future<List<Provinsi>> fetchDataProvinsi() => apiProvider.fetchDataProvinsi();
  Future<GlobalTotal> fetchDataGlobalTotal() => apiProvider.fetchDataGlobalTotal();
  Future<List<Global>> fetchDataGlobal() => apiProvider.fetchDataGlobal();
}