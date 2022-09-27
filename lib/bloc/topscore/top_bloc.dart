// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:quizu/models/topmode.dart';
import 'package:quizu/repository/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'top_event.dart';
part 'top_state.dart';

class TopBloc extends Bloc<TopEvent, TopState> {
  final APIService repository;
  // final String toekn;
  TopBloc(this.repository) : super(TopLoadingState()) {
    on<LoadTop>((event, emit) async {
      SharedPreferences sher = await SharedPreferences.getInstance();
      emit(TopLoadingState());
      try {
        final result = await APIService.gettopscore(sher.getString('token'));
        // print(result);
        emit(TopLoadedState(result));
      } catch (e) {
        emit(TopErrorState(e.toString()));
      }
    });
  }
}
