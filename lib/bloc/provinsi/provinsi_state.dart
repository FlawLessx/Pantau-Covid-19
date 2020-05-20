part of 'provinsi_bloc.dart';

abstract class ProvinsiState extends Equatable {
  const ProvinsiState();
}

class ProvinsiInitial extends ProvinsiState {
  @override
  List<Object> get props => [];
}

class ProvinsiLoading extends ProvinsiState {

  @override
  List<Object> get props => [];
}

class ProvinsiLoaded extends ProvinsiState {
  final List<Provinsi> dataProvinsi;
  const ProvinsiLoaded(this.dataProvinsi);

  @override
  List<Object> get props => [dataProvinsi];
}

class ProvinsiError extends ProvinsiState {

  @override
  List<Object> get props => [];
}
