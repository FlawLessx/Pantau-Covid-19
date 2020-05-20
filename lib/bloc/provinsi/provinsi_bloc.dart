import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid/model/provinsi_model.dart';
import 'package:covid/resources/repository.dart';
import 'package:equatable/equatable.dart';

part 'provinsi_event.dart';
part 'provinsi_state.dart';

class ProvinsiBloc extends Bloc<ProvinsiEvent, ProvinsiState> {
  final Repository _repository;
  ProvinsiBloc(this._repository);

  @override
  ProvinsiState get initialState => ProvinsiInitial();

  @override
  Stream<ProvinsiState> mapEventToState(
    ProvinsiEvent event,
  ) async* {
    if (event is GetDataProvinsi)
      yield* _mapGetDataProvinsiToState(event);
    else if (event is RefreshDataProvinsi) {
      yield* _mapRefreshDataProvinsiToState(event);
    }
  }

  Stream<ProvinsiState> _mapGetDataProvinsiToState(GetDataProvinsi event) async* {
    yield ProvinsiLoading();
    try {
        final data = await _repository.fetchDataProvinsi();
        yield ProvinsiLoaded(data);
      } catch (e) {
        yield ProvinsiError();
      }
  }

  Stream<ProvinsiState> _mapRefreshDataProvinsiToState(
      RefreshDataProvinsi event) async* {
   yield ProvinsiLoading();
      try {
        final data = await _repository.fetchDataProvinsi();
        yield ProvinsiLoaded(data);
      } catch (e) {
        yield state;
      }
  }
}
