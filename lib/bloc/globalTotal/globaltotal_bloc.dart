import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid/model/globalTotal_model.dart';
import 'package:covid/resources/repository.dart';
import 'package:equatable/equatable.dart';

part 'globaltotal_event.dart';
part 'globaltotal_state.dart';

class GlobaltotalBloc extends Bloc<GlobaltotalEvent, GlobaltotalState> {
  final Repository _repository;
  GlobaltotalBloc(this._repository);

  @override
  GlobaltotalState get initialState => GlobaltotalInitial();

  @override
  Stream<GlobaltotalState> mapEventToState(
    GlobaltotalEvent event,
  ) async* {
    if (event is GetDataGlobalTotal)
      yield* _mapGetDataGlobaltotal(event);
    else if (event is RefreshDataGlobalTotal)
      yield* _mapRefreshDataGlobaltotal(event);
  }

  Stream<GlobaltotalState> _mapGetDataGlobaltotal(
      GetDataGlobalTotal event) async* {
    yield GlobaltotalLoading();
    try {
        final data = await _repository.fetchDataGlobalTotal();
        GlobalTotal result = data;
        yield GlobalTotalLoaded(result);
      } on Exception {
        yield GlobaltotalError();
      }
   
  }

  Stream<GlobaltotalState> _mapRefreshDataGlobaltotal(
      RefreshDataGlobalTotal event) async* {
     yield GlobaltotalLoading();
     try {
        final data = await _repository.fetchDataGlobalTotal();
        GlobalTotal result = data;
        yield GlobalTotalLoaded(result);
      } on Exception {
        yield state;
      }
  }
}
