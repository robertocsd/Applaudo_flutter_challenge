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
