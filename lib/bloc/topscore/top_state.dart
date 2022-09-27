part of 'top_bloc.dart';

@immutable
abstract class TopState extends Equatable {}

class TopLoadingState extends TopState {
  @override
  List<Object> get props => [];
}

class TopLoadedState extends TopState {
  final List<TopModel> data;
  TopLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class TopErrorState extends TopState {
  final String error;
  TopErrorState(this.error);

  @override
  List<Object> get props => [error];
}
