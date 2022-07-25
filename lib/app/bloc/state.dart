// ignore_for_file: must_be_immutable

part of 'bloc.dart';

abstract class ToDoState extends Equatable {
  final Model model;
  const ToDoState(this.model);

  @override
  List<Object> get props => [model];
}

class MenuInitial extends ToDoState {
  const MenuInitial(Model model) : super(model);
}

class MenuChangedState extends ToDoState {
  const MenuChangedState(Model model) : super(model);
}

class TitleChanged extends ToDoState {
  const TitleChanged(Model model) : super(model);
}

class DeletedState extends ToDoState {
  const DeletedState(Model model) : super(model);
}

class EditedState extends ToDoState {
  const EditedState(Model model) : super(model);
}

class ConvertToCompletedState extends ToDoState {
  const ConvertToCompletedState(Model model) : super(model);
}

class RefreshState extends ToDoState {
  const RefreshState(Model model) : super(model);
}

class NewToDoState extends ToDoState {
  const NewToDoState(Model model) : super(model);
}

class ErrorState extends ToDoState {
  const ErrorState(Model model) : super(model);
}

class LoadingState extends ToDoState {
  const LoadingState(Model model) : super(model);
}

class AllCompleted extends ToDoState {
  const AllCompleted(Model model) : super(model);
}

class CheckedEmptyState extends ToDoState {
  const CheckedEmptyState(Model model) : super(model);
}

class Model extends Equatable {
  final int? pageSelected;
  List<ToDoModel> todos = [];
  final String? title;
  final int? pending;
  final int? completed;

  Model({
    required this.todos,
    this.pageSelected = 0,
    this.title = '',
    this.pending = 0,
    this.completed = 0,
  });

  Model copyWith({
    int? pageSelected,
    List<ToDoModel>? todos,
    String? title,
    int? pending,
    int? completed,
  }) =>
      Model(
        pageSelected: pageSelected ?? this.pageSelected,
        todos: todos ?? this.todos,
        title: title ?? this.title,
        pending: pending ?? this.pending,
        completed: completed ?? this.completed,
      );

  @override
  List<Object?> get props => [pageSelected, todos, title, pending, completed];
}
