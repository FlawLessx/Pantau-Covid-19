part of 'indo_bloc.dart';

abstract class IndoState extends Equatable {
  const IndoState();
}

class IndoInitial extends IndoState {
  @override
  List<Object> get props => [];
}

class IndoLoading extends IndoState {
  @override
  List<Object> get props => [];
}

class IndoLoaded extends IndoState {
  final Indo dataIndo;
  const IndoLoaded(this.dataIndo);

  @override
  List<Object> get props => [dataIndo];
}

class IndoError extends IndoState {
  @override
  List<Object> get props => [];
}


