part of 'global_bloc.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();
}

class GlobalInitial extends GlobalState {
  @override
  List<Object> get props => [];
}

class GlobalLoading extends GlobalState {
  @override
  List<Object> get props => [];
}

class GlobalLoaded extends GlobalState {
  final List<Global> data;
  const GlobalLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class GlobalError extends GlobalState {
  @override
  List<Object> get props => [];
}
