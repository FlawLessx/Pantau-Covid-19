part of 'fetch_data_bloc.dart';

abstract class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

class FetchDataInitial extends FetchDataState {}

class FetchDataLoading extends FetchDataState {}

class FetchDataLoaded extends FetchDataState {
  final List<Global> listDataGlobal;
  final GlobalTotal dataGlobalTotal;
  final List<Provinsi> listDataProvinsi;
  final Indo dataIndoTotal;

  FetchDataLoaded({
    @required this.listDataGlobal,
    @required this.dataGlobalTotal,
    @required this.listDataProvinsi,
    @required this.dataIndoTotal,
  });

  @override
  List<Object> get props => [];
}

class FetchDataError extends FetchDataState {
  @override
  List<Object> get props => [];
}
