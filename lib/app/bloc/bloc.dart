import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(const MenuInitial(Model(pageSelected: 0))) {
    on<OnChangePage>((event, emit) {
      emit(MenuChangedState(
          state.model.copyWith(pageSelected: event.pageSelected)));
    });
  }
}
