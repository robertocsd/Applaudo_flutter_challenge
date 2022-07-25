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
    on<EditAToDoEvent>(_editAToDo);
    on<ConvertToCompletedEvent>(_convertToCompleted);
  }

  _newTodoEvent(NewTodoEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos;

    todos.add(ToDoModel(
        title: state.model.title!,
        id: DateTime.now().millisecondsSinceEpoch,
        type: false));

    emit(MenuChangedState(state.model.copyWith(todos: todos, pageSelected: 0)));
  }

  _changingTitle(ChangingTitle event, Emitter<ToDoState> emit) {

    emit(TitleChanged(
        state.model.copyWith(title: event.title, pageSelected: 0)));
  }

  _completingAToDo(DeletingAToDoEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos;
    todos.removeWhere((todo) => todo.id == event.id);
    emit(MenuChangedState(state.model.copyWith(todos: todos, pageSelected: 0)));

    emit(DeletedState(state.model.copyWith(todos: todos, pageSelected: 0)));
  }

   _editAToDo(EditAToDoEvent event, Emitter<ToDoState> emit) {

//we have a lower cost in Dart elements when the BlocBuilder renders again
    List<ToDoModel> todos = state.model.todos;
    ToDoModel todo = todos.firstWhere((todo) => todo.id == event.id);
    todo.title = event.title;
    todos[todos.indexWhere((element) => element.id == todo.id)] = todo;
    emit(DeletedState(state.model.copyWith(todos: todos, pageSelected: 0)));

  }

   _convertToCompleted(ConvertToCompletedEvent event, Emitter<ToDoState> emit) {

//we have a lower cost in Dart elements when the BlocBuilder renders again
    List<ToDoModel> todos = state.model.todos;
    ToDoModel todo = todos.firstWhere((todo) => todo.id == event.id);
    todo.type = true;
    todos[todos.indexWhere((element) => element.id == todo.id)] = todo;
    emit(DeletedState(state.model.copyWith(todos: todos, pageSelected: 0)));

  }
}
