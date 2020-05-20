part of 'globaltotal_bloc.dart';

abstract class GlobaltotalState extends Equatable {
  const GlobaltotalState();
}

class GlobaltotalInitial extends GlobaltotalState {
  @override
  List<Object> get props => [];
}

class GlobaltotalLoading extends GlobaltotalState {
  @override
  List<Object> get props => [];
}


class GlobalTotalLoaded extends GlobaltotalState {
  final GlobalTotal dataGlobal;
  const GlobalTotalLoaded(this.dataGlobal);

  @override
  List<Object> get props => [dataGlobal];
}

class GlobaltotalError extends GlobaltotalState {
  @override
  List<Object> get props => [];
}
