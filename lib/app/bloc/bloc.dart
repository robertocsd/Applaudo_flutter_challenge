// ignore_for_file: unused_local_variable

import 'package:applaudo_tech_challenge_flutter/app/model/todo.dart';
import 'package:applaudo_tech_challenge_flutter/app/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super((MenuInitial(Model(pageSelected: 0, todos: const [])))) {
    on<OnChangePage>((event, emit) {
      emit(MenuChangedState(
          state.model.copyWith(pageSelected: event.pageSelected)));
    });
    on<NewTodoEvent>(_newTodoEvent);
    on<ChangingTitle>(_changingTitle);
    on<DeletingAToDoEvent>(_completingAToDo);
    on<EditAToDoEvent>(_editAToDo);
    on<ChangeState>(_convertToCompleted);
    on<CheckingEmptyEvent>(_checkingEmpty);
    on<MarkAllCompletedEvent>(_markAllCompleted);
  }

  _newTodoEvent(NewTodoEvent event, Emitter<ToDoState> emit) {
    emit(LoadingState(state.model));
    List<ToDoModel> todos = state.model.todos;

    try {
      var res = Repository().postTodo(state.model.title!);

      todos.add(ToDoModel(
          title: state.model.title!,
          id: DateTime.now().millisecondsSinceEpoch,
          type: false));
      emit((RefreshState(state.model)));
      emit(NewToDoState(
          state.model.copyWith(todos: todos, pageSelected: 0, title: '')));
      add(const CheckingEmptyEvent());
    } catch (e) {
      emit(ErrorState(state.model));
    }
  }

  _changingTitle(ChangingTitle event, Emitter<ToDoState> emit) {
    emit(TitleChanged(
        state.model.copyWith(title: event.title, pageSelected: 0)));
  }

  _completingAToDo(DeletingAToDoEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos;
    todos.removeWhere((todo) => todo.id == event.id);

    emit(DeletedState(state.model.copyWith(todos: todos)));
    add(const CheckingEmptyEvent());
  }

  _editAToDo(EditAToDoEvent event, Emitter<ToDoState> emit) {
//we have a lower cost in Dart elements when the BlocBuilder renders again
    List<ToDoModel> todos = state.model.todos;
    ToDoModel todo = todos.firstWhere((todo) => todo.id == event.id);
    todo.title = event.title;
    todos[todos.indexWhere((element) => element.id == todo.id)] = todo;
    emit(EditedState(
        state.model.copyWith(todos: todos, pageSelected: 0, title: '')));
    add(const CheckingEmptyEvent());
  }

  _convertToCompleted(ChangeState event, Emitter<ToDoState> emit) {
//we have a lower cost in Dart elements when the BlocBuilder renders again
    List<ToDoModel> todos = state.model.todos;
    ToDoModel todo = todos.firstWhere((todo) => todo.id == event.id);
    todo.type = event.type;
    todos[todos.indexWhere((element) => element.id == todo.id)] = todo;
    emit(RefreshState(state.model));
    emit(ConvertToCompletedState(
        state.model.copyWith(todos: todos, pageSelected: 0)));
    add(const CheckingEmptyEvent());
  }

  _checkingEmpty(CheckingEmptyEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos;
    int countLeft = 0;
    int countDone = 0;

    for (ToDoModel todo in todos) {
      if (todo.type) {
        countDone++;
      } else {
        countLeft++;
      }
    }

    emit(CheckedEmptyState(
        state.model.copyWith(completed: countDone, pending: countLeft)));
  }

  _markAllCompleted(MarkAllCompletedEvent event, Emitter<ToDoState> emit) {
    List<ToDoModel> todos = state.model.todos;
    for (ToDoModel todo in todos) {
      todo.type = true;
    }
    emit(RefreshState(state.model));
    emit(AllCompleted(state.model.copyWith(todos: todos, pageSelected: 1)));
    add(const CheckingEmptyEvent());
  }
}
