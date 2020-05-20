import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid/model/global_model.dart';
import 'package:covid/resources/repository.dart';
import 'package:equatable/equatable.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final Repository _repository;
  GlobalBloc(this._repository);

  @override
  GlobalState get initialState => GlobalInitial();

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
    if (event is GetDataGlobal)
      yield* _mapGetDataGlobalToState(event);
    else if (event is RefreshDataGlobal)
      yield* _mapRefreshDataGlobalToState(event);
  }

  Stream<GlobalState> _mapGetDataGlobalToState(GetDataGlobal event) async* {
    yield GlobalLoading();
    try {
      final data = await _repository.fetchDataGlobal();
      if (data != null) print('global success');
      yield GlobalLoaded(data);
    } catch (e) {
      print(e);
      yield GlobalError();
    }
  }

  Stream<GlobalState> _mapRefreshDataGlobalToState(RefreshDataGlobal event) async* {
    yield GlobalLoading();
    try {
      final data = await _repository.fetchDataGlobal();
      if (data != null) print('refresh global success');
      yield GlobalLoaded(data);
    } catch (e) {
      yield state;
    }
  }
}
