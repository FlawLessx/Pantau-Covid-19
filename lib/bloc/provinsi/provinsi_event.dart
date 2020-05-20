part of 'provinsi_bloc.dart';

abstract class ProvinsiEvent extends Equatable {
  const ProvinsiEvent();
}

class GetDataProvinsi extends ProvinsiEvent{
  @override
  List<Object> get props => [];
}

class RefreshDataProvinsi extends ProvinsiEvent{

  @override
  List<Object> get props => [];
}
