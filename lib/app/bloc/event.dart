part of 'bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object> get props => [];
}

class OnChangePage extends ToDoEvent {
  final int pageSelected;

  const OnChangePage(this.pageSelected);
}

class NewTodoEvent extends ToDoEvent {
  const NewTodoEvent();
}

class ChangingTitle extends ToDoEvent {
  final String title;

  const ChangingTitle(this.title);
}

class DeletingAToDoEvent extends ToDoEvent {
  final int id;

  const DeletingAToDoEvent(this.id);
}

class EditAToDoEvent extends ToDoEvent {
  final int id;
  final String title;
  const EditAToDoEvent(this.id, this.title);
}

class ChangeState extends ToDoEvent {
  final int id;
  final bool type;
  const ChangeState(this.id, this.type);
}

class CheckingEmptyEvent extends ToDoEvent {
  const CheckingEmptyEvent();
}

class MarkAllCompletedEvent extends ToDoEvent {
  const MarkAllCompletedEvent();
}
