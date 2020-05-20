part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();
}

class GetDataGlobal extends GlobalEvent{
  @override
  List<Object> get props => [];
}

class RefreshDataGlobal extends GlobalEvent{
  @override
  List<Object> get props => [];
}
