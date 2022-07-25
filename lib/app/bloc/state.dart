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

class ConvertToCompletedState extends ToDoState {
  const ConvertToCompletedState(Model model) : super(model);
}

class Model extends Equatable {
  final int? pageSelected;
  List<ToDoModel> todos = [];
  final String? title;

  Model({
    required this.todos,
    this.pageSelected = 0,
    this.title = '',
  });

  Model copyWith({
    int? pageSelected,
    List<ToDoModel>? todos,
    String? title,
  }) =>
      Model(
        pageSelected: pageSelected ?? this.pageSelected,
        todos: todos ?? this.todos,
        title: title ?? this.title,
      );

  @override
  List<Object?> get props => [pageSelected, todos, title];
}
