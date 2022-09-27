// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:quizu/models/info_model.dart';
import 'package:quizu/repository/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final Repository repository;
  // final String toekn;
  InfoBloc(this.repository) : super(InfoLoadingState()) {
    on<LoadInfo>((event, emit) async {
      SharedPreferences sher = await SharedPreferences.getInstance();
      emit(InfoLoadingState());
      try {
        final result = await repository.infoUser(sher.getString('token'));
        // print(result);
        emit(InfoLoadedState(result));
      } catch (e) {
        emit(InfoErrorState(e.toString()));
      }
    });
  }
}
