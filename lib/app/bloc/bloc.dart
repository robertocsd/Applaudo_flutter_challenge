import 'dart:async';

import 'package:applaudo_tech_challenge_flutter/app/model/todo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(MenuInitial(Model(pageSelected: 0, todos: []))) {
    on<OnChangePage>((event, emit) {
      emit(MenuChangedState(
          state.model.copyWith(pageSelected: event.pageSelected)));
    });
    on<NewTodoEvent>(_newTodoEvent);
    on<ChangingTitle>(_changingTitle);
    on<DeletingAToDoEvent>(_completingAToDo);
  }

  _newTodoEvent(NewTodoEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos ?? [];

    todos.add(ToDoModel(
        title: state.model.title!,
        id: DateTime.now().millisecondsSinceEpoch,
        type: false));

    emit(MenuChangedState(state.model.copyWith(todos: todos, pageSelected: 0)));
    print(state.model.todos.toString());
  }

  _changingTitle(ChangingTitle event, Emitter<ToDoState> emit) {
    print(state.model.pageSelected);

    print(state.model.todos.toString());
    emit(TitleChanged(
        state.model.copyWith(title: event.title, pageSelected: 0)));
    print(state.model.title.toString());
  }

  _completingAToDo(DeletingAToDoEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos ?? [];
    todos.removeWhere((todo) => todo.id == event.id);
    emit(MenuChangedState(state.model.copyWith(todos: todos, pageSelected: 0)));

    emit(DeletedState(state.model.copyWith(todos: todos, pageSelected: 0)));
  }
}
