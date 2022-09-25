part of 'info_bloc.dart';

@immutable
abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class LoadInfo extends InfoEvent {
  @override
  List<Object> get props => [];
}
