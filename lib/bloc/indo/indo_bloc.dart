import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid/model/indo_model.dart';
import 'package:covid/resources/repository.dart';
import 'package:equatable/equatable.dart';

part 'indo_event.dart';
part 'indo_state.dart';

class IndoBloc extends Bloc<IndoEvent, IndoState> {
  final Repository _repository;
  IndoBloc(this._repository);

  @override
  IndoState get initialState => IndoInitial();

  @override
  Stream<IndoState> mapEventToState(
    IndoEvent event,
  ) async* {
    if (event is GetDataIndo)
      yield* _mapGetDataIndoToState(event);
    else if (event is RefreshDataIndo) yield* _mapRefreshDataIndoToState(event);
  }

  Stream<IndoState> _mapGetDataIndoToState(GetDataIndo event) async* {
    yield IndoLoading();
     try {
        List<Indo> data = await _repository.fetchDataIndo();
        Indo result = data[0];
        yield IndoLoaded(result);
      } on Exception {
        yield IndoError();
      }
  }

  Stream<IndoState> _mapRefreshDataIndoToState(RefreshDataIndo event) async* {
    yield IndoLoading();
    try {
        List<Indo> data = await _repository.fetchDataIndo();
        Indo result = data[0];
        yield IndoLoaded(result);
      } on Exception {
        yield state;
      }
  }
}
