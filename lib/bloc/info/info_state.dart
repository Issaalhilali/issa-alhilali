part of 'info_bloc.dart';

@immutable
abstract class InfoState extends Equatable {}

class InfoLoadingState extends InfoState {
  @override
  List<Object> get props => [];
}

class InfoLoadedState extends InfoState {
  final InfoModel data;
  InfoLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class InfoErrorState extends InfoState {
  final String error;
  InfoErrorState(this.error);

  @override
  List<Object> get props => [error];
}
