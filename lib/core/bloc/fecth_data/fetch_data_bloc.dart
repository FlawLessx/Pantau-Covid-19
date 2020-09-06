import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/global_model.dart';
import '../../model/global_total_model.dart';
import '../../model/indo_model.dart';
import '../../model/provinsi_model.dart';
import '../../resources/repository.dart';

part 'fetch_data_event.dart';
part 'fecth_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  final Repository _repository;
  FetchDataBloc(this._repository);

  @override
  FetchDataState get initialState => FetchDataInitial();

  @override
  Stream<FetchDataState> mapEventToState(
    FetchDataEvent event,
  ) async* {
    if (event is GetDataFromAPI) yield* _mapGetDataFromAPIToState(event);
  }

  Stream<FetchDataState> _mapGetDataFromAPIToState(
      FetchDataEvent event) async* {
    yield FetchDataLoading();
    try {
      List<Global> listDataGlobal = await _repository.fetchDataGlobal();
      GlobalTotal dataGlobalTotal = await _repository.fetchDataGlobalTotal();
      List<Provinsi> listDataProvinsi = await _repository.fetchDataProvinsi();
      final tempDataIndo = await _repository.fetchDataIndo();
      Indo dataIndoTotal = tempDataIndo[0];

      yield FetchDataLoaded(
          listDataGlobal: listDataGlobal,
          dataGlobalTotal: dataGlobalTotal,
          listDataProvinsi: listDataProvinsi,
          dataIndoTotal: dataIndoTotal);
    } on Exception {
      yield FetchDataError();
    }
  }
}
