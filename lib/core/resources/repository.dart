import '../model/global_model.dart';
import '../model/global_total_model.dart';
import '../model/indo_model.dart';
import '../model/provinsi_model.dart';
import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<List<Indo>> fetchDataIndo() => apiProvider.fetchDataIndo();
  Future<List<Provinsi>> fetchDataProvinsi() => apiProvider.fetchDataProvinsi();
  Future<GlobalTotal> fetchDataGlobalTotal() =>
      apiProvider.fetchDataGlobalTotal();
  Future<List<Global>> fetchDataGlobal() => apiProvider.fetchDataGlobal();
}
