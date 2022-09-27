part of 'top_bloc.dart';

@immutable
abstract class TopEvent extends Equatable {
  const TopEvent();
}

class LoadTop extends TopEvent {
  @override
  List<Object> get props => [];
}
